# Before After Compare

제품 개선 전후 비교 이미지를 쉽게 만들 수 있는 macOS 앱입니다.

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Platform](https://img.shields.io/badge/platform-macOS%2013.0+-lightgrey)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)

## 프로젝트 개요

Before After Compare는 제품이나 서비스의 개선 전후를 시각적으로 비교할 수 있는 이미지를 자동으로 생성하는 macOS 네이티브 앱입니다. 드래그 앤 드롭으로 간편하게 이미지를 추가하고, 설명 텍스트를 입력한 후 한 번의 클릭으로 전문적인 비교 이미지를 만들 수 있습니다.

### 주요 기능

- 🖼️ **드래그 앤 드롭** - Before/After 이미지를 간편하게 추가
- ✏️ **텍스트 설명** - 각 이미지에 설명 추가
- 🎨 **자동 레이아웃** - 좌우 배치된 비교 이미지 자동 생성
- 📏 **비율 유지** - 원본 이미지 비율 자동 조정
- 🕐 **타임스탬프** - 생성 시간 자동 기록
- 💾 **PNG 저장** - 고품질 PNG 파일로 저장

## 설치

### Homebrew (권장)

```bash
brew tap yansonz/cask
brew install --cask before-after-compare
```

### 다운로드

1. [Releases](https://github.com/yansonz/before-after-compare/releases) 페이지에서 최신 ZIP 파일 다운로드
2. ZIP 파일을 풀고 `BeforeAfterCompare.app`을 Applications 폴더로 이동
3. **첫 실행 시:** 터미널에서 `xattr -cr /Applications/BeforeAfterCompare.app` 실행
4. Applications 폴더에서 앱 실행

## 사용법

1. 앱 실행
2. **Before** 영역에 개선 전 이미지를 드래그 앤 드롭
3. **After** 영역에 개선 후 이미지를 드래그 앤 드롭
4. 각 영역에 설명 텍스트 입력
5. **비교 이미지 저장** 버튼 클릭
6. 저장 위치 선택 후 PNG 파일로 저장

## 빌드 방법

### 요구사항

- macOS 13.0 이상
- Xcode 14.0 이상
- Swift 5.9 이상

### 빌드 및 실행

```bash
# 저장소 클론
git clone https://github.com/yansonz/before-after-compare.git
cd before-after-compare

# 릴리스 빌드 (ZIP, DMG 생성)
./build-release.sh

# 또는 간단한 빌드
swift build -c release

# 앱 실행
open BeforeAfterCompare.app
```

### 개발 모드 실행

```bash
# 디버그 빌드 및 실행
swift run
```

### 아이콘 생성

```bash
./generate-icon-transparent.sh
```

## 프로젝트 구조

```
BeforeAfterCompare/
├── Sources/
│   └── BeforeAfterCompare/
│       ├── main.swift          # 앱 진입점 및 메뉴
│       └── ContentView.swift   # UI 및 이미지 생성 로직
├── Resources/
│   └── AppIcon.icns           # 앱 아이콘
├── Casks/
│   └── before-after-compare.rb # Homebrew Cask 정의
├── build-release.sh           # 릴리스 빌드 스크립트
├── Package.swift              # Swift Package 정의
└── README.md
```

## 배포

### GitHub Release 생성

```bash
# 1. 빌드
./build-release.sh

# 2. Git 태그 생성
git tag v1.0.0
git push origin v1.0.0

# 3. GitHub에서 Release 생성 후 ZIP 파일 업로드
# release/BeforeAfterCompare-1.0.0.zip
```

### Homebrew Tap 배포

자세한 내용은 [HOMEBREW.md](HOMEBREW.md)를 참고하세요.

## 기술 스택

- **언어**: Swift 5.9
- **프레임워크**: SwiftUI, AppKit
- **빌드 시스템**: Swift Package Manager
- **최소 지원**: macOS 13.0 (Ventura)

## 라이선스

MIT License - 자세한 내용은 [LICENSE](LICENSE) 파일을 참고하세요.

## 문서

- [DISTRIBUTION.md](DISTRIBUTION.md) - 배포 가이드
- [HOMEBREW.md](HOMEBREW.md) - Homebrew 배포 가이드
- [INSTALL.md](INSTALL.md) - 사용자 설치 가이드

## 문제 해결

### "손상되었습니다" 오류 ("is damaged and can't be opened")

이는 macOS Gatekeeper 보안 기능입니다. 터미널에서 다음 명령어를 실행하세요:

```bash
xattr -cr /Applications/BeforeAfterCompare.app
```

또는 우클릭 후 "열기" 선택하면 실행됩니다.

### 앱이 실행되지 않을 때

```bash
# 격리 속성 제거
xattr -cr /Applications/BeforeAfterCompare.app
```

### 빌드 오류

```bash
# 빌드 캐시 정리
swift package clean
rm -rf .build
./build-release.sh
```

## 기여

이슈와 풀 리퀘스트를 환영합니다!

## 작성자

[@yansonz](https://github.com/yansonz)
