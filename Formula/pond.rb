# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.locker/"
  version "0.10.0"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.10.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "4e300de10687fdedb28a71b33ca6a8676741d028281c40a6b90b735933f34042"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.10.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ee44303547f93f4eb61545217525c13c732499d860bd35946fd607ef01054662"
    end
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.10.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "22f11e67155eac94316b752790abf6a3deb414cabd53db7e9e221704b5ec27be"
    end
  end

  def install
    bin.install "pond"
    generate_completions_from_executable(bin/"pond", "completions")
  end

  test do
    assert_match "pond #{version}", shell_output("#{bin}/pond --version")
    system bin/"pond", "--help"
    assert_match "_pond", shell_output("#{bin}/pond completions zsh")
  end
end
