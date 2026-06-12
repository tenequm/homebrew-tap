# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.cascade.fyi/"
  version "0.8.1"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.8.1/pond-aarch64-apple-darwin.tar.xz"
      sha256 "78488029d8563b72e735cf082f5996c8e512996accd35e30cd16726bd117bbfc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.8.1/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "588bd703c35ca0543668dce6679d3c725d3f3ca7962b384f0009af29f4a00c67"
    end
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.8.1/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f2bd6521800b9f183d154b460c218b61277389ee5c5987f579aeb7feb5b8826e"
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
