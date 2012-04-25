#!/usr/bin/env python

import os
import shutil
here = os.path.dirname( __file__ )

for link, target in ( ( ".vimrc", os.path.join( here, "vimrc" ) ), ( ".vim", here ) ):
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