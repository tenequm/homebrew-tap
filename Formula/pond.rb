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
      url "https://github.com/tenequm/pond/releases/download/v0.19.5/pond-aarch64-apple-darwin.tar.xz"
      sha256 "3d0553bda509a80ef5d0a9f7b2b25dcb679649e3cef2d55649118f00a518d7e6"
    end
    # Never downloaded: the arch dependency above stops Intel first. It is here
    # because `brew readall` needs every platform to resolve a URL.
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.19.5/pond-aarch64-apple-darwin.tar.xz"
      sha256 "3d0553bda509a80ef5d0a9f7b2b25dcb679649e3cef2d55649118f00a518d7e6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.19.5/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2d76b764df00b3a02d8fe44c200058a5066d13b08517f50f866d32c7515959f5"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.19.5/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "20f0f6b0741fee708006f2227824737e1a027c56f0d3d08f337f5196d0ee06ea"
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
