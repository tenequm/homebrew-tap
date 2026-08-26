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
    url "https://github.com/tenequm/pond/releases/download/v0.16.2/pond-aarch64-apple-darwin.tar.xz"
    sha256 "996d5396a96740e2228d534a02589b339e10d5ce862e84bc4624286f408760fd"
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.16.2/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "86022086c6baf6a9c20ef66e9dae05d8ffe807a88c056c696fed45fb61e43669"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.16.2/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "25ddfcc61864586e2fb3d1c40d4708453eb72b64f7bd49ea4ee2304eea830a21"
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
