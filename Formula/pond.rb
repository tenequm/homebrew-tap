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
      url "https://github.com/tenequm/pond/releases/download/v0.20.3/pond-aarch64-apple-darwin.tar.xz"
      sha256 "d1313e280b6c78e3d3c4e48b08d0afb553a1130d608b5ceec96e389babd7cc5b"
    end
    # Never downloaded: the arch dependency above stops Intel first. It is here
    # because `brew readall` needs every platform to resolve a URL.
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.20.3/pond-aarch64-apple-darwin.tar.xz"
      sha256 "d1313e280b6c78e3d3c4e48b08d0afb553a1130d608b5ceec96e389babd7cc5b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.20.3/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8294f3067e87daeec111d76d36a60471310373ea7e212c7d75a54e5cf07eaa52"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.20.3/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ac2ed5c27ad6478ed29e7ecbe0dae9f6da99f388dcdea6db4d443c334aa8560e"
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
