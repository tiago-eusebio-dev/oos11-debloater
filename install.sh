##########################################################################################
#
# Magisk Module Installer Script
#
##########################################################################################
##########################################################################################
#
# Instructions:
#
# 1. Place your files into system folder (delete the placeholder file)
# 2. Fill in your module's info into module.prop
# 3. Configure and implement callbacks in this file
# 4. If you need boot scripts, add them into common/post-fs-data.sh or common/service.sh
# 5. Add your additional or modified system properties into common/system.prop
#
##########################################################################################

##########################################################################################
# Config Flags
##########################################################################################

# Set to true if you do *NOT* want Magisk to mount
# any files for you. Most modules would NOT want
# to set this flag to true
SKIPMOUNT=false

# Set to true if you need to load system.prop
PROPFILE=false

# Set to true if you need post-fs-data script
POSTFSDATA=false

# Set to true if you need late_start service script
LATESTARTSERVICE=false

##########################################################################################
# Replace list
##########################################################################################

# List all directories you want to directly replace in the system
# Check the documentations for more info why you would need this

# Construct your list in the following format
# This is an example
REPLACE_EXAMPLE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

# Construct your own list here
REPLACE="
/system/app/BasicDreams
/system/app/BookmarkProvider
/system/app/BTtestmode
/system/app/By_3rd_FBAppManagerOverSeas
/system/app/By_3rd_NetflixActivationOverSeas
/system/app/By_3rd_NetflixStubOverSeas
/system/app/By_3rd_PlayAutoInstallConfigOverSeas
/system/app/CompanionDeviceManager
/system/app/EasterEgg
/system/app/GooglePrintRecommendationService
/system/app/HTMLViewer
/system/app/PartnerBookmarksProvider
/system/app/SoterService
/system/app/Stk
/system/app/Traceur
/system/app/YTMusic
/system/system_ext/app/EngSpecialTest
/system/system_ext/app/NFCTestMode
/system/system_ext/app/oem_tcma
/system/system_ext/app/OemAutoTestServer
/system/system_ext/app/OPBackup
/system/system_ext/app/OPBreathMode
/system/system_ext/app/OPBugReportLite
/system/system_ext/app/OPCommonLogTool
/system/system_ext/app/OPDeskClock
/system/system_ext/app/OPFilemanager
/system/system_ext/app/OPPush
/system/system_ext/app/OPSesAuthentication
/system/system_ext/app/PhotosOnline
/system/system_ext/app/SensorTestTool
/system/system_ext/app/uimremoteclient
/system/system_ext/app/uimremoteserver
/system/priv-app/BuiltInPrintService
/system/priv-app/By_3rd_FBInstallOverSeas
/system/priv-app/By_3rd_FBServicesOverSeas
/system/priv-app/CallLogBackup
/system/priv-app/FilesGoogle
/system/priv-app/QualcommVoiceActivation
/system/priv-app/SharedStorageBackup
/system/priv-app/TagGoogle
/system/product/app/Account
/system/product/app/Duo
/system/product/app/GoogleLocationHistory
/system/product/app/GoogleTTS
/system/product/app/talkback
/system/product/app/Videos
/system/product/app/YouTube
/system/product/app/YTMusic
/system/product/priv-app/GoogleRestore
/system/product/priv-app/HotwordEnrollmentOKGoogleHEXAGON
/system/product/priv-app/StorageManager
/system/product/priv-app/Turbo
/system/vendor/app/CneApp
/system/system_ext/priv-app/GoogleFeedback
/system/system_ext/priv-app/OnePlusGallery
/system/system_ext/priv-app/OnePlusPods
/system/system_ext/priv-app/OPContacts
/system/system_ext/priv-app/OpLogkit
/system/system_ext/priv-app/OPMms
/system/system_ext/priv-app/StorageManager
/system_ext/app/EngSpecialTest
/system_ext/app/NFCTestMode
/system_ext/app/oem_tcma
/system_ext/app/OemAutoTestServer
/system_ext/app/OPBackup
/system_ext/app/OPBreathMode
/system_ext/app/OPBugReportLite
/system_ext/app/OPCommonLogTool
/system_ext/app/OPDeskClock
/system_ext/app/OPFilemanager
/system_ext/app/OPPush
/system_ext/app/OPSesAuthentication
/system_ext/app/PhotosOnline
/system_ext/app/SensorTestTool
/system_ext/app/uimremoteclient
/system_ext/app/uimremoteserver
/system_ext/priv-app/GoogleFeedback
/system_ext/priv-app/OnePlusGallery
/system_ext/priv-app/OnePlusPods
/system_ext/priv-app/OPContacts
/system_ext/priv-app/OpLogkit
/system_ext/priv-app/OPMms
/system_ext/priv-app/StorageManager
/product/app/Account
/product/app/Duo
/product/app/GoogleLocationHistory
/product/app/GoogleTTS
/product/app/talkback
/product/app/Videos
/product/app/YouTube
/product/app/YTMusic
/product/priv-app/GoogleRestore
/product/priv-app/HotwordEnrollmentOKGoogleHEXAGON
/product/priv-app/StorageManager
/product/priv-app/Turbo
/vendor/app/CneApp
"

