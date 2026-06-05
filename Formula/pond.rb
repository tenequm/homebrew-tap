# typed: false
# frozen_string_literal: true
class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.cascade.fyi/"
  version "0.5.0"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/tenequm/homebrew-tap"
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.5.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "0b7ee7e21f75a451ee509e0352cc1a3c81c49bc12c89ab5ec593ccd6dd1d65f4"

      def install
        bin.install "pond"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.5.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "863035bf8aa7a36ee52f513ac9b037a032b689224eeb87737cd986da9c8ed6cb"

      def install
        bin.install "pond"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.5.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "369ddf389fcdcf844bfc895d82aa91822703fdf9a055c8e056900b73da0b9870"

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
