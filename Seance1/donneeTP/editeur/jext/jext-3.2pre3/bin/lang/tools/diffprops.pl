#!/usr/bin/perl -w
#Subs

sub extractProps {
  #This code is buggy because it doesn't see if something is inside HTML comments.
  open IN, "$_[0]";
  open OUT, ">$_[1]";
  @lines = ();
  while (<IN>) {
    if(/^.*<property(\s+)name="(.*)" value=".*/) {
      $lines[@lines] = $2;
    }
  }

  @ordLines = sort @lines;
  $" = "\n"; #for print "@ordLines" to work well.
  print OUT "@ordLines";
  close IN; close OUT;
}

sub doCompareProps {
  my ($baseName, $engPath, $translPath, $language) = @_;

  &extractProps($engPath,"check/${baseName}.props.English");
  &extractProps($translPath,"check/${baseName}.props.$language");

  #Filter diff's output to make it nice.
  open DIFFPIPE, "diff check/$baseName.props.${language} check/$baseName.props.English -U0|";
  open DIFFOUT, ">diffs/propdiff.$baseName.$language";
  $removed=<DIFFPIPE>;
  $removed=<DIFFPIPE>;
  while (<DIFFPIPE>) {
    unless (m'^@@.*@@$' || /^\s*$/) {
      s/^\+/Added property: /;
      s/^-/Removed property: /;
      print DIFFOUT $_;
    }
  }
  close(DIFFPIPE);
  close(DIFFOUT);
}

sub extractMenus {
  #This code is buggy because it doesn't see if something is inside HTML comments.
  open IN, "$_[0]";
  open OUT, ">$_[1]";

  while (<IN>) {
    if (/<item/ || /<button/) {
      $picture = "";
      /action=["']([A-Za-z_\/]*)["']/ and $action=$1;
      /picture=["']([A-Za-z_\/]*)["']/ and $picture=$1;
      if ($picture) {
	print OUT "item action = '$action' -- picture = '$picture'\n";
      } else {
	print OUT "item action = '$action'\n";
      }
    } elsif (/<menu/) {
      /ID=["']([A-Za-z_\/]*)["']/;
      if($1) {
	print OUT "menu ID='$1'\n";
      } else {
	print OUT "menu with no ID\n";
      }
    } elsif (/<separator/) {
      print OUT "separator";
      /text=["']([^'"]*)["']/ && print OUT " with title"; #or "with title $1"
      #Note: here we can't use [A-Z...] as char range because the text is translated and
      #can contain strange chars.
      print OUT "\n";
    } elsif (/<submenu/) {
      print OUT "submenu\n";
    } elsif (/<recents/) {
      print OUT "recents\n";
    } elsif (/<plugins/) {
      print OUT "plugins\n";
    }
  }
  close IN; close OUT;
}

sub doCompareMenus {
  my ($baseName, $engPath, $translPath, $language) = @_;

  &extractMenus($engPath,"check/${baseName}.menu.English");
  &extractMenus($translPath,"check/${baseName}.menu.$language");

  #Filter diff's output to make it nice.
  open DIFFPIPE, "diff check/$baseName.menu.${language} check/$baseName.menu.English -U0|";
  open DIFFOUT, ">diffs/menudiff.$baseName.$language";
  $removed=<DIFFPIPE>;
  $removed=<DIFFPIPE>; #Strip initial heading
  while (<DIFFPIPE>) {
    unless (m'^@@.*@@$' || /^\s*$/) {
      s/^\+/Added: /;
      s/^-/Removed: /;
      print DIFFOUT $_;
    }
  }
  close(DIFFPIPE);
  close(DIFFOUT);
}

sub diffMainTransl {	#This is intended for jext's main files, not for plugins;
  #for them we need a different calling function, but doCompare remains the same.
  #Every parameter is the name of a translated file.
  my $origsPath='../../src/lib/org/jext';
  foreach $i (@_) {
    ( -f $i ) or next;
    my $baseName=`basename $i`;
    chomp($baseName);
    my $language=qx(basename `dirname $i`);
    chomp($language);
    ( -f "$origsPath/$baseName" ) or next;
    if ($baseName =~ /.*\.props\.xml$/) {
      &doCompareProps($baseName,"$origsPath/$baseName",$i,$language);
    } elsif ($baseName =~ /.*\.(menu|popup)\.xml$/) {
      &doCompareMenus($baseName,"$origsPath/$baseName",$i,$language);
    }
  }
}

sub diffPlugTransl {
  #Here, instead, every parameter is the name of the original file.
  my $translPath='../../bin/lang';
  foreach $i (@_) {
    ( -f $i ) or next;
    local $baseName=`basename $i`;
    chomp($baseName);
    foreach $language (@langs) {
      ( -f "$translPath/$language/$baseName" ) or next;
      &doCompareProps($baseName,$i,"$translPath/$language/$baseName",$language);
      #with plugins we have only properties to check.
    }
  }
}

sub clean {
  foreach $i (<diffs/*>) {
    ( -s $i ) || system("rm -f $i");
  }
}

sub mkdirifNeeded {
  ( -d $_[0] ) || mkdir($_[0]);
}

#------------------------
#Main program

$plugPath='../../src/plugins';#global constant.

#In bin/lang directory.
&mkdirifNeeded("diffs");
&mkdirifNeeded("check");

@langs = ();
foreach my $i (<*>) {
  if ( -d $i ) {
    unless ($i =~/(tools|diffs|check|new_tr|new_en|old_en|old_tr|CVS)/) {
      &diffMainTransl(<$i/*>);
      $langs [@langs] = $i;
    }
  }
}
&clean;

#In plugin directory.
chdir($plugPath);
&mkdirifNeeded("diffs");
&mkdirifNeeded("check");

foreach my $i (<*>) {
  if ( -d $i ) {
    unless ($i=~/CVS|diffs|check/) {
      &diffPlugTransl(<$i/*.props.xml>);
    }
  }
}
&clean;
