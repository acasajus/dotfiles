#!/usr/bin/env python

import os
import shutil
here = os.path.dirname( __file__ )


vimDir = os.path.join( os.path.expanduser( "~" ), ".config", "nvim" )
for dName in ( "backups", "swaps", "undo", "plugins" ):
  dName = os.path.join( vimDir, dName )
  if not os.path.isdir( dName ):
    os.makedirs( dName )

vundleDir = os.path.join( vimDir, "plugins" )
os.system( "curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > {}/installer.sh".format( vundleDir ) )
os.system( "sh {}/installer.sh {}".format( vundleDir, vundleDir ) )
os.unlink( os.path.join( vundleDir, "installer.sh" ) )
os.system( "nvim +'call dein#install()' +qa" )

