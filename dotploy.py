#!/usr/bin/env python

#
# Dotployer help
#

import os
import sys
import logging


class ModuleConf( object ):

  def __init__( self, modulePath ):
    self.__modulePath = modulePath
    self.__conf = {}
    try:
      fd = open( os.path.join( modulePath, "dotploy.cfg" ) )
      for line in fd.readlines():
        line = line.strip()
        comment = line.find( "#" )
        if comment > -1:
          line = line[0:comment]
        if not line:
          continue
        if line.find( "=" ) == -1:
          raise RuntimeError( "{}/dotploy.cfg has invalid line [{}]".format( modulePath, line ) )
        spl = [ f for f in line.split( "=" ) ]
        self.__conf[ spl[0].strip() ] = "=".join( spl[1:] ).strip()
    except IOError:
      pass

  def ignoreFiles( self ):
    return [ f for f in [ self.moduleScript(), self.postDeployScript() ] if f ]

  def moduleScript( self ):
    """
    Instead of deploying module, run this script
    """
    return self.__conf.get( "execute", "" )

  def postDeployScript( self ):
    """
    After deploying links, run this script
    """
    return self.__conf.get( "post-deploy", "" )

  def __bool( self, key, defValue ):
    return self.__conf.get( key, defValue ).lower() in ( 'true', 'yes' )

  def ignoreModule( self ):
    """
    Do not deploy this module
      By default false
    """
    return self.__bool( "ignore", "false" )

  def linkDotLevels( self ):
    """
    When linking files use '.' as a prefix for the destination for this amount of directory levels
      For instance tmux/tmux.conf -> ~/.tmux.conf when 1 and tmux/tmux.conf -> ~/tmux.conf when 0
      By default true
    """
    return int( self.__conf.get( "link_dot_levels", 1 ) )

  def includeModuleNameInLink( self ):
    """
    When linking use module name for link destination
      For instance tmux/tmux.conf -> ~/tmux/.tmux.conf when true and tmux/tmux.conf -> ~/.tmux.conf when false
      By default false
    """
    return self.__bool( "link_with_module", "false" )



class Dotployer( object ):

  def __init__( self, dotSource = False, modFilter = []):
    self.modFilter = modFilter
    if dotSource:
      self.dotSoruce = dotSource
    else:
      me = os.path.realpath( __file__ )
      self.dotSource = os.path.dirname( me )

  def __modules( self ):
    """
    Find modules in the dotfiles directory
    Modules are just subdirectories for organization purposes
    """
    for entry in sorted( os.listdir( self.dotSource ) ):
      if entry == ".git":
        continue
      entryPath = os.path.join( self.dotSource, entry )
      if not os.path.isdir( entryPath ):
        continue
      if self.modFilter and entry not in self.modFilter:
        continue
      yield entry

  def __linkContents( self, sourceDir, dotLevels = 1, linkPrefix = "", subPath = "", ignoreFiles = [] ):
    """
    Link from dotSource/moduleName to the user dir
    """
    logging.info( "Exploring {} to link".format( sourceDir ) )
    for entryName in os.listdir( sourceDir ):
      if entryName in ( '.git', 'dotploy.cfg' ):
        continue
      if entryName in ignoreFiles:
        continue
      entryPath = os.path.realpath( os.path.join( sourceDir, entryName ) )
      destBase = os.path.expanduser( os.path.join( '~', linkPrefix, subPath ) )
      if not os.path.isdir( destBase ):
        os.mkdir( destBase )
      destName = entryName
      if dotLevels > 0:
        destName = ".{}".format( entryName )
      destPath = os.path.join( destBase, destName )
      logging.debug( "Link will be {}".format( destPath ) )
      if os.path.isdir( entryPath ):
        logging.debug( "{} is a dir".format( entryPath ) )
        if os.path.exists( destPath ):
          if os.path.islink( destPath ) or  not os.path.isdir( destPath ):
            logging.debug( "Unlinking {} because it's not a dir".format( destPath ) )
            os.unlink( destPath )
            os.mkdir( destPath )
        else:
          os.mkdir( destPath )
        self.__linkContents( os.path.join( sourceDir, entryName ),
                             dotLevels - 1, "",
                             os.path.join( subPath, destName ) )
      else:
        logging.debug( "{} is a file".format( entryPath ) )
        if os.path.exists( destPath ):
          if not os.path.islink( destPath ) or os.path.realpath( destPath ) != entryPath:
            logging.info( "Deleting %s" % destPath )
            os.unlink( destPath )
            logging.info( "Linking {} <- {}".format( entryPath, destPath ) )
            os.symlink( entryPath, destPath )
        else:
          logging.info( "Linking {} <- {}".format( entryPath, destPath ) )
          os.symlink( entryPath, destPath )



  def __processModule( self, moduleName ):
    modulePath = os.path.join( self.dotSource, moduleName )
    modConf = ModuleConf( modulePath )
    if modConf.ignoreModule():
      logging.info( "Ignoring module" )
      return

    modScript = modConf.moduleScript()
    if modScript:
      modScript = os.path.join( modulePath, modScript )
      if os.system( modScript ) != 0:
        log.info( "{} failed".format( modScript ) )
        sys.exit( 1 )
      return

    if modConf.includeModuleNameInLink():
      linkPrefix = moduleName
    else:
      linkPrefix = ""

    self.__linkContents( modulePath,
                         modConf.linkDotLevels(),
                         linkPrefix,
                         ignoreFiles = modConf.ignoreFiles() )
    postDeploy = modConf.postDeployScript()
    if postDeploy:
      postDeploy = os.path.join( modulePath, postDeploy )
      if os.system( postDeploy ) != 0:
        log.info( "{} failed".format( postDeploy ) )
        sys.exit( 1 )


  def work( self ):
    for moduleName in self.__modules():
      logging.info( "Deploying module {}".format( moduleName ) )
      self.__processModule( moduleName )



if __name__ == "__main__":
  if '-d' in sys.argv:
    logging.basicConfig( level = logging.DEBUG )
  else:
    logging.basicConfig( level = logging.INFO )
  Dotployer(modFilter = sys.argv[1:]).work()


