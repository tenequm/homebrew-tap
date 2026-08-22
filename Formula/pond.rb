# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage, full-text search, and optional semantic search for sessions from any AI agent client"
  homepage "https://pond.locker/"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    # Apple Silicon only: there is no x86_64-apple-darwin build, so
    # depends_on refuses Intel before any download is attempted.
    depends_on arch: :arm64
    url "https://github.com/tenequm/pond/releases/download/v0.15.0/pond-aarch64-apple-darwin.tar.xz"
    sha256 "0caf8657d6450a78aa4a54f67c80c1b31f348f469258325454fd2556d4fdbd98"
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.15.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dc39cb5d66e36ee721c170c9a64ccde09eb9d46d022ffa88f194b55267f9756c"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.15.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "64af58158ac26d8d208bfdcdf13af2979431db8ea3a3a34b6599f15ad049ef17"
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
