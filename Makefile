APP_NAME = BeforeAfterCompare
APP_BUNDLE = $(APP_NAME).app
BUILD_DIR = .build/release

build:
	swift build -c release
	@mkdir -p $(APP_BUNDLE)/Contents/MacOS
	@cp $(BUILD_DIR)/$(APP_NAME) $(APP_BUNDLE)/Contents/MacOS/
	@echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $(APP_BUNDLE)/Contents/Info.plist
	@echo "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">" >> $(APP_BUNDLE)/Contents/Info.plist
	@echo "<plist version=\"1.0\">" >> $(APP_BUNDLE)/Contents/Info.plist
	@echo "<dict>" >> $(APP_BUNDLE)/Contents/Info.plist
	@echo "  <key>CFBundleExecutable</key>" >> $(APP_BUNDLE)/Contents/Info.plist
	@echo "  <string>$(APP_NAME)</string>" >> $(APP_BUNDLE)/Contents/Info.plist
	@echo "  <key>CFBundleIdentifier</key>" >> $(APP_BUNDLE)/Contents/Info.plist
	@echo "  <string>com.example.beforeaftercompare</string>" >> $(APP_BUNDLE)/Contents/Info.plist
	@echo "  <key>CFBundleName</key>" >> $(APP_BUNDLE)/Contents/Info.plist
	@echo "  <string>$(APP_NAME)</string>" >> $(APP_BUNDLE)/Contents/Info.plist
	@echo "  <key>CFBundlePackageType</key>" >> $(APP_BUNDLE)/Contents/Info.plist
	@echo "  <string>APPL</string>" >> $(APP_BUNDLE)/Contents/Info.plist
	@echo "  <key>LSMinimumSystemVersion</key>" >> $(APP_BUNDLE)/Contents/Info.plist
	@echo "  <string>13.0</string>" >> $(APP_BUNDLE)/Contents/Info.plist
	@echo "</dict>" >> $(APP_BUNDLE)/Contents/Info.plist
	@echo "</plist>" >> $(APP_BUNDLE)/Contents/Info.plist

run: build
	open $(APP_BUNDLE)

install: build
	cp -r $(APP_BUNDLE) /Applications/

clean:
	swift package clean
	rm -rf $(APP_BUNDLE)

.PHONY: build run install clean