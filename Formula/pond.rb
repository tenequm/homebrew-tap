# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.locker/"
  version "0.10.2"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.10.2/pond-aarch64-apple-darwin.tar.xz"
      sha256 "47a3170d515d1943f0d98f83476c477bc998ae39fe13be682a2a9845b9ca3c6c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.10.2/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "edadb50cdaf647513ddda56de492cbc62fbce096d67a232b935bab4e73e26e34"
    end
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.10.2/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9a9a5e71ac07bd9c0f8bc5ee84d12d6f45c2e4ac470a889d151a2b312ae150e0"
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
