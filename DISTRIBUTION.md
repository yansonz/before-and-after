# 배포 가이드

## 빌드 및 배포

### 1. DMG 파일 생성 (권장)

```bash
./build-release.sh
```

생성된 파일: `release/BeforeAfterCompare-1.0.0.dmg`

### 2. 수동 빌드

```bash
make build
```

생성된 파일: `BeforeAfterCompare.app`

## 배포 방법

### 방법 1: ZIP 파일 공유 (권장)
1. `release/BeforeAfterCompare-1.0.0.zip` 파일을 공유
2. `release/BeforeAfterCompare-1.0.0.zip.sha256` 파일도 함께 공유 (무결성 확인용)
3. 사용자는 ZIP을 풀고 앱을 Applications 폴더로 이동

**장점:**
- 파일 전송 시 손상 가능성 낮음
- 이메일, 클라우드 저장소 등에서 안정적
- 체크섬으로 무결성 확인 가능

### 방법 2: DMG 파일 공유
1. `release/BeforeAfterCompare-1.0.0.dmg` 파일을 공유
2. `release/BeforeAfterCompare-1.0.0.dmg.sha256` 파일도 함께 공유
3. 사용자는 DMG를 열고 앱을 Applications 폴더로 드래그

### 방법 3: 직접 설치
```bash
make install
```

## 사용자 설치 방법

자세한 설치 방법은 [INSTALL.md](INSTALL.md)를 참고하세요.

### ZIP 파일 사용 (권장)
1. ZIP 파일 다운로드 및 압축 해제
2. BeforeAfterCompare.app을 Applications 폴더로 이동
3. Applications 폴더에서 앱 실행

### DMG 파일 사용
1. DMG 파일 다운로드
2. DMG 파일 더블클릭하여 마운트
3. BeforeAfterCompare.app을 Applications 폴더로 드래그
4. Applications 폴더에서 앱 실행

## 첫 실행 시 보안 경고

macOS에서 인증되지 않은 개발자의 앱을 처음 실행할 때:

1. "확인되지 않은 개발자" 경고가 나타남
2. 시스템 환경설정 > 보안 및 개인 정보 보호로 이동
3. "확인 없이 열기" 버튼 클릭

또는 터미널에서:
```bash
xattr -cr /Applications/BeforeAfterCompare.app
```

## 버전 업데이트

`build-release.sh` 파일의 `VERSION` 변수를 수정:
```bash
VERSION="1.0.1"
```
