cask "blackbox" do
  version "0.9.0"
  sha256 "69b6d2ee766c03fd3f2c60262b96b9cdcb21be075a8631dea17400c6a8407438"

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
