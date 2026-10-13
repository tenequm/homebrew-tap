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
      url "https://github.com/tenequm/pond/releases/download/v0.20.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "83d0b46e60b4a130c096f1525976b966d1c657d6e210fee59f4744edfe64f0f3"
    end
    # Never downloaded: the arch dependency above stops Intel first. It is here
    # because `brew readall` needs every platform to resolve a URL.
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.20.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "83d0b46e60b4a130c096f1525976b966d1c657d6e210fee59f4744edfe64f0f3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.20.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ae44a55419720389c2a6d725d39c1805ea0b98938b2960874b6ff5a00facdad0"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.20.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "212bdf44197c2d6b9e1e72edc80922d649bd944c40db0b6efa7284477a95428f"
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
