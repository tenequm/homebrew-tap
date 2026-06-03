# typed: false
# frozen_string_literal: true
class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.cascade.fyi/"
  version "0.2.8"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/tenequm/homebrew-tap"
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.2.8/pond-aarch64-apple-darwin.tar.xz"
      sha256 "40e707d403fb63f92452d07f736271e4bfc9223ea6154b3a98328f487efdf27c"

      def install
        bin.install "pond"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.2.8/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "961095462219d6a9ecfdbdedcb71d5cc59a34916c4b49d2ce2409f1f7cde5eb4"

      def install
        bin.install "pond"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.2.8/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "86998ec644b6fb7c07da97ecaf8f0e54b253b9da2e159f0551a2cd9f464ee0ff"

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
