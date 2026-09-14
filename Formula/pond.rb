# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and full-text/semantic search for AI agent sessions"
  homepage "https://pond.locker/"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    # Apple Silicon only: there is no x86_64-apple-darwin build, so
    # the arch dependency refuses Intel before any download is attempted.
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.17.3/pond-aarch64-apple-darwin.tar.xz"
      sha256 "ba19eb863333eaf70e8b584ce6a20f5dcf5c9f9940513b3bab3c8e1d3041cee3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.17.3/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c0f54473e97352e2cd45f3cc893c8f94284d4171686f3debe62e4abb0db87965"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.17.3/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7021e2268348abdd44a8909ce160b823c452339ba7a6bb0a12f67daf0d1cc56b"
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
