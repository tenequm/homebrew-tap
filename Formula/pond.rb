# typed: false
# frozen_string_literal: true
class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.cascade.fyi/"
  version "0.6.0"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/tenequm/homebrew-tap"
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.6.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "b4631b3ed6701ebd4322cf55ab14c21304c0592f785ee21555e16dbab683a143"

      def install
        bin.install "pond"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.6.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "44a43ab89272298c52323dca844da011e9c20c35cda94ad2a49de548fefdb553"

      def install
        bin.install "pond"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.6.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "abde632155918f345c1eb816759c9d3ba5c49b53a0fdf6803e9c84f17a6fcf6e"

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
