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
      url "https://github.com/tenequm/pond/releases/download/v0.19.3/pond-aarch64-apple-darwin.tar.xz"
      sha256 "dcdbde922a1f12365f1b5fcf1bf0214096d212abb88ad49c63a6f42c401a0e7f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.19.3/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7b7e49bcad3e96bce96b2645c8f439c52beee87f29ebfa9c015c17772e8ea24c"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.19.3/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "64c315d572d41905ab509055e7cde706df1affa2111e73a0ca0ea7e7db6e3ab0"
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
