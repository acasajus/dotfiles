#!/usr/bin/env python

#
# Dotployer help
#
#
#

import os
import logging

logging.basicConfig( level = logging.INFO )

class Dotployer( object ):

  def __init__( self, dotSource = False ):
    if dotSource:
      self.dotSoruce = dotSource
    else:
      me = os.path.realpath( __file__ )
      self.dotSource = os.path.dirname( me )
    self.base = os.path.join( "~", os.path.relpath( self.dotSource, os.path.expanduser( "~" ) ) )

  def __modules( self ):
    for entry in os.listdir( self.dotSource ):
      if entry == ".git":
        continue
      entryPath = os.path.join( self.dotSource, entry )
      if not os.path.isdir( entryPath ):
        continue
      yield ( entry, entryPath )

  def __linkContents( self, sourceDir, subPath = "" ):
    currentDir = os.path.join( sourceDir, subPath )
    for entry in os.listdir( currentDir ):
      if entry in ( ".git", "ploy.py" ):
        continue
      entryPath = os.path.join( currentDir, entry )
      destPath = os.path.expanduser( os.path.join( '~', subPath, entry ) )
      logging.info( destPath )
      if os.path.exists( destPath ):
        logging.info( "Deleting %s" % destPath )
      if os.path.isdir( entryPath ):
        self.__linkContents( entryPath, destPath )


  def __deployModule( self, moduleName, modulePath = False ):
    if not modulePath:
      modulePath = os.path.join( self.dotSource, moduleName )
    logging.info( "Deploying module {}".format( moduleName ) )
    postDeploy = False
    #Check for symlinks
    self.__linkContents( modulePath )

  def work( self ):
    for moduleName, modulePath in self.__modules():
      self.__deployModule( moduleName, modulePath )



if __name__ == "__main__":
  Dotployer().work()


