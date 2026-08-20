cask "blackbox-recorder" do
  version "0.9.3"
  sha256 "0fe46aaa110d57b6c5b992ce5c9a5b2d54404bba0f0f5d9d9511c3c7f6fd0a88"

  url "https://github.com/tenequm/blackbox/releases/download/v#{version}/Blackbox-#{version}.dmg"
  name "Blackbox"
  desc "Menu bar app that auto-records call audio"
  homepage "https://github.com/tenequm/blackbox"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :tahoe

  app "Blackbox.app"

  zap trash: [
    "~/Library/Application Support/Blackbox",
    "~/Library/Caches/com.tenequm.Blackbox",
    "~/Library/HTTPStorages/com.tenequm.Blackbox",
    "~/Library/Logs/Blackbox",
    "~/Library/Preferences/com.tenequm.Blackbox.plist",
    "~/Library/Saved Application State/com.tenequm.Blackbox.savedState",
  ]

  caveats <<~EOS
    Blackbox requires macOS 26.1 or later. Homebrew can only enforce the
    major version (26.0), so on 26.0 the app will install but refuse to launch.
  EOS
end
