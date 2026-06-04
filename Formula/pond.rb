# typed: false
# frozen_string_literal: true
class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.cascade.fyi/"
  version "0.3.1"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/tenequm/homebrew-tap"
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.3.1/pond-aarch64-apple-darwin.tar.xz"
      sha256 "4ef13ae43a4a97589b96ab0d5d89da2b88a49ad2d0cd5bb64d5a73e736f12770"

      def install
        bin.install "pond"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.3.1/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dc72e2e776aa93fb8d656b1cf56b37b533081d18d21da1596c17c75d18b3f752"

      def install
        bin.install "pond"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.3.1/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f133b0f4cb568037b223e72d4219aa0800786a3a77261b78003b695a1ff208b0"

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
