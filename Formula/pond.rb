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
    url "https://github.com/tenequm/pond/releases/download/v0.14.5/pond-aarch64-apple-darwin.tar.xz"
    sha256 "95ded0a46eedcaae17126cdac3f2f96e1a9b7099d46987d20fd8fc9afac7eaa5"
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.5/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "791dc0feea14398f21ce9ab059d03f16bc2bf4f66487423302705ee306406a5a"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.14.5/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a55b41413a06dbc354da27a83a58150cb9001363e995cca401f2aa9bfa9f5dff"
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
