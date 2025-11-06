#!/bin/bash

set -e

echo "🍺 Homebrew 배포 준비"
echo ""

# 1. GitHub 저장소 정보 확인
read -p "GitHub 사용자명을 입력하세요: " GITHUB_USER
read -p "저장소 이름을 입력하세요 (기본: BeforeAfterCompare): " REPO_NAME
REPO_NAME=${REPO_NAME:-BeforeAfterCompare}

# 2. 릴리스 파일 확인
if [ ! -f "release/BeforeAfterCompare-1.0.0.zip" ]; then
    echo "❌ release/BeforeAfterCompare-1.0.0.zip 파일이 없습니다."
    echo "먼저 ./build-release.sh를 실행하세요."
    exit 1
fi

# 3. SHA256 계산
SHA256=$(shasum -a 256 release/BeforeAfterCompare-1.0.0.zip | awk '{print $1}')
echo "✅ SHA256: $SHA256"

# 4. Homebrew Cask 생성
mkdir -p Casks
cat > Casks/before-after-compare.rb << EOF
cask "before-after-compare" do
  version "1.0.0"
  sha256 "${SHA256}"

  url "https://github.com/${GITHUB_USER}/${REPO_NAME}/releases/download/v#{version}/BeforeAfterCompare-#{version}.zip"
  name "Before After Compare"
  desc "제품 개선 전후 비교 이미지를 쉽게 만들 수 있는 맥 앱"
  homepage "https://github.com/${GITHUB_USER}/${REPO_NAME}"

  app "BeforeAfterCompare.app"

  zap trash: [
    "~/Library/Preferences/com.beforeaftercompare.app.plist",
    "~/Library/Saved Application State/com.beforeaftercompare.app.savedState",
  ]
end
EOF

echo "✅ Cask 생성 완료: Casks/before-after-compare.rb"
echo ""
echo "📋 다음 단계:"
echo ""
echo "1. GitHub에 저장소 생성 및 코드 푸시:"
echo "   git init"
echo "   git add ."
echo "   git commit -m 'Initial commit'"
echo "   git remote add origin https://github.com/${GITHUB_USER}/${REPO_NAME}.git"
echo "   git push -u origin main"
echo ""
echo "2. GitHub Release 생성:"
echo "   - https://github.com/${GITHUB_USER}/${REPO_NAME}/releases/new"
echo "   - Tag: v1.0.0"
echo "   - Title: v1.0.0"
echo "   - release/BeforeAfterCompare-1.0.0.zip 파일 업로드"
echo ""
echo "3. Homebrew Tap 저장소 생성:"
echo "   - 저장소 이름: homebrew-cask (또는 homebrew-tap)"
echo "   - Casks/before-after-compare.rb 파일을 해당 저장소에 푸시"
echo ""
echo "4. 설치 방법:"
echo "   # Tap 사용 (권장)"
echo "   brew tap ${GITHUB_USER}/cask"
echo "   brew install --cask before-after-compare"
echo ""
echo "   # 또는 직접 설치"
echo "   brew install --cask ${GITHUB_USER}/cask/before-after-compare"
