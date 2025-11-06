cask "before-after-compare" do
  version "1.0.0"
  sha256 "fd20a405a76fcef03d554024b1ee8d8ba46c00a8dda84f4c4375b0cbf85bc07c"

  url "https://github.com/yansonz/before-after-compare/releases/download/v#{version}/BeforeAfterCompare-#{version}.zip"
  name "Before After Compare"
  desc "제품 개선 전후 비교 이미지를 쉽게 만들 수 있는 맥 앱"
  homepage "https://github.com/yansonz/before-after-compare"

  app "BeforeAfterCompare.app"

  zap trash: [
    "~/Library/Preferences/com.beforeaftercompare.app.plist",
    "~/Library/Saved Application State/com.beforeaftercompare.app.savedState",
  ]
end
