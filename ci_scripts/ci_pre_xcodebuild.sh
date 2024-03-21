#!/bin/sh

echo "Stage: PRE-Xcode Build is activated .... "

# for future reference
# https://developer.apple.com/documentation/xcode/environment-variable-reference

cd "../Sweat Social/Other"

if [ ! -f GoogleService-Info.plist ]; then
    echo '<?xml version="1.0" encoding="UTF-8"?>' > GoogleService-Info.plist
    echo '<plist version="1.0">' >> GoogleService-Info.plist
    echo '<dict>' >> GoogleService-Info.plist
    echo '</dict>' >> GoogleService-Info.plist
    echo '</plist>' >> GoogleService-Info.plist
fi

plutil -insert CLIENT_ID -string $CLIENT_ID GoogleService-Info.plist
plutil -insert REVERSED_CLIENT_ID -string $REVERSED_CLIENT_ID GoogleService-Info.plist
plutil -insert API_KEY -string $API_KEY GoogleService-Info.plist
plutil -insert GCM_SENDER_ID -string $GCM_SENDER_ID GoogleService-Info.plist
plutil -insert PLIST_VERSION -string $PLIST_VERSION GoogleService-Info.plist
plutil -insert BUNDLE_ID -string $BUNDLE_ID GoogleService-Info.plist
plutil -insert PROJECT_ID -string $PROJECT_ID GoogleService-Info.plist
plutil -insert STORAGE_BUCKET -string $STORAGE_BUCKET GoogleService-Info.plist
plutil -insert GOOGLE_APP_ID -string $GOOGLE_APP_ID GoogleService-Info.plist
plutil -insert IS_ADS_ENABLED -bool NO GoogleService-Info.plist
plutil -insert IS_ANALYTICS_ENABLEDED -bool NO GoogleService-Info.plist
plutil -insert IS_APPINVITE_ENABLED -bool YES GoogleService-Info.plist
plutil -insert IS_GCM_ENABLED -bool YES GoogleService-Info.plist
plutil -insert IS_SIGNIN_ENABLED -bool YES GoogleService-Info.plist


plutil -p GoogleService-Info.plist

echo "Stage: PRE-Xcode Build is DONE .... "

exit 0
