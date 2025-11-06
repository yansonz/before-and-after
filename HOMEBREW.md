# Homebrew 배포 가이드

## 준비 사항

1. GitHub 계정
2. 빌드된 릴리스 파일 (`./build-release.sh` 실행)
3. Git 설치

## 배포 단계

### 1단계: Homebrew Cask 생성

```bash
chmod +x homebrew-setup.sh
./homebrew-setup.sh
```

스크립트가 GitHub 사용자명과 저장소 이름을 물어봅니다.

### 2단계: GitHub 저장소 생성 및 푸시

```bash
# Git 초기화 (아직 안했다면)
git init
git add .
git commit -m "Initial commit"

# GitHub에 저장소 생성 후
git remote add origin https://github.com/YOUR_USERNAME/BeforeAfterCompare.git
git branch -M main
git push -u origin main
```

### 3단계: GitHub Release 생성

1. GitHub 저장소 페이지로 이동
2. "Releases" → "Create a new release" 클릭
3. 다음 정보 입력:
   - **Tag**: `v1.0.0`
   - **Release title**: `v1.0.0`
   - **Description**: 릴리스 노트 작성
4. `release/BeforeAfterCompare-1.0.0.zip` 파일 업로드
5. "Publish release" 클릭

### 4단계: Homebrew Tap 저장소 생성 (권장)

#### 4-1. Tap 저장소 생성

1. GitHub에서 새 저장소 생성
2. 저장소 이름: `homebrew-cask` (권장) 또는 `homebrew-tap`
3. Public으로 설정

#### 4-2. Cask 푸시

```bash
# Tap 저장소 클론
git clone https://github.com/YOUR_USERNAME/homebrew-cask.git
cd homebrew-cask

# Casks 디렉토리 생성
mkdir -p Casks

# Cask 복사
cp ../BeforeAfterCompare/Casks/before-after-compare.rb Casks/

# 푸시
git add Casks/before-after-compare.rb
git commit -m "Add before-after-compare cask"
git push
```

## 사용자 설치 방법

### 방법 1: Tap 사용 (권장)

```bash
brew tap YOUR_USERNAME/cask
brew install --cask before-after-compare
```

### 방법 2: 직접 설치

```bash
brew install --cask YOUR_USERNAME/cask/before-after-compare
```

## 업데이트 배포

새 버전을 배포할 때:

1. `build-release.sh`에서 VERSION 업데이트
2. 빌드 실행: `./build-release.sh`
3. `homebrew-setup.sh` 다시 실행하여 Cask 업데이트
4. GitHub Release 생성 (새 버전 태그)
5. Cask를 Tap 저장소에 푸시

```bash
# Cask 업데이트
./homebrew-setup.sh

# Tap 저장소 업데이트
cd ../homebrew-cask
cp ../BeforeAfterCompare/Casks/before-after-compare.rb Casks/
git add Casks/before-after-compare.rb
git commit -m "Update to v1.0.1"
git push
```

사용자는 다음 명령어로 업데이트:
```bash
brew update
brew upgrade before-after-compare
```

## 문제 해결

### Cask 테스트

```bash
brew install --cask Casks/before-after-compare.rb
```

### Cask 검증

```bash
brew audit --cask --strict Casks/before-after-compare.rb
```

### 설치 제거

```bash
brew uninstall --cask before-after-compare
brew untap YOUR_USERNAME/cask
```

## 참고 자료

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [How to Create and Maintain a Tap](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
