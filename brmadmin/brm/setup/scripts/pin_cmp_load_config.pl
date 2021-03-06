#!/apps/brm/ThirdParty/perl/5.8.0/bin/perl
#=============================================================
#  @$Id: pin_cmp_load_config.pl /cgbubrm_main.portalbase/2 2011/06/23 10:38:48 meiyang Exp $
# 
# Copyright (c) 1999, 2011, Oracle and/or its affiliates. All rights reserved. 
#
#    This material is the confidential property of Oracle Corporation 
#    or its licensors and may be used, reproduced, stored
#    or transmitted only in accordance with a valid Oracle license or
#    sublicense agreement.
#
# Portal installation for the load_config Component
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
# Configure pin_rerate files
#
#####
sub configure_load_config_config_files {
  local( %CM ) = %MAIN_CM;
  local( %DM ) = %MAIN_DM;

  # create directory app/load_config as needed
  if ( ! -e "$PIN_HOME/apps" ){
   mkdir ("$PIN_HOME/apps", 0755) || die "Unable to create $PIN_HOME/apps directory";
  }
  if ( ! -e "$PIN_HOME/apps/load_config" ){
   mkdir ("$PIN_HOME/apps/load_config", 0755) || die "Unable to create $PIN_HOME/apps/load_config directory";
  }

  # create directory var as needed
  if ( ! -e "$PIN_HOME/var" ){
   mkdir ("$PIN_HOME/var", 0755) || die "Unable to create $PIN_HOME/var directory";
  }
  if ( ! -e "$PIN_HOME/var/load_config" ){
   mkdir ("$PIN_HOME/var/load_config", 0755) || die "Unable to create $PIN_HOME/var/load_config directory";
  }

  my $MY_PINCONF=$PIN_HOME."/apps/load_config/".$PINCONF;
 

  &ReadIn_PinCnf( "pin_cnf_connect.pl" );
  &ReadIn_PinCnf( "pin_cnf_load_config.pl" );

  &AddArrays( \%CONNECT_PINCONF_ENTRIES, \%LOAD_CONFIG_PINCONF_ENTRIES );
  &Configure_PinCnf( $MY_PINCONF,
	             $LOAD_CONFIG_PINCONF_HEADER,
                     %LOAD_CONFIG_PINCONF_ENTRIES );
}
