# typed: false
# frozen_string_literal: true
class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.cascade.fyi/"
  version "0.5.2"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/tenequm/homebrew-tap"
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.5.2/pond-aarch64-apple-darwin.tar.xz"
      sha256 "e2908271b7c20ceee3f7e493faab0efce2e0fc063f0424f5c16fa134f157faa1"

      def install
        bin.install "pond"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.5.2/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "abde10b8cb18992871fc51127f8fdfead57f3b33db0dcbafb634c00f28a1af92"

      def install
        bin.install "pond"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.5.2/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c9781fd054a276ffd3287050c6ac87356cd3c008d2afd53ff75f10400dd93728"

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
