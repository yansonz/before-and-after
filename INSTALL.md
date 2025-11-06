# 설치 가이드

## 다운로드한 파일 설치하기

### ZIP 파일 설치 (권장)

1. `BeforeAfterCompare-1.0.0.zip` 파일 다운로드
2. ZIP 파일을 더블클릭하여 압축 해제
3. `BeforeAfterCompare.app`을 Applications 폴더로 드래그
4. Applications 폴더에서 앱 실행

### DMG 파일 설치

1. `BeforeAfterCompare-1.0.0.dmg` 파일 다운로드
2. DMG 파일을 더블클릭하여 마운트
3. `BeforeAfterCompare.app`을 Applications 폴더로 드래그
4. DMG를 언마운트 (꺼내기)
5. Applications 폴더에서 앱 실행

## 파일 무결성 확인 (선택사항)

다운로드한 파일이 손상되지 않았는지 확인:

```bash
# ZIP 파일 확인
shasum -a 256 BeforeAfterCompare-1.0.0.zip
cat BeforeAfterCompare-1.0.0.zip.sha256

# DMG 파일 확인
shasum -a 256 BeforeAfterCompare-1.0.0.dmg
cat BeforeAfterCompare-1.0.0.dmg.sha256
```

두 값이 일치하면 파일이 정상입니다.

## 첫 실행 시 보안 경고 해결

macOS에서 인증되지 않은 개발자의 앱을 처음 실행할 때:

### 방법 1: 시스템 환경설정
1. 앱을 실행하면 "확인되지 않은 개발자" 경고 표시
2. 시스템 환경설정 > 보안 및 개인 정보 보호
3. "확인 없이 열기" 버튼 클릭

### 방법 2: 터미널 명령어
```bash
xattr -cr /Applications/BeforeAfterCompare.app
```

### 방법 3: 우클릭으로 열기
1. Applications 폴더에서 앱을 우클릭 (또는 Control + 클릭)
2. "열기" 선택
3. 경고 창에서 "열기" 버튼 클릭

## 문제 해결

### "파일이 손상되었습니다" 오류
- ZIP 파일을 사용하세요 (DMG보다 전송 안정성이 높음)
- 체크섬 파일(.sha256)로 무결성을 확인하세요
- 다시 다운로드하세요

### 앱이 실행되지 않음
```bash
# 격리 속성 제거
xattr -d com.apple.quarantine /Applications/BeforeAfterCompare.app

# 실행 권한 확인
chmod +x /Applications/BeforeAfterCompare.app/Contents/MacOS/BeforeAfterCompare
```

## 제거 방법

```bash
rm -rf /Applications/BeforeAfterCompare.app
```
