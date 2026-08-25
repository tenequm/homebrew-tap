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
    url "https://github.com/tenequm/pond/releases/download/v0.16.1/pond-aarch64-apple-darwin.tar.xz"
    sha256 "5690e121c28c9caef57fb8eb79867faabb9e02f60b9968e0206e42829222ef52"
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.16.1/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "963730db8c1bd8a7e6c04e5b5905620d9f58e30c6f784d93e5811c7357526980"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.16.1/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9d542545fcf30a4793cc888a7e3f5502ffef52dbeb5ad8ccbca3e30d0e054e12"
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
