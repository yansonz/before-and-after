#!/bin/bash

set -e

APP_NAME="BeforeAfterCompare"
VERSION="1.0.0"
BUILD_DIR=".build/release"
APP_BUNDLE="${APP_NAME}.app"
RELEASE_DIR="release"
DMG_NAME="${APP_NAME}-${VERSION}.dmg"

echo "🔨 Building ${APP_NAME}..."
swift build -c release

echo "📦 Creating app bundle..."
rm -rf "${APP_BUNDLE}"
mkdir -p "${APP_BUNDLE}/Contents/MacOS"
mkdir -p "${APP_BUNDLE}/Contents/Resources"

cp "${BUILD_DIR}/${APP_NAME}" "${APP_BUNDLE}/Contents/MacOS/"

if [ -f "Resources/AppIcon.icns" ]; then
    cp "Resources/AppIcon.icns" "${APP_BUNDLE}/Contents/Resources/"
fi

cat > "${APP_BUNDLE}/Contents/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>${APP_NAME}</string>
    <key>CFBundleIdentifier</key>
    <string>com.beforeaftercompare.app</string>
    <key>CFBundleName</key>
    <string>${APP_NAME}</string>
    <key>CFBundleDisplayName</key>
    <string>Before After Compare</string>
    <key>CFBundleVersion</key>
    <string>${VERSION}</string>
    <key>CFBundleShortVersionString</key>
    <string>${VERSION}</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>LSMinimumSystemVersion</key>
    <string>13.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>CFBundleIconFile</key>
    <string>AppIcon</string>
</dict>
</plist>
EOF

echo "📦 Creating distribution packages..."
mkdir -p "${RELEASE_DIR}"

# ZIP 파일 생성 (전송 안정성 최고)
ZIP_NAME="${APP_NAME}-${VERSION}.zip"
rm -f "${RELEASE_DIR}/${ZIP_NAME}"

# quarantine 속성 제거 (Gatekeeper 문제 방지)
xattr -cr "${APP_BUNDLE}"

ditto -c -k --sequesterRsrc --keepParent "${APP_BUNDLE}" "${RELEASE_DIR}/${ZIP_NAME}"

# DMG 파일 생성 (macOS 표준 배포)
rm -f "${RELEASE_DIR}/${DMG_NAME}"
rm -f "/tmp/${APP_NAME}-temp.dmg"

# 임시 DMG 생성
hdiutil create -srcfolder "${APP_BUNDLE}" \
    -volname "${APP_NAME}" \
    -fs HFS+ \
    -fsargs "-c c=64,a=16,e=16" \
    -format UDRW \
    "/tmp/${APP_NAME}-temp.dmg"

# 최종 압축 DMG로 변환
hdiutil convert "/tmp/${APP_NAME}-temp.dmg" \
    -format UDZO \
    -imagekey zlib-level=9 \
    -o "${RELEASE_DIR}/${DMG_NAME}"

rm -f "/tmp/${APP_NAME}-temp.dmg"

# 체크섬 생성
cd "${RELEASE_DIR}"
shasum -a 256 "${ZIP_NAME}" > "${ZIP_NAME}.sha256"
shasum -a 256 "${DMG_NAME}" > "${DMG_NAME}.sha256"
cd - > /dev/null

echo "✅ Build complete!"
echo "📍 ZIP (권장): ${RELEASE_DIR}/${ZIP_NAME}"
echo "📍 DMG: ${RELEASE_DIR}/${DMG_NAME}"
echo "📍 App bundle: ${APP_BUNDLE}"
echo ""
echo "💡 파일 전송 시 ZIP 파일 사용을 권장합니다."
echo "   체크섬 파일(.sha256)도 함께 전달하여 무결성을 확인하세요."
