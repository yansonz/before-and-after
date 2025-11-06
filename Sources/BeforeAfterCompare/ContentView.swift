import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var beforeImage: NSImage?
    @State private var afterImage: NSImage?
    @State private var beforeText = ""
    @State private var afterText = ""
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Before & After 비교")
                .font(.system(size: 28, weight: .bold))
                .padding(.top, 20)
            
            HStack(spacing: 40) {
                // Before 섹션
                VStack(spacing: 15) {
                    Text("Before")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.blue)
                    
                    ImageDropZone(
                        image: $beforeImage,
                        placeholder: "Before 이미지를 드래그하세요"
                    )
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $beforeText)
                            .frame(height: 70)
                            .scrollContentBackground(.hidden)
                            .background(Color(NSColor.textBackgroundColor))
                        if beforeText.isEmpty {
                            Text("텍스트를 입력하세요")
                                .foregroundColor(.secondary)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
                .frame(maxWidth: .infinity)
                
                // After 섹션
                VStack(spacing: 15) {
                    Text("After")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.green)
                    
                    ImageDropZone(
                        image: $afterImage,
                        placeholder: "After 이미지를 드래그하세요"
                    )
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $afterText)
                            .frame(height: 70)
                            .scrollContentBackground(.hidden)
                            .background(Color(NSColor.textBackgroundColor))
                        if afterText.isEmpty {
                            Text("텍스트를 입력하세요")
                                .foregroundColor(.secondary)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
                .frame(maxWidth: .infinity)
            }
            
            Button(action: saveComparisonImage) {
                Label("비교 이미지 저장", systemImage: "square.and.arrow.down")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: 300)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(beforeImage == nil || afterImage == nil ? Color.gray : Color.blue)
                    )
            }
            .buttonStyle(.plain)
            .disabled(beforeImage == nil || afterImage == nil)
            .padding(.bottom, 20)
        }
        .padding(30)
        .frame(minWidth: 900, minHeight: 650)
    }
    
    private func saveComparisonImage() {
        guard let beforeImg = beforeImage, let afterImg = afterImage else { return }
        
        let panel = NSSavePanel()
        panel.allowedContentTypes = [.png]
        panel.nameFieldStringValue = "before_after_comparison.png"
        
        if panel.runModal() == .OK, let url = panel.url {
            let comparisonImage = createComparisonImage(before: beforeImg, after: afterImg)
            if let data = comparisonImage.pngData {
                try? data.write(to: url)
            }
        }
    }
    
    private func createComparisonImage(before: NSImage, after: NSImage) -> NSImage {
        let spacing: CGFloat = 60
        
        // 원본 이미지 크기 유지 (최소 높이 400)
        let maxHeight = max(before.size.height, after.size.height, 400)
        let scale = max(maxHeight / 400, 1.0)
        let textHeight: CGFloat = 60 * scale
        let headerHeight: CGFloat = 40 * scale
        
        let beforeSize = before.size.aspectFit(maxHeight: maxHeight)
        let afterSize = after.size.aspectFit(maxHeight: maxHeight)
        
        // 두 이미지 중 더 큰 너비를 기준으로 프레임 너비 설정
        let frameWidth = max(beforeSize.width, afterSize.width, 350)
        
        let totalWidth = frameWidth * 2 + spacing
        let totalHeight = headerHeight + maxHeight + textHeight
        
        let image = NSImage(size: NSSize(width: totalWidth, height: totalHeight))
        image.lockFocus()
        
        NSGraphicsContext.current?.imageInterpolation = .high
        
        // 배경색 (흰색)
        NSColor.white.setFill()
        NSRect(x: 0, y: 0, width: totalWidth, height: totalHeight).fill()
        
        // 헤더 텍스트 (Before/After)
        let headerParagraphStyle = NSMutableParagraphStyle()
        headerParagraphStyle.alignment = .center
        let headerAttributesWithCenter: [NSAttributedString.Key: Any] = [
            .font: NSFont.boldSystemFont(ofSize: 20 * scale),
            .foregroundColor: NSColor.black,
            .paragraphStyle: headerParagraphStyle
        ]
        
        let beforeHeaderRect = NSRect(x: 0, y: totalHeight - headerHeight, width: frameWidth, height: headerHeight)
        "Before".draw(in: beforeHeaderRect, withAttributes: headerAttributesWithCenter)
        
        let afterHeaderRect = NSRect(x: frameWidth + spacing, y: totalHeight - headerHeight, width: frameWidth, height: headerHeight)
        "After".draw(in: afterHeaderRect, withAttributes: headerAttributesWithCenter)
        
        // Before 프레임 (가운데 정렬)
        let beforeX = round((frameWidth - beforeSize.width) / 2)
        let beforeY = round(textHeight + (maxHeight - beforeSize.height) / 2)
        before.draw(in: NSRect(x: beforeX, y: beforeY, width: round(beforeSize.width), height: round(beforeSize.height)), from: .zero, operation: .sourceOver, fraction: 1.0)
        
        // After 프레임 (가운데 정렬)
        let afterFrameStartX = frameWidth + spacing
        let afterX = round(afterFrameStartX + (frameWidth - afterSize.width) / 2)
        let afterY = round(textHeight + (maxHeight - afterSize.height) / 2)
        after.draw(in: NSRect(x: afterX, y: afterY, width: round(afterSize.width), height: round(afterSize.height)), from: .zero, operation: .sourceOver, fraction: 1.0)
        
        // 텍스트 (가운데 정렬) - 이미지 크기에 비례
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 16 * scale),
            .foregroundColor: NSColor.black,
            .paragraphStyle: paragraphStyle
        ]
        
        let beforeTextRect = NSRect(x: 0, y: 0, width: frameWidth, height: textHeight)
        let afterTextRect = NSRect(x: afterFrameStartX, y: 0, width: frameWidth, height: textHeight)
        
        beforeText.draw(in: beforeTextRect, withAttributes: attributes)
        afterText.draw(in: afterTextRect, withAttributes: attributes)
        
        // 타임스탬프 (우측 하단)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let timestamp = formatter.string(from: Date())
        let timestampAttributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 10 * scale),
            .foregroundColor: NSColor.gray
        ]
        let timestampSize = timestamp.size(withAttributes: timestampAttributes)
        let timestampRect = NSRect(x: totalWidth - timestampSize.width - 10, y: 10, width: timestampSize.width, height: timestampSize.height)
        timestamp.draw(in: timestampRect, withAttributes: timestampAttributes)
        
        image.unlockFocus()
        return image
    }
}

