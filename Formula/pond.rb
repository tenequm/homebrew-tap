# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.cascade.fyi/"
  version "0.9.0"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.9.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "0080df05b3c85993d6ed23c0ffb2bbea3c3bc593ad8660af4e1e1b506b68a99e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.9.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2e3f1274a24f7a89df6cab68a01f3f94463de3c4aa12777658deb2bca3da6355"
    end
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.9.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "595bcc8e0aedc08f3e2428f94a380b6be427af09a544f35a45de881fde04c3fa"
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
