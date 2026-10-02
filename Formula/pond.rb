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
      url "https://github.com/tenequm/pond/releases/download/v0.19.4/pond-aarch64-apple-darwin.tar.xz"
      sha256 "f3fd45e043beeafc5d034c279a48d036249eec436c52f15ada89c8464d0b5e10"
    end
    # Never downloaded: the arch dependency above stops Intel first. It is here
    # because `brew readall` needs every platform to resolve a URL.
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.19.4/pond-aarch64-apple-darwin.tar.xz"
      sha256 "f3fd45e043beeafc5d034c279a48d036249eec436c52f15ada89c8464d0b5e10"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.19.4/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "613b6ea7b02b7e182c4a35f9514a6815d6c86af2612f6f8d54e68c47c616ef97"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.19.4/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1508deff0a706045adbb4cbd0bdd2b19502b8572cbb88a6ede615355257779db"
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
