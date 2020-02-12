/*
 * __NAME__Plugin.java - __NAME__ plugin
 * Copyright (C) 2002 __AUTHOR__
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

import java.util.Vector;

import org.jext.*;
import org.jext.gui.*;
import org.jext.options.*;

/**
 * __NAME__ is a skin plugin for the Jext java text editor.
 * @author __AUTHOR__
 */

public class __NAME__Plugin implements Plugin, SkinFactory
{
  //README
  //This is the only important method for skin plugins. It returns an array
  //of org.jext.gui.Skin. See the KLNF plugin for a more complicate implementation.
  //
  public Skin[] getSkins() {
    return new Skin[] { new GenericSkin("__NAME__Skin", "__NAME__",
	"__LAFCLASSNAME__", __NAME__Plugin.class.getClassLoader()) };
    //Note: if the L&F classes are not packed on the plugin's jar but supplied on 
    //the classpath, use instead this line:
    /*return new Skin[] { new GenericSkin("__NAME__Skin", "__NAME__",
	"__LAFCLASSNAME__") };*/
  }
    
  //All these methods should be empty for skins.
  public void createMenuItems(JextFrame parent, Vector menus, Vector menuItems) {
    // creates menu items
  }

  public void createOptionPanes(OptionsDialog parent) {
    // creates the option pane
  }

  public void start() {
    // starts the plugin
  }

  public void stop() {
    // stops the plugin
  }
}

// End of __NAME__Plugin.java
