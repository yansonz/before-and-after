#!/bin/bash

mkdir -p Resources/AppIcon.iconset

# 투명 배경의 아이콘 생성
cat > /tmp/icon_template.svg << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<svg width="1024" height="1024" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bluegradient" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#5BA3F5;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#3A7BC8;stop-opacity:1" />
    </linearGradient>
    <linearGradient id="greengradient" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#8FE234;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#6BC91D;stop-opacity:1" />
    </linearGradient>
  </defs>
  
  <!-- Rounded square background with transparency -->
  <rect width="1024" height="1024" fill="#FFFFFF" rx="226" opacity="0.98"/>
  
  <!-- Subtle shadow effect -->
  <rect x="20" y="20" width="984" height="984" fill="#000000" rx="216" opacity="0.03"/>
  
  <!-- Divider line -->
  <line x1="512" y1="100" x2="512" y2="924" stroke="#D0D0D0" stroke-width="3" opacity="0.6"/>
  
  <!-- Before rectangle (blue gradient) -->
  <rect x="140" y="200" width="300" height="300" fill="url(#bluegradient)" rx="30" stroke="#2E5C8A" stroke-width="6"/>
  
  <!-- After rectangle (green gradient) -->
  <rect x="584" y="200" width="300" height="300" fill="url(#greengradient)" rx="30" stroke="#5A9B18" stroke-width="6"/>
  
  <!-- Before text -->
  <text x="290" y="680" font-family="Helvetica Neue, Helvetica, Arial" font-size="90" font-weight="bold" fill="#4A90E2" text-anchor="middle">Before</text>
  
  <!-- After text -->
  <text x="734" y="680" font-family="Helvetica Neue, Helvetica, Arial" font-size="90" font-weight="bold" fill="#7ED321" text-anchor="middle">After</text>
  
  <!-- Small comparison arrows -->
  <path d="M 400 360 L 450 360 L 430 340 M 450 360 L 430 380" stroke="#888888" stroke-width="8" fill="none" stroke-linecap="round" opacity="0.4"/>
  <path d="M 624 360 L 574 360 L 594 340 M 574 360 L 594 380" stroke="#888888" stroke-width="8" fill="none" stroke-linecap="round" opacity="0.4"/>
</svg>
EOF

# SVG를 PNG로 변환 (투명 배경 유지)
rsvg-convert -w 1024 -h 1024 -f png -o /tmp/icon_1024.png /tmp/icon_template.svg 2>/dev/null || \
qlmanage -t -s 1024 -o /tmp /tmp/icon_template.svg > /dev/null 2>&1

if [ -f "/tmp/icon_template.svg.png" ]; then
    mv /tmp/icon_template.svg.png /tmp/icon_1024.png
fi

# 아이콘 크기별 생성
sips -s format png /tmp/icon_1024.png --out "Resources/AppIcon.iconset/icon_512x512@2x.png" > /dev/null 2>&1
sips -z 512 512 /tmp/icon_1024.png --out "Resources/AppIcon.iconset/icon_512x512.png" > /dev/null 2>&1
sips -z 512 512 /tmp/icon_1024.png --out "Resources/AppIcon.iconset/icon_256x256@2x.png" > /dev/null 2>&1
sips -z 256 256 /tmp/icon_1024.png --out "Resources/AppIcon.iconset/icon_256x256.png" > /dev/null 2>&1
sips -z 256 256 /tmp/icon_1024.png --out "Resources/AppIcon.iconset/icon_128x128@2x.png" > /dev/null 2>&1
sips -z 128 128 /tmp/icon_1024.png --out "Resources/AppIcon.iconset/icon_128x128.png" > /dev/null 2>&1
sips -z 64 64 /tmp/icon_1024.png --out "Resources/AppIcon.iconset/icon_32x32@2x.png" > /dev/null 2>&1
sips -z 32 32 /tmp/icon_1024.png --out "Resources/AppIcon.iconset/icon_32x32.png" > /dev/null 2>&1
sips -z 32 32 /tmp/icon_1024.png --out "Resources/AppIcon.iconset/icon_16x16@2x.png" > /dev/null 2>&1
sips -z 16 16 /tmp/icon_1024.png --out "Resources/AppIcon.iconset/icon_16x16.png" > /dev/null 2>&1

# icns 파일 생성
iconutil -c icns Resources/AppIcon.iconset -o Resources/AppIcon.icns

echo "✅ Transparent app icon created: Resources/AppIcon.icns"
