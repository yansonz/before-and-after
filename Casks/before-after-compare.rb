cask "before-after-compare" do
  version "1.0.0"
  sha256 "03d1be95358ea6f93b4da66e6ad3e1df93b76ad2cb2551998fe1c062ec3d301c"

  url "https://github.com/your-username/BeforeAfterCompare/releases/download/v#{version}/BeforeAfterCompare-#{version}.zip"
  name "Before After Compare"
  desc "제품 개선 전후 비교 이미지를 쉽게 만들 수 있는 맥 앱"
  homepage "https://github.com/your-username/BeforeAfterCompare"

  app "BeforeAfterCompare.app"

  zap trash: [
    "~/Library/Preferences/com.beforeaftercompare.app.plist",
    "~/Library/Saved Application State/com.beforeaftercompare.app.savedState",
  ]
end
