setenv PIN_HOME /apps/brm/brmadmin/brm
setenv PIN_LOG_DIR /apps/brm/brmadmin/brm/var
setenv PIN_LOG /apps/brm/brmadmin/brm/var
setenv LIBRARYEXTENSION  .so
setenv LIBRARYPREFIX lib

set TPSOURCE=/apps/brm/ThirdParty
if (-f $TPSOURCE/source.me.csh) then
source $TPSOURCE/source.me.csh
endif


if ( ${?PERL5LIB} ) then
  setenv PERL5LIB $PIN_HOME/lib:$TPSOURCE/perl/5.8.0/lib:$TPSOURCE/perl/5.8.0/lib/5.8.0:$TPSOURCE/perl/5.8.0/lib/site_perl:$PERL5LIB
else
  setenv PERL5LIB $PIN_HOME/lib:$TPSOURCE/perl/5.8.0/lib:$TPSOURCE/perl/5.8.0/lib/5.8.0:$TPSOURCE/perl/5.8.0/lib/site_perl
endif
if ( ${?PATH} ) then
  setenv PATH $PIN_HOME/bin:$PIN_HOME/lib:$PATH
else
  setenv PATH $PIN_HOME/bin:$PIN_HOME/lib
endif
if ( ${?LD_LIBRARY_PATH} ) then
  setenv LD_LIBRARY_PATH $PIN_HOME/lib64:$PIN_HOME/lib:$LD_LIBRARY_PATH
else
  setenv LD_LIBRARY_PATH $PIN_HOME/lib64:$PIN_HOME/lib
endif
if ( ${?LD_LIBRARY_PATH_64} ) then
  setenv LD_LIBRARY_PATH_64 $PIN_HOME/lib:$PIN_HOME/lib64:$LD_LIBRARY_PATH_64
else
  setenv LD_LIBRARY_PATH_64 $PIN_HOME/lib:$PIN_HOME/lib64
endif
if ( ${?SHLIB_PATH} ) then
  setenv SHLIB_PATH $PIN_HOME/lib:$PIN_HOME/lib64:$SHLIB_PATH
else
  setenv SHLIB_PATH $PIN_HOME/lib:$PIN_HOME/lib64
endif
if ( ${?LIBPATH} ) then
  setenv LIBPATH $TPSOURCE/perl/5.8.0/bin:$PIN_HOME/bin:$PIN_HOME/lib:$PIN_HOME/lib64:$LIBPATH
else
  setenv LIBPATH $TPSOURCE/perl/5.8.0/bin:$PIN_HOME/bin:$PIN_HOME/lib:$PIN_HOME/lib64
endif

if ( -f $PIN_HOME/ttsource.me.csh) then
   source $PIN_HOME/ttsource.me.csh
endif

