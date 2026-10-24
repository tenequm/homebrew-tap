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
      url "https://github.com/tenequm/pond/releases/download/v0.20.2/pond-aarch64-apple-darwin.tar.xz"
      sha256 "bfda14bf97a25e20d5ff27c017b6f4a46c9b9923314f39e2971d4c739b7cb8e3"
    end
    # Never downloaded: the arch dependency above stops Intel first. It is here
    # because `brew readall` needs every platform to resolve a URL.
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.20.2/pond-aarch64-apple-darwin.tar.xz"
      sha256 "bfda14bf97a25e20d5ff27c017b6f4a46c9b9923314f39e2971d4c739b7cb8e3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.20.2/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6a3de9cec5796c370f36f01aef872c99d9d9a444d87719b98cbb6716a70691f4"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.20.2/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "77dcdef29436dadacf7903d501eeb33de16e248266416c86c5ba04d54902d4e5"
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
