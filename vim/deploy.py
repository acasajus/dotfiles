#!/usr/bin/env python2

import os
import shutil
here = os.path.dirname( __file__ )

for link, target in ( ( ".vimrc", os.path.join( here, "vimrc" ) ), ( ".vim", os.path.join( here, "vim" ) ) ):
  target = os.path.realpath( target )
  link = os.path.expanduser( os.path.join( "~", link ) )
  if os.path.exists( link ):
    if os.path.islink( link ):
      if os.readlink( link ) == target:
        continue
    if os.path.isdir( link ):
      shutil.rmtree( link )
    else:
      os.unlink( link )
  print "Linking %s -> %s" % ( link, target )
  os.symlink( target, link )

for dName in ( "backups", "swaps", "undo" ):
  dName = os.path.expanduser( os.path.join( "~", ".vim", dName ) )
  if not os.path.isdir( dName ):
    os.makedirs( dName )

os.system( "git clone https://github.com/gmarik/vundle.git '%s'" % ( os.path.join( here, "vim", "bundle", "vundle" ) ) )

os.system( "vim +BundleInstall +qa" )
