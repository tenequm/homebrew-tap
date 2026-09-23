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
      url "https://github.com/tenequm/pond/releases/download/v0.19.1/pond-aarch64-apple-darwin.tar.xz"
      sha256 "9f25a98de3734642eaa8d7c30eb56e13fc1818e4195e301952b77f97abe42374"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.19.1/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7f8d88135dd5be40aa305cfd5dd67d497a37958371ef95804670ca2f9fe679a4"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.19.1/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9d0048d329413ca711d0141b70ead4218380f5d8f606dd007812fb96e0d8c2a2"
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
