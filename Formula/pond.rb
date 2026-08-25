# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage, full-text search, and optional semantic search for sessions from any AI agent client"
  homepage "https://pond.locker/"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    # Apple Silicon only: there is no x86_64-apple-darwin build, so
    # depends_on refuses Intel before any download is attempted.
    depends_on arch: :arm64
    url "https://github.com/tenequm/pond/releases/download/v0.16.0/pond-aarch64-apple-darwin.tar.xz"
    sha256 "efa684877a9612fafe4d33a8a9f931190b338c9116f5e80b7ec8306da6a8814b"
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.16.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "df9e7060347933ef776072ebb118b29d6767174cc458b10c83a0ed88461a1702"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.16.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "602f0778f1ca38d2d037276c86994c6f36d4b948c480ff5befb8f846381ed6c0"
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
