# typed: false
# frozen_string_literal: true
class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.cascade.fyi/"
  version "0.3.2"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/tenequm/homebrew-tap"
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.3.2/pond-aarch64-apple-darwin.tar.xz"
      sha256 "f0679de01dd5c69eaa8449da1d46ded7aec652b8a0ec4014d113d2f1a8c342e4"

      def install
        bin.install "pond"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.3.2/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "01785ad52210f29c24135b78aa825c4c3b204222ac4ed9c49f19c0a3aad8baae"

      def install
        bin.install "pond"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.3.2/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "af261c38acf7f30bca0fb5d34b2f2534719344aa55a2732bacd5461add68fe65"

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
