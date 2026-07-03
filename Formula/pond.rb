# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.locker/"
  version "0.11.2"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.11.2/pond-aarch64-apple-darwin.tar.xz"
      sha256 "ee225eb84fdefc54230d5800b0b5d40c0535a80ff6c4b7ac3bfd3c9db039957b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.11.2/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "620877814b7d67cf1fa2eaa66eeed123c642ae40f34b9bbf0bc765213ae4ffec"
    end
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.11.2/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4052dd6a79f8ae815a77de6dc5e5e7161e162d845016c003a44dc00e476efd1e"
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
