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
    url "https://github.com/tenequm/pond/releases/download/v0.17.0/pond-aarch64-apple-darwin.tar.xz"
    sha256 "8b187f7bc921a6fec4724fe6ed93ba86def9efa928b0e8556dbf99b1b8cebe87"
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.17.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a08181ecc19130bf5d42e3a7a9ff256b920d12a15f09cde6a274b572b9c5969b"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.17.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ec45d3867e91efd88034226e2c7c8b6ec1138e0b73cd3711d1d9f10616af0855"
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
