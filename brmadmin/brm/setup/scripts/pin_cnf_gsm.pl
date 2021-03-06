#=============================================================
#  @(#) % %
# 
# Copyright (c) 2005, 2009, Oracle and/or its affiliates. All rights reserved. 
#       This material is the confidential property of Oracle Corporation 
#       or its licensors and may be used, reproduced, stored
#       or transmitted only in accordance with a valid Oracle license or 
#       sublicense agreement.
#
#==============================================================


$GSM_PINCONF_HEADER  =  <<END
#************************************************************************
# Configuration File for Portal GSM Manager Facilities Module
#
#
# This configuration file is automatically installed and configured with
# default values during Portal installation. You can edit this file to:
#   -- change the default values of the entries.
#   -- disable an entry by inserting a crosshatch (#) at the start of
#        the line.
#   -- enable a commented entry by removing the crosshatch (#).
# 
# Before you make any changes to this file, save a backup copy.
#
# When editing this file, follow the instructions in each section.
# For more information on the general syntax of configuration entries,
# see "Reference Guide to Portal Configuration Files" in the Portal
# online documentation.
#************************************************************************
END
;

%GSM_MANAGER_CM_PINCONF_ENTRIES = (
  "gsm_manager_fm_required_description", <<END
#========================================================================
# gsm_manager_fm_required
#
# Required Facilities Modules (FM) configuration entries
#
# The entries below specify the required FMs that are linked to the CM when
# the CM starts. The FMs required by the CM are included in this file when
# you install Portal. 
#
# Caution: DO NOT modify these entries unless you need to change the
#          location of the shared library file. DO NOT change the order of
#          these entries, because certain modules depend on others being
#          loaded before them.
#=======================================================================
END
  , "gsm_manager_fm_required", <<END
- cm fm_module \$\{PIN_HOME\}/lib/fm_gsm\$\{LIBRARYEXTENSION\} fm_gsm_config$FM_FUNCTION_SUFFIX - pin
- cm fm_module \$\{PIN_HOME\}/lib/fm_gsm_pol\$\{LIBRARYEXTENSION\} fm_gsm_pol_config$FM_FUNCTION_SUFFIX - pin
END

);
