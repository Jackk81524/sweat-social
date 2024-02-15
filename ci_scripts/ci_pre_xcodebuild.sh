#!/bin/sh

echo "Stage: PRE-Xcode Build is activated .... "

# for future reference
# https://developer.apple.com/documentation/xcode/environment-variable-reference

cd ../"Sweat Social"/

plutil -replace CLIENT_ID -string $CLIENT_ID GoogleService-Info.plist
plutil -replace REVERSED_CLIENT_ID -string $REVERSED_CLIENT_ID GoogleService-Info.plist
plutil -replace API_KEY -string $API_KEY GoogleService-Info.plist
plutil -replace GCM_SENDER_ID -string $GCM_SENDER_ID GoogleService-Info.plist
plutil -replace PLIST_VERSION -string $PLIST_VERSION GoogleService-Info.plist
plutil -replace BUNDLE_ID -string $BUNDLE_ID GoogleService-Info.plist
plutil -replace PROJECT_ID -string $PROJECT_ID GoogleService-Info.plist
plutil -replace STORAGE_BUCKET -string $STORAGE_BUCKET GoogleService-Info.plist
plutil -replace GOOGLE_APP_ID -string $GOOGLE_APP_ID GoogleService-Info.plist

plutil -p GoogleService-Info.plist

echo "Stage: PRE-Xcode Build is DONE .... "

exit 0
