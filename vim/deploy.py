#!/usr/bin/env python

import sys, os

here = os.path.dirname( os.path.realpath( __file__ ) )

vimDir = os.path.expanduser( os.path.join( "~" , ".vim" ) )
if not os.path.isdir( vimDir ):
  os.makedirs( vimDir )

print os.path.join( vimDir, ".git" )
if os.path.isdir( os.path.join( vimDir, ".git" ) ):
  print "Seems janus is already installed in %s" % vimDir
else:
  for name in ( ".vim", ".vimrc", ".gvimrc" ):
    nPath = os.path.expanduser( os.path.join( "~" , name ) )
    if os.path.isfile( nPath ):
      os.rename( nPath, "%s.old" % nPath )

  if os.system( "git clone https://github.com/carlhuda/janus.git %s" % vimDir ) != 0:
    print "Cound not clone janus into %s" % vimDir
    sys.exit( 1 )

  if os.system( "cd %s && rake" % vimDir ) != 0:
    print "Could not execute rake"

#Install custom plugins
janusDir = os.path.expanduser( os.path.join( "~" , ".janus" ) )
if not os.path.isdir( janusDir ):
  os.makedirs( janusDir )


if os.system( "git clone https://github.com/fholgado/minibufexpl.vim.git %s" % os.path.join( janusDir, "minibufexpl" ) ) != 0:
  print "Cound not clone minibufexpl into %s" % janusDir
  sys.exit( 1 )

