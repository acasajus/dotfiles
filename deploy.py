#!/usr/bin/env python

import os, pickle, re, logging, sys
try:
  from hashlib import md5
except:
  from md5 import md5

logging.basicConfig( level = logging.INFO )

userDataRE = re.compile( "\%\{([\w\s]+)\}" )

here = os.path.dirname( os.path.realpath( __file__ ) )

modIgnore = []
try:
  fd = open( os.path.expanduser( "~/.dotignore" ) )
  modIgnore = [ line.strip() for line in fd.readlines() if line.strip() ]
  fd.close()
except IOError:
  pass

if modIgnore:
  logging.info( "Ignoring %s modules" % ", ".join( modIgnore ) )

stateFile = os.path.join( here, ".dotstate" )
try:
  fd = open( stateFile )
  dotState = pickle.load( fd )
  fd.close()
except:
  dotState = {}

def getContentHash( path ):
  logging.debug( "Getting contents from %s" % path )
  pathFile = open( path )
  data = pathFile.read()
  pathFile.close()
  return ( data,  md5( data ).hexdigest() )

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
  #Copy/link files where they are needed
  for source in os.listdir( modPath ):
    if source == "deploy.py" or source[0] == ".":
      continue
    sourcePath = os.path.join( modPath, source )
    logging.info( "Processing %s/%s" % ( module, source ) )
    if not os.path.isfile( sourcePath ):
      continue
    destPath = os.path.expanduser( os.path.join( "~" , ".%s" % source ) )
    logging.debug( "Destination is %s" % destPath )
    sData, sHash = getContentHash( sourcePath )
    if os.path.islink( destPath ):
      if sourcePath == os.readlink( destPath ):
        logging.info( "Link already set up" )
        continue
    elif os.path.isfile( destPath ):
      dData, dHash = getContentHash( destPath )
      if sHash == dHash or dotState.get( sHash, "" ) == dHash :
        logging.info( "%s/%s already in sync" % ( module, source ) )
        continue
    #Need to sync the file
    #Any templating?
    logging.info( "Syncing %s to %s" % ( sourcePath, destPath ) )
    requiredData = userDataRE.findall( sData )
    if requiredData:
      logging.info( "%s/%s requires %s user info" % ( module, source, ", ".join( requiredData ) ) )
      dData = sData
      for dataPiece in requiredData:
        value = raw_input( "Value for %s -> %s? " % ( destPath, dataPiece ) )
        dData = dData.replace( "%%{%s}" % dataPiece, value )
      dHash = md5( dData ).hexdigest()
      destFile = open( destPath, "w" )
      destFile.write( dData )
      destFile.close()
      dotState[ sHash ] = dHash
    else:
      logging.info( "Linking %s <- %s" % ( sourcePath, destPath ) )
      if os.path.exists( destPath ):
        os.unlink( destPath )
      os.symlink( sourcePath, destPath )


fd = open( stateFile, "w" )
pickle.dump( dotState, fd )
fd.close()
