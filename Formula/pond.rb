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
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.14.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "36f9550010c3bfa3906803937712e1f5499ec35977c0df7f9e0f0f44926d81b9"
    end
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "36f9550010c3bfa3906803937712e1f5499ec35977c0df7f9e0f0f44926d81b9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "486fbdf80676d77bec1aa895c16c1d6d62f6d966d612de1c1ee80d36f586a48b"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.14.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "09bec41fbf5f8b2b2f7b76f609dc2af03200047dfdd60d6f6bded6080c38ba5f"
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
