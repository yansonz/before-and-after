cask "before-after-compare" do
  version "1.0.0"
  sha256 "c207f885c6617bab255ab83b2062b0a53c111c28518d07316ff01e0830ddcd06"

  url "https://github.com/yansonz/before-and-after/releases/download/v#{version}/BeforeAfterCompare-#{version}.zip"
  name "Before After Compare"
  desc "제품 개선 전후 비교 이미지를 쉽게 만들 수 있는 맥 앱"
  homepage "https://github.com/yansonz/before-and-after"

  app "BeforeAfterCompare.app"

  zap trash: [
    "~/Library/Preferences/com.beforeaftercompare.app.plist",
    "~/Library/Saved Application State/com.beforeaftercompare.app.savedState",
  ]
end
