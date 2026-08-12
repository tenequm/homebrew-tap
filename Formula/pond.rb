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
    url "https://github.com/tenequm/pond/releases/download/v0.14.7/pond-aarch64-apple-darwin.tar.xz"
    sha256 "9b1404177f0a83eb4c5df3671897acc137348da332f00248190b9c7c8b0a6d6d"
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.7/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "684e62c697b972d20aeabfd6a68114d5e86fe2efe7e3dc59e2b708a097e8d036"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.14.7/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4f9175927e5b7164d50a6c3b5db348bebf1702559c4a20dd22ec05672594bffb"
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
