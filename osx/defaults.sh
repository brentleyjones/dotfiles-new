#!/usr/bin/env bash

# Sets reasonable OS X defaults.

# Quit System Preferences so it doesn't muck with your settings
osascript -e 'tell application "System Preferences" to quit'

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Menu bar: show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Don't open any apps when attaching a "camera"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Set sidebar icon size to small
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable secondary click
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Set a fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Set Touch Bar to show only app controls
defaults write com.apple.touchbar.agent PresentationModeGlobal -string "app"
defaults write com.apple.touchbar.agent PresentationModeFnModes '{
	app = fullControlStrip;
}'

# Function keys on external keyboard are shortcuts
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool false

# Remap caps-lock to escape
hidutil property --set '{
  "UserKeyMapping":[{
    "HIDKeyboardModifierMappingSrc":0x700000039,
    "HIDKeyboardModifierMappingDst":0x700000029
  }]
}' > /dev/null

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

###############################################################################
# Finder                                                                      #
###############################################################################

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.Finder NewWindowTarget -string "PfDe"
defaults write com.apple.Finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Show icons for servers and removable media on the desktop
defaults write com.apple.Finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.Finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.Finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.Finder ShowRemovableMediaOnDesktop -bool true

# Use list view in all Finder windows by default
defaults write com.apple.Finder FXPreferredViewStyle -string "Nlsv"

# Finder: show hidden files by default
defaults write com.apple.Finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.Finder ShowStatusBar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.Finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
defaults write com.apple.Finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.Finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.Finder OpenWindowForNewRemovableDisk -bool true

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.Finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.Finder WarnOnEmptyTrash -bool false

# Empty Trash securely by default
defaults write com.apple.Finder EmptyTrashSecurely -bool true

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show the ~/Library folder.
chflags nohidden ~/Library

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.Finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Dock icon size
defaults write com.apple.dock tilesize -int 32

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Put display to sleed if we're in the bottom-left/bottom-right hot corners.
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 10
defaults write com.apple.dock wvous-br-modifier -int 0

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Disable "close windows when quitting an app"
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Set Autofill rules
defaults write -app Safari AutoFillFromAddressBook -bool false
defaults write -app Safari AutoFillPasswords -bool false
defaults write -app Safari AutoFillCreditCardData -bool true
defaults write -app Safari AutoFillMiscellaneousForms -bool true

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write -app Safari AutoOpenSafeDownloads -bool false

# Hide Safari’s bookmarks bar by default
defaults write -app Safari ShowFavoritesBar -bool false

# Always show Safari's Tab Bar
defaults write -app Safari AlwaysShowTabBar -bool true

# Hide Safari’s sidebar in Top Sites
defaults write -app Safari ShowSidebarInTopSites -bool false

# Hide Safari's sidebar in new windows
defaults write -app Safari ShowSidebarInNewWindows -bool false

# Enable Safari’s debug menu
defaults write -app Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write -app Safari FindOnPageMatchesWordStartsOnly -bool false

# Enable the Develop menu and the Web Inspector in Safari
defaults write -app Safari IncludeDevelopMenu -bool true
defaults write -app Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write -app Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Customize toolbar
defaults write -app Safari "NSToolbar Configuration BrowserToolbarIdentifier-v2" -dict-add "TB Item Identifiers" '(BackForwardToolbarIdentifier,NSToolbarFlexibleSpaceItem,InputFieldsToolbarIdentifier,NSToolbarFlexibleSpaceItem,"com.agilebits.onepassword4-safari-2BUA8C4S2C onepassword",ShowDownloadsToolbarIdentifier,TabPickerToolbarIdentifier)'

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

##############################################################################
# Xcode                                                                      #
##############################################################################

defaults write com.apple.dt.Xcode DVTTextShowLineNumbers -bool true
defaults write com.apple.dt.Xcode DVTTextShowPageGuide -bool true
defaults write com.apple.dt.Xcode DVTTextPageGuideLocation -int 120
defaults write com.apple.dt.Xcode DVTTextCodeFocusOnHover -bool false
defaults write com.apple.dt.Xcode DVTTextShowFoldingSidebar -bool false
defaults write com.apple.dt.Xcode DVTTextEditorTrimWhitespaceOnlyLines -bool true

defaults write com.apple.dt.Xcode IDERecentEditorDocumentsLimit -int 30
defaults write com.apple.dt.Xcode "IDEEditorCoordinatorTarget_Click2" -string Default

defaults write com.apple.dt.Xcode IDESourceControlAutomaticallyAddNewFiles -bool false
defaults write com.apple.dt.Xcode IDESourceControlEnableSourceControl_7_1 -bool true
defaults write com.apple.dt.Xcode IDESourceControlLocalStatusCheckingEnabled -bool false
defaults write com.apple.dt.Xcode IDESourceControlRemoteStatusFetchingEnabled -bool false
defaults write com.apple.dt.Xcode IDESourceControlShowUpstreamChangesInChangeBar -bool true

defaults write com.apple.dt.Xcode IDESuppressStopBuildWarning -bool true
defaults write com.apple.dt.Xcode IDESuppressStopExecutionWarning -bool true
defaults write com.apple.dt.Xcode IDESuppressStopExecutionWarningTarget -string "IDESuppressStopExecutionWarningTargetValue_Stop"
defaults write com.apple.dt.Xcode IDESuppressStopTestWarning -bool true

defaults write com.apple.dt.Xcode IDEIndexShowLog -bool true
defaults write com.apple.dt.Xcode IDEIndexerActivityShowNumericProgress -bool true
defaults write com.apple.dt.Xcode IDEShowPrebuildLogs -bool true

defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool true
defaults write com.apple.dt.Xcode ShowDVTDebugMenu -bool true

