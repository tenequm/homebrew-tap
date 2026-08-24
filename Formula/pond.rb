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
    url "https://github.com/tenequm/pond/releases/download/v0.15.1/pond-aarch64-apple-darwin.tar.xz"
    sha256 "4a7c47708359dfea4989700f61faee41f6f84915499b5d3ad6c85c917fbdfba9"
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.15.1/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cefcfe32557d6db517eea3f6005ab93a607bfd25d633adb174c6f1b690a33f33"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.15.1/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "633391fab4fb6c0742ad49d13fa9c9e7e56dd4db95671664887980d5a7ce20a8"
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
