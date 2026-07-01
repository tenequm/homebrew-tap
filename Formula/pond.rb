# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.locker/"
  version "0.11.0"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.11.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "7e28a8b94e72f25768efa2be4e3a9837cb4a48c0adf7baf1abe4964c09d12a27"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.11.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c254d11dc4417b102bcfdde95c8187c7a7073d50bcf0113d4ad4ed456ad9eef8"
    end
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.11.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a6a712bfd81feebe344bad7146fdd9cc1404affadd2d136475f35ea417c36862"
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
