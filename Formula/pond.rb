# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.locker/"
  version "0.10.1"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.10.1/pond-aarch64-apple-darwin.tar.xz"
      sha256 "75d7c4b4072b552db8b1d3465e5de73d33ea3fe3ec1b0512ee081eb43744913d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.10.1/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "701df4ff94faca2d78976cd4093c442b7aa7e8937d8c817a9d9f749f1a500588"
    end
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.10.1/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "696c8ca617fe6f3114dda8b1b89b57ed67d843d676e46702ebca643d3b1f301f"
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
