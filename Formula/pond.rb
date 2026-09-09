# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and full-text/semantic search for AI agent sessions"
  homepage "https://pond.locker/"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    # Apple Silicon only: there is no x86_64-apple-darwin build, so
    # the arch dependency refuses Intel before any download is attempted.
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.17.1/pond-aarch64-apple-darwin.tar.xz"
      sha256 "b8afeab8b0c430ad89b47f5a218b8f52d8a34fdffcb9a273bc99e2132b2dfcc6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.17.1/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "85abf4069bd6df957df5abbdc8732dd01cf5afe3f7f8a055c1d12e2395b6bf93"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.17.1/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6662016cde520d9289702f8710409db764f29cde38137b18dbcf42e151703441"
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
