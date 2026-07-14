# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.locker/"
  version "0.13.2"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.13.2/pond-aarch64-apple-darwin.tar.xz"
      sha256 "1a4c6f45f3dc7ada3e291c6f2ce54ad71d040e13de58cb0d2d61307a81ba5c53"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.13.2/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5b425d229aac494fe34ec873eebc02ce0327e96a2d5e23b2a7b94d0cdb664e4d"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.13.2/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e29939cb78e633ce7dfb476ea77ae0b8059f6c77a65029870a8debfc0f5eacd5"
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
