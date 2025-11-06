#!/bin/bash

mkdir -p Resources/AppIcon.iconset

# sips를 사용하여 아이콘 생성 (macOS 내장 도구)
create_icon() {
    local size=$1
    local output=$2
    
    # 임시 PNG 생성
    cat > /tmp/icon_template.svg << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<svg width="1024" height="1024" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#F5F5F5;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#E0E0E0;stop-opacity:1" />
    </linearGradient>
  </defs>
  
  <!-- Background (transparent with subtle gradient) -->
  <rect width="1024" height="1024" fill="url(#bg)" rx="180" fill-opacity="0.95"/>
  
  <!-- Divider line -->
  <line x1="512" y1="0" x2="512" y2="1024" stroke="#CCCCCC" stroke-width="4"/>
  
  <!-- Before rectangle (blue) -->
  <rect x="128" y="128" width="340" height="340" fill="#4A90E2" stroke="#2E5C8A" stroke-width="8" rx="20"/>
  
  <!-- After rectangle (green) -->
  <rect x="556" y="128" width="340" height="340" fill="#7ED321" stroke="#5A9B18" stroke-width="8" rx="20"/>
  
  <!-- Before text -->
  <text x="180" y="880" font-family="Helvetica" font-size="80" font-weight="bold" fill="#4A90E2">Before</text>
  
  <!-- After text -->
  <text x="640" y="880" font-family="Helvetica" font-size="80" font-weight="bold" fill="#7ED321">After</text>
</svg>
EOF
    
    # SVG를 PNG로 변환
    qlmanage -t -s ${size} -o /tmp /tmp/icon_template.svg > /dev/null 2>&1
    mv /tmp/icon_template.svg.png "${output}"
}

# 아이콘 크기별 생성
create_icon 1024 "Resources/AppIcon.iconset/icon_512x512@2x.png"
sips -z 512 512 "Resources/AppIcon.iconset/icon_512x512@2x.png" --out "Resources/AppIcon.iconset/icon_512x512.png" > /dev/null 2>&1
sips -z 512 512 "Resources/AppIcon.iconset/icon_512x512@2x.png" --out "Resources/AppIcon.iconset/icon_256x256@2x.png" > /dev/null 2>&1
sips -z 256 256 "Resources/AppIcon.iconset/icon_512x512@2x.png" --out "Resources/AppIcon.iconset/icon_256x256.png" > /dev/null 2>&1
sips -z 256 256 "Resources/AppIcon.iconset/icon_512x512@2x.png" --out "Resources/AppIcon.iconset/icon_128x128@2x.png" > /dev/null 2>&1
sips -z 128 128 "Resources/AppIcon.iconset/icon_512x512@2x.png" --out "Resources/AppIcon.iconset/icon_128x128.png" > /dev/null 2>&1
sips -z 64 64 "Resources/AppIcon.iconset/icon_512x512@2x.png" --out "Resources/AppIcon.iconset/icon_32x32@2x.png" > /dev/null 2>&1
sips -z 32 32 "Resources/AppIcon.iconset/icon_512x512@2x.png" --out "Resources/AppIcon.iconset/icon_32x32.png" > /dev/null 2>&1
sips -z 32 32 "Resources/AppIcon.iconset/icon_512x512@2x.png" --out "Resources/AppIcon.iconset/icon_16x16@2x.png" > /dev/null 2>&1
sips -z 16 16 "Resources/AppIcon.iconset/icon_512x512@2x.png" --out "Resources/AppIcon.iconset/icon_16x16.png" > /dev/null 2>&1

# icns 파일 생성
iconutil -c icns Resources/AppIcon.iconset -o Resources/AppIcon.icns

echo "✅ App icon created: Resources/AppIcon.icns"
ls -lh Resources/
