# typed: false
# frozen_string_literal: true
class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.cascade.fyi/"
  version "0.3.0"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/tenequm/homebrew-tap"
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.3.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "21e1ae39b1a099f9d6e385da4c36303037e59f7ed396d980c21760d2469bfee8"

      def install
        bin.install "pond"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.3.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1486a7ed31d172d5b028c445117e46411df3c41973a80b1478b743e1617c0f69"

      def install
        bin.install "pond"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.3.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1c199433f6602109fbdc27adbc06b1f777e9fe793cd0cb5a27f74af52faffee6"

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
