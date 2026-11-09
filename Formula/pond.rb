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
      url "https://github.com/tenequm/pond/releases/download/v0.21.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "5d6afaa344d8a7435fa571eeae6ad59534376c6ac0a46b0d7d40769c72a7babb"
    end
    # Never downloaded: the arch dependency above stops Intel first. It is here
    # because `brew readall` needs every platform to resolve a URL.
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.21.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "5d6afaa344d8a7435fa571eeae6ad59534376c6ac0a46b0d7d40769c72a7babb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.21.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a6bcc4eace2442041f224243996ca6e1d7168aabac815e674b5c42f980fc2cfc"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.21.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "93d96f85b2c974b10e0e8bae9f1d3b27c5615487d85f3e5c1bf11b70e0e12ce6"
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
