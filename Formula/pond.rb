# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
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
    url "https://github.com/tenequm/pond/releases/download/v0.14.6/pond-aarch64-apple-darwin.tar.xz"
    sha256 "b7d33ea5838dc023dde114c00fcf8879b0d3a859998fd7f68dde42bf6ea6a459"
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.6/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eb8f28729b18d3891f6281dc23394df4fd5666f74b47d327e945c9c77ae45d5d"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.14.6/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cd2005b9308047a10b9dc421a2a509068b8523246a905638006818a40a59fdef"
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
