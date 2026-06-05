# typed: false
# frozen_string_literal: true
class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.cascade.fyi/"
  version "0.4.0"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/tenequm/homebrew-tap"
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.4.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "ce7eba202c6fdc1a66d6ba8579e8653c03de1a66d0221679e5dfaa7f5fc19921"

      def install
        bin.install "pond"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.4.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4577a6d4bf6df74dc570e6d0aa80f92559bc06440f436621dd43451944909c7d"

      def install
        bin.install "pond"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.4.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ff53cbef3fa946f6fb9f834085388870f7c723c1c61f9f4308f9401a707f7dc6"

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
