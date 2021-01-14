#!/usr/bin/env python3

import os
import shutil
here = os.path.dirname( __file__ )


vimDir = os.path.join( os.path.expanduser( "~" ), ".config", "nvim" )
for dName in ( "backups", "swaps", "undo", "plugins" ):
  dName = os.path.join( vimDir, dName )
  if not os.path.isdir( dName ):
    os.makedirs( dName )

os.system( "curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" )
os.system( "nvim +':PlugInstall' +qa" )