###############################################################################
# Applications                                                                #
###############################################################################

# 1Password
defaults write -app "1Password 7" LockOnIdle -bool false
defaults write -app "1Password 7" LockOnScreenSaver -bool false
defaults write -app "1Password 7" LockOnSleep -bool false
defaults write -app "1Password 7" LockOnUserSwitch -bool false

# Kaleidoscope
defaults write -app Kaleidoscope KS2UpTextScopeViewControllerDefaultsInitialDetailControllerClassNameKey -int 1
defaults write -app Kaleidoscope KS3UpTextScopeViewControllerDefaultsInitialDetailControllerClassNameKey -int 1

# iTerm2
defaults write -app iTerm OnlyWhenMoreTabs -bool false
defaults write -app iTerm GlobalKeyMap '{
"0x19-0x60000" = {
		Action = 39;
		Text = "";
	};
	"0x7f-0x80000-0x33" = {
		Action = 11;
		Label = "";
		Text = 0x17;
	};
	"0x9-0x40000" = {
		Action = 32;
		Text = "";
	};
	"0xf700-0x300000" = {
		Action = 7;
		Text = "";
	};
	"0xf701-0x300000" = {
		Action = 6;
		Text = "";
	};
	"0xf702-0x300000-0x7b" = {
		Action = 10;
		Label = "";
		Text = OH;
	};
	"0xf703-0x300000-0x7c" = {
		Action = 10;
		Label = "";
		Text = OF;
	};
	"0xf729-0x100000" = {
		Action = 5;
		Text = "";
	};
	"0xf72b-0x100000" = {
		Action = 4;
		Text = "";
	};
	"0xf72c-0x100000" = {
		Action = 9;
		Text = "";
	};
	"0xf72c-0x20000" = {
		Action = 9;
		Text = "";
	};
	"0xf72d-0x100000" = {
		Action = 8;
		Text = "";
	};
	"0xf72d-0x20000" = {
		Action = 8;
		Text = "";
	};
}'

# Fantastical
defaults write -app Fantastical HideDockIcon -bool true

# iTerm 2
defaults write -app iTerm DimBackgroundWindows -bool true
defaults write -app iTerm DimInactiveSplitPanes -bool true
defaults write -app iTerm DimOnlyText -bool true
defaults write -app iTerm DisableFullscreenTransparency -bool true
defaults write -app iTerm HideTab -bool true
defaults write -app iTerm PromptOnQuit -bool false
defaults write -app iTerm SUEnableAutomaticChecks -bool true
defaults write -app iTerm SeparateStatusBarsPerPane -bool true
defaults write -app iTerm SeparateWindowTitlePerTab -bool true
defaults write -app iTerm ShowFullScreenTabBar -bool false
defaults write -app iTerm ShowPaneTitles -bool false
defaults write -app iTerm SplitPaneDimmingAmount -float 0.6
defaults write -app iTerm StatusBarPosition -int 1
defaults write -app iTerm UseBorder -bool false

# Tower
defaults write -app Tower GTUserDefaultsAlwaysAutoUpdateSubmodules -bool true
defaults write -app Tower GTUserDefaultsDefaultCloningDirectory -string "$HOME/Developer"
defaults write -app Tower GTUserDefaultsDialogueOptionCheckoutCreatedBranch -bool true
defaults write -app Tower GTUserDefaultsDialogueOptionCheckoutCreatedBranch -bool true
defaults write -app Tower GTUserDefaultsDialogueOptionCherryPickAlwaysGenerateMergeCommit -bool true
defaults write -app Tower GTUserDefaultsDialogueOptionCherryPickUseFastForward -bool true
defaults write -app Tower GTUserDefaultsDialogueOptionMergeAlwaysGenerateMergeCommit -bool false
defaults write -app Tower GTUserDefaultsDialogueOptionPullUseRebase -bool false
defaults write -app Tower GTUserDefaultsDialogueOptionPushPushAllTags -bool false
defaults write -app Tower GTUserDefaultsDialogueOptionRevertAlwaysGenerateMergeCommit -bool true
defaults write -app Tower GTUserDefaultsDiffToolIdentifier -string kaleidoscope
defaults write -app Tower GTUserDefaultsHistoryGraphCommitViewSize -int 1
defaults write -app Tower GTUserDefaultsHistoryGroupingType -int 1
defaults write -app Tower GTUserDefaultsHistoryShowGraph -bool true
defaults write -app Tower GTUserDefaultsMergeToolIdentifier -string kaleidoscope
defaults write -app Tower GTUserDefaultsSavePatchOmitPrefixes -bool false
defaults write -app Tower GTUserDefaultsSaveStashOptionIncludeUntrackedFiles -bool true
defaults write -app Tower GTUserDefaultsShowReflogInSidebar -bool true
defaults write -app Tower GTUserDefaultsShowRemoteActivityView -bool true
defaults write -app Tower GTUserDefaultsTagsSortMode -int 2
defaults write -app Tower SUAutomaticallyUpdate -bool true
defaults write -app Tower SUEnableAutomaticChecks -bool true
defaults write -app Tower SUScheduledCheckInterval -int 86400

# Tweetbot
defaults write com.tapbots.TweetbotMac OpenURLsDirectly -bool true

# Outlook

defaults write -app 'Microsoft Outlook' 'viewIndividualPrefs.Calendar Grid View' '{
	OLViewPrefCalendarViewTypeKey = OLViewPrefCalendarViewTypeWorkWeekValue;
}' || true

# Kill all affected apps

sleep 1
for app in "Activity Monitor" "cfprefsd" "Dock" "Fantastical" "Finder" "Mail" "Kaleidoscope" "Microsoft Outlook" "Safari" "Tower" "SystemUIServer"; do
	killall "${app}" > /dev/null 2>&1 || true
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
