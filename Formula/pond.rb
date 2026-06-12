# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.cascade.fyi/"
  version "0.8.0"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.8.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "a02e51cef226eb8edc30edcd0c63938bd59bb2519d0b307b386fd8da74c7cac2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.8.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b696f088a6037bcc32ee12fe7b01cd64fafbcaa2a8eef93d603b5f9d1f0dd4b7"
    end
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.8.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b2ee68a10ec78cef91d86d6b30b47f24790d0eb47d93ea1bd12fac438ee4ded5"
    end
  end

  def install
    bin.install "pond"
    generate_completions_from_executable(bin/"pond", "completions")
  end

  test do
    assert_match "pond #{version}", shell_output("#{bin}/pond --version")
    system bin/"pond", "--help"
    assert_match "_pond", shell_output("#{bin}/pond completions zsh")
  end
end
