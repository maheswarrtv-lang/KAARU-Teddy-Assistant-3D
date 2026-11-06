# KAARU Teddy 3D — Flutter Starter

This ZIP contains editable Flutter source code and a 3D teddy model asset.

## Build an APK
1. Install Flutter and Android build tools.
2. Open this folder in a Flutter project environment.
3. Run `flutter pub get`.
4. If the Android platform folder is missing, run `flutter create .`.
5. Run `flutter build apk --release`.
6. APK: `build/app/outputs/flutter-apk/app-release.apk`.

## Current status
This is a visual 3D starter project, not a finished assistant APK. The chat screen is a UI preview.
Gemini/Cloudflare chat, Tamil speech recognition, text-to-speech, reminders, and floating overlay
still need to be implemented and tested. Keep the Gemini API key in Cloudflare as a secret;
never put it in Flutter source code.

Cloudflare Worker URL currently supplied:
https://lively-snowflake-b3e1.maheswarrantv.workers.dev
The Worker must have a working `/chat` endpoint before app chat can connect.
