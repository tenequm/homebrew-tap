# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
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
    url "https://github.com/tenequm/pond/releases/download/v0.14.11/pond-aarch64-apple-darwin.tar.xz"
    sha256 "a8cf10af56dfbc91006f64b0b6b9f6ec1ecbefe2294bb644c5bc4605805cb780"
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.11/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cb306fb8b88bdc9da3a74b8aa3cbfc877853182a9b947be80c389d7d298ee3e8"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.14.11/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f0c5033294231c5bc5d76e9b8ad09c363fed5341671e59e7d23c2375695fb8b5"
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
