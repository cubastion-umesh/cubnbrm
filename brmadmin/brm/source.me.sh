TPSOURCE=/apps/brm/ThirdParty
PIN_HOME=/apps/brm/brmadmin/brm
PIN_LOG_DIR=/apps/brm/brmadmin/brm/var
PIN_LOG=/apps/brm/brmadmin/brm/var
LIBRARYEXTENSION=.so
LIBRARYPREFIX=lib

if [ -f $TPSOURCE/source.me.sh ] 
then
. $TPSOURCE/source.me.sh
fi

if [ "$PERL5LIB" = "" ]
then
  PERL5LIB=$PIN_HOME/lib:$TPSOURCE/perl/5.8.0/lib:$TPSOURCE/perl/5.8.0/lib/5.8.0:$TPSOURCE/perl/5.8.0/lib/site_perl
else
  PERL5LIB=$PIN_HOME/lib:$TPSOURCE/perl/5.8.0/lib:$TPSOURCE/perl/5.8.0/lib/5.8.0:$TPSOURCE/perl/5.8.0/lib/site_perl:$PERL5LIB
fi
if [ "$PATH" = "" ]
then
  PATH=$PIN_HOME/lib:$PIN_HOME/bin
else
  PATH=$PIN_HOME/bin:$PIN_HOME/lib:$PATH
fi
if [ "$LD_LIBRARY_PATH" = "" ]
then
  LD_LIBRARY_PATH=$PIN_HOME/lib:$PIN_HOME/lib64
else
  LD_LIBRARY_PATH=$PIN_HOME/lib:$PIN_HOME/lib64:$LD_LIBRARY_PATH
fi
if [ "$LD_LIBRARY_PATH_64" = "" ]
then
  LD_LIBRARY_PATH_64=$PIN_HOME/lib:$PIN_HOME/lib64
else
  LD_LIBRARY_PATH_64=$PIN_HOME/lib:$PIN_HOME/lib64:$LD_LIBRARY_PATH_64
fi
if [ "$SHLIB_PATH" = "" ]
then
  SHLIB_PATH=$PIN_HOME/lib:$PIN_HOME/lib64
else
  SHLIB_PATH=$PIN_HOME/lib:$PIN_HOME/lib64:$SHLIB_PATH
fi
if [ "$LIBPATH" = "" ]
then
  LIBPATH=$TPSOURCE/perl/5.8.0/bin:$PIN_HOME/bin:$PIN_HOME/lib:$PIN_HOME/lib64
else
  LIBPATH=$TPSOURCE/perl/5.8.0/bin:$PIN_HOME/bin:$PIN_HOME/lib:$PIN_HOME/lib64:$LIBPATH
fi

if [ -f $PIN_HOME/ttsource.me.sh ]
then
. $PIN_HOME/ttsource.me.sh
fi

export PIN_HOME PIN_LOG_DIR PIN_LOG LIBRARYEXTENSION LIBRARYPREFIX
export PERL5LIB PATH LD_LIBRARY_PATH SHLIB_PATH LIBPATH
