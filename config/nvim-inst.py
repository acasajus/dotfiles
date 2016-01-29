#!/usr/bin/env python

import os
import shutil
here = os.path.dirname( __file__ )


vimDir = os.path.join( os.path.expanduser( "~" ), ".config", "nvim" )
for dName in ( "backups", "swaps", "undo", "plugins" ):
  dName = os.path.join( vimDir, dName )
  if not os.path.isdir( dName ):
    os.makedirs( dName )

vundleDir = os.path.join( vimDir, "plugins", "neobundle.vim" )
if not os.path.isdir( vundleDir ):
  os.system( "git clone https://github.com/Shougo/neobundle.vim '{}'".format( vundleDir ) )
os.system( "vim +NeoBundleInstall +qa" )

