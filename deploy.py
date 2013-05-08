#!/usr/bin/env python2

import os, pickle, re, logging, sys
try:
  from hashlib import md5
except:
  from md5 import md5

logging.basicConfig( level = logging.INFO )
#logging.basicConfig( level = logging.DEBUG )

userDataRE = re.compile( "\%\{([\w\s]+)\}" )

here = os.path.dirname( os.path.realpath( __file__ ) )

modIgnore = [ 'Terminal.app' ]
try:
  fd = open( os.path.expanduser( "~/.dotignore" ) )
  modIgnore = [ line.strip() for line in fd.readlines() if line.strip() ]
  fd.close()
except IOError:
  pass

if modIgnore:
  logging.info( "Ignoring %s modules" % ", ".join( modIgnore ) )

for module in os.listdir( here ):
  if module[0] == "." or module == "deploy.py" or module in modIgnore:
    continue
  logging.info( "Exploring %s" % module )
  modPath = os.path.join( here, module )
  #Execute module deploy if it's there
  modDeploy = os.path.join( modPath, "deploy.py" )
  if os.path.isfile( modDeploy ):
    logging.info( "Found %s/deploy.py, executing..." % module )
    if os.system( modDeploy ) != 0:
      logging.error( "Error executing %s/deploy.py. Exiting" % module )
      sys.exit( 1 )
    continue
  #Copy/link files where they are needed
  for source in os.listdir( modPath ):
    if source == "deploy.py" or source[0] == ".":
      continue
    sourcePath = os.path.join( modPath, source )
    logging.info( "Processing %s/%s" % ( module, source ) )
    if not os.path.isfile( sourcePath ) and not os.path.isdir( sourcePath ):
      logging.info( "%s is not file or dir" % sourcePath )
      continue
    destPath = os.path.expanduser( os.path.join( "~" , ".%s" % source ) )
    logging.debug( "Destination is %s" % destPath )
    if os.path.islink( destPath ):
      if sourcePath == os.readlink( destPath ):
        logging.info( "Link already set up" )
        continue
    logging.info( "Linking %s <- %s" % ( sourcePath, destPath ) )
    if os.path.exists( destPath ):
      os.unlink( destPath )
    os.symlink( sourcePath, destPath )
