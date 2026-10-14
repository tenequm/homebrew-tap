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
      url "https://github.com/tenequm/pond/releases/download/v0.20.1/pond-aarch64-apple-darwin.tar.xz"
      sha256 "c2759303b2e7abfcb58999e75270a120f3ed6a76304f68e313ca594b8387ae86"
    end
    # Never downloaded: the arch dependency above stops Intel first. It is here
    # because `brew readall` needs every platform to resolve a URL.
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.20.1/pond-aarch64-apple-darwin.tar.xz"
      sha256 "c2759303b2e7abfcb58999e75270a120f3ed6a76304f68e313ca594b8387ae86"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.20.1/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c6a60dd5062fe5e6e3b8d0542ddfd1f8941b07a14e8c0420fe9a8a9d3478b6ec"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.20.1/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0d0abffbaa0c07165f0a454c2873cfae8002219bf107b8c98fb644cd4b37a93c"
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