# /system/product/priv-app/HotwordEnrollmentXGoogleHEXAGON
# /product/priv-app/HotwordEnrollmentXGoogleHEXAGON

##########################################################################################
#
# Function Callbacks
#
# The following functions will be called by the installation framework.
# You do not have the ability to modify update-binary, the only way you can customize
# installation is through implementing these functions.
#
# When running your callbacks, the installation framework will make sure the Magisk
# internal busybox path is *PREPENDED* to PATH, so all common commands shall exist.
# Also, it will make sure /data, /system, and /vendor is properly mounted.
#
##########################################################################################
##########################################################################################
#
# The installation framework will export some variables and functions.
# You should use these variables and functions for installation.
#
# ! DO NOT use any Magisk internal paths as those are NOT public API.
# ! DO NOT use other functions in util_functions.sh as they are NOT public API.
# ! Non public APIs are not guranteed to maintain compatibility between releases.
#
# Available variables:
#
# MAGISK_VER (string): the version string of current installed Magisk
# MAGISK_VER_CODE (int): the version code of current installed Magisk
# BOOTMODE (bool): true if the module is currently installing in Magisk Manager
# MODPATH (path): the path where your module files should be installed
# TMPDIR (path): a place where you can temporarily store files
# ZIPFILE (path): your module's installation zip
# ARCH (string): the architecture of the device. Value is either arm, arm64, x86, or x64
# IS64BIT (bool): true if $ARCH is either arm64 or x64
# API (int): the API level (Android version) of the device
#
# Availible functions:
#
# ui_print <msg>
#     print <msg> to console
#     Avoid using 'echo' as it will not display in custom recovery's console
#
# abort <msg>
#     print error message <msg> to console and terminate installation
#     Avoid using 'exit' as it will skip the termination cleanup steps
#
# set_perm <target> <owner> <group> <permission> [context]
#     if [context] is empty, it will default to "u:object_r:system_file:s0"
#     this function is a shorthand for the following commands
#       chown owner.group target
#       chmod permission target
#       chcon context target
#
# set_perm_recursive <directory> <owner> <group> <dirpermission> <filepermission> [context]
#     if [context] is empty, it will default to "u:object_r:system_file:s0"
#     for all files in <directory>, it will call:
#       set_perm file owner group filepermission context
#     for all directories in <directory> (including itself), it will call:
#       set_perm dir owner group dirpermission context
#
##########################################################################################
##########################################################################################
# If you need boot scripts, DO NOT use general boot scripts (post-fs-data.d/service.d)
# ONLY use module scripts as it respects the module status (remove/disable) and is
# guaranteed to maintain the same behavior in future Magisk releases.
# Enable boot scripts by setting the flags in the config section above.
##########################################################################################

# Set what you want to display when installing your module

print_modname() {
  ui_print "*******************************"
  ui_print "         OOS Debloater         "
  ui_print "           v20220206           "
  ui_print "         By tfae @ XDA         "
  ui_print "*******************************"
}

# Copy/extract your module files into $MODPATH in on_install.

on_install() {
  # The following is the default implementation: extract $ZIPFILE/system to $MODPATH
  # Extend/change the logic to whatever you want
  ui_print "- Extracting module files"
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
}

# Only some special files require specific permissions
# This function will be called after on_install is done
# The default permissions should be good enough for most cases

set_permissions() {
  # The following is the default rule, DO NOT remove
  set_perm_recursive $MODPATH 0 0 0755 0644

  # Here are some examples:
  # set_perm_recursive  $MODPATH/system/lib       0     0       0755      0644
  # set_perm  $MODPATH/system/bin/app_process32   0     2000    0755      u:object_r:zygote_exec:s0
  # set_perm  $MODPATH/system/bin/dex2oat         0     2000    0755      u:object_r:dex2oat_exec:s0
  # set_perm  $MODPATH/system/lib/libart.so       0     0       0644
}

# You can add more functions to assist your custom script code
