#!/usr/bin/env python

import os
import shutil
here = os.path.dirname( __file__ )

vimDir = os.path.join( os.path.expanduser( "~" ), ".vim" )
for dName in ( "backups", "swaps", "undo", "bundle" ):
  dName = os.path.join( vimDir, dName )
  if not os.path.isdir( dName ):
    os.makedirs( dName )

vundleDir = os.path.join( vimDir, "bundle", "vundle" )
if not os.path.isdir( vundleDir ):
  os.system( "git clone https://github.com/gmarik/vundle.git '{}'".format( vundleDir ) )
os.system( "vim +BundleInstall +qa" )

