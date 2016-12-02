#!/usr/bin/env python

import sys
import os
import shutil


source = os.path.join( os.path.dirname( os.path.realpath( __file__ ) ), "iterm" )
target = os.path.join( os.path.expanduser("~"), ".iterm" )
if os.path.exists( target ):
  if os.path.islink( target ):
    os.unlink( target )
  elif os.path.isdir( target ):
    shutil.rmtree(target)
  else:
    os.unlink( target )
os.symlink( source, target )
