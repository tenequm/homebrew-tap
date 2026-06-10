# typed: false
# frozen_string_literal: true
class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.cascade.fyi/"
  version "0.5.1"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/tenequm/homebrew-tap"
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.5.1/pond-aarch64-apple-darwin.tar.xz"
      sha256 "6891d79baa5fcbd127d269a0da4c94dd5182845564a2526431d3d25a04f3a496"

      def install
        bin.install "pond"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.5.1/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d2ed761111212c64957d3397b6922fe1cc6559db0e07cd6afb0342455eb4f3f9"

      def install
        bin.install "pond"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.5.1/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a36952aab4712c6ed3807114884257ad9059ecd8c0343e4f8d63101982f39da5"

      def install
        bin.install "pond"
      end
    end
  end

  test do
    assert_match "pond #{version}", shell_output("#{bin}/pond --version")
    system bin/"pond", "--help"
  end
end
