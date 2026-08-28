cask "blackbox-recorder" do
  version "0.9.4"
  sha256 "c9717f519450d12e9eafeee32b3b1e9f57646a22d4d854da724c3d360cd2b9ed"

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