struct ImageDropZone: View {
    @Binding var image: NSImage?
    let placeholder: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(colorScheme == .dark ? Color(white: 0.15) : Color(white: 0.95))
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(colorScheme == .dark ? Color(white: 0.4) : Color.gray, style: StrokeStyle(lineWidth: 2, dash: [5]))
                .frame(height: 200)
            
            if let image = image {
                Image(nsImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 190)
                    .clipped()
            } else {
                Text(placeholder)
                    .foregroundColor(colorScheme == .dark ? Color(white: 0.6) : .gray)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .onDrop(of: [.image], isTargeted: nil) { providers in
            guard let provider = providers.first else { return false }
            
            provider.loadDataRepresentation(forTypeIdentifier: UTType.image.identifier) { data, _ in
                if let data = data, let nsImage = NSImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = nsImage
                    }
                }
            }
            return true
        }
    }
}

extension NSSize {
    func aspectFit(maxHeight: CGFloat) -> NSSize {
        let ratio = maxHeight / height
        return NSSize(width: width * ratio, height: maxHeight)
    }
}

extension NSImage {
    var pngData: Data? {
        guard let tiffData = tiffRepresentation,
              let bitmapRep = NSBitmapImageRep(data: tiffData) else { return nil }
        return bitmapRep.representation(using: .png, properties: [:])
    }
}