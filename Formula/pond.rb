# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.locker/"
  version "0.13.1"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.13.1/pond-aarch64-apple-darwin.tar.xz"
      sha256 "6807a48358ddeb3fdf00409111302ad9371a635dacbf75c7f5a007e517059a16"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.13.1/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "96f7cc9f3d0c51e025a6aa89c9a7419569c99d5d1250056cb17c699b6a2c6e61"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.13.1/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b9f8f21d5ec9f5c85b5cabcd84fde53f1239e01772e0edad9ede999a131b68a3"
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
