# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.cascade.fyi/"
  version "0.7.0"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.7.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "73b44a1a0321b2dc679d7e7569f323a6bba51524f35bab37637b124664bb3292"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.7.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0c206cf4a7022d2b7a2bc6450dae6ba94e7e53be52665aa563c05416ec5e0534"
    end
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.7.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7ceee28852ca40ea20d1463a8381de4e6cced9ec78369181b5e2a79b14cdc8ee"
    end
  end

  def install
    bin.install "pond"
  end

  test do
    assert_match "pond #{version}", shell_output("#{bin}/pond --version")
    system bin/"pond", "--help"
  end
end
