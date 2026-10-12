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
      url "https://github.com/tenequm/pond/releases/download/v0.19.6/pond-aarch64-apple-darwin.tar.xz"
      sha256 "b0cc7672b59ee4979f2c7d0afa7b1fd532a376df951cdbcc5d8acd5b66bfcabe"
    end
    # Never downloaded: the arch dependency above stops Intel first. It is here
    # because `brew readall` needs every platform to resolve a URL.
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.19.6/pond-aarch64-apple-darwin.tar.xz"
      sha256 "b0cc7672b59ee4979f2c7d0afa7b1fd532a376df951cdbcc5d8acd5b66bfcabe"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.19.6/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2378896f8af7141d51eb1515c4493c67cb7cda20031b1a0c6ea4551a179281c6"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.19.6/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "79473baf07bc82d3ae213a07e8f29b77af9be6d37a2db2dfb1a1ab2fea2a1d6b"
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
