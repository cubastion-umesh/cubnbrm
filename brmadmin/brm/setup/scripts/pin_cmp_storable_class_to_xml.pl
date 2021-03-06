#!/apps/brm/ThirdParty/perl/5.8.0/bin/perl
#=============================================================
#  @$Id: pin_cmp_storable_class_to_xml.pl /cgbubrm_main.portalbase/2 2011/06/23 10:38:48 meiyang Exp $
# 
# Copyright (c) 1999, 2011, Oracle and/or its affiliates. All rights reserved. 
#
#    This material is the confidential property of Oracle Corporation 
#    or its licensors and may be used, reproduced, stored
#    or transmitted only in accordance with a valid Oracle license or
#    sublicense agreement.
#
# Portal installation for the pin_rerate Component
#
#=============================================================

use Cwd;

# If running stand alone, without pin_setup
if ( ! ( $RUNNING_IN_PIN_SETUP eq TRUE ) )
{
   require "pin_res.pl";
   require "pin_functions.pl";
   require "../pin_setup.values";

   &ConfigureComponentCalledSeparately ( $0 );
}


#####
#
# Additional configuration after Portal processes have started
#
#####
sub configure_storable_class_to_xml_config_files {

  local( %CM ) = %MAIN_CM;
  local( %DM ) = %MAIN_DM;

   local( $Cmd );
   local( $Sep );

  if ( ! -e "$PIN_HOME/apps" ){
   mkdir ("$PIN_HOME/apps", 0755) || die "Unable to create $PIN_HOME/apps directory";
  }
  if ( ! -e "$PIN_HOME/apps/storable_class_to_xml" ){
   mkdir ("$PIN_HOME/apps/storable_class_to_xml", 0755) || die "Unable to create $PIN_HOME/apps/storable_class_to_xml directory";
  }

   open( PROPFILE, "> $PIN_HOME/apps/storable_class_to_xml/Infranet.properties" ) || die( "Can't open Infranet.properties" );
   print PROPFILE "infranet.connection=pcp://root.$DM{'db_num'}:\&aes|08|0D5E11BFDD97D2769D9B0DBFBD1BBF7E5D40C305EDF3D77DF111AAB8F781E92122\@$CM{'hostname'}:$MAIN_CM{'port'}/$DM{'db_num'} /service/admin_client 1\n";
   print PROPFILE "infranet.login.type=1\n";
   print PROPFILE "infranet.log.level=1\n";
   print PROPFILE "infranet.log.logallebuf=true\n";
   print PROPFILE "infranet.flist.tostring.enable=true\n";
   close( PROPFILE );

   chmod 0644, "$PIN_HOME/apps/storable_class_to_xml/Infranet.properties";

   &Output( fpLogFile, "Configuring $CurrentComponent...\n" );
   &Output( STDOUT, "Configuring $CurrentComponent...\n" );

   if ( $^O =~ /win/i ) {
     $header = "";    
     $Pref = "@";
     $Sep = ";";
     $wild = "\%*";
     $extension = ".bat";
   } else {
     $header = "#!/bin/sh";
     $Pref = "";
     $Sep = ":";
     $wild = "\$\@";
     $extension = "";
   }
   $Cmd = &FixSlashes($header."\n" 
		       .$Pref."$ENV{'BRM_JRE'}/bin/java -cp \"$PIN_HOME/jars/storableclasstoxml.jar".$Sep
		       ."$PIN_HOME/jars/xercesImpl.jar".$Sep
		       ."$PIN_HOME/jars/xmlParserAPIs.jar".$Sep
		       ."$PIN_HOME/jars/pcm.jar".$Sep
		       ."$PIN_HOME/jars/pcmext.jar".$Sep
		       ."$PIN_HOME/apps/storable_class_to_xml\" com.portal.storableclasstoxml.StorableClassToXML \"$wild\"" );
   open( BATCHFILE, "> $PIN_HOME/bin/storableclasstoxml$extension" );
   print BATCHFILE $Cmd;
   close( BATCHFILE );
   chmod 0755, "$PIN_HOME/bin/storableclasstoxml$extension";

      &Output( fpLogFile, "$CurrentComponent succeussfully configured.\n" );
      &Output( STDOUT, "$CurrentComponent successfully configured.\n" );
}
