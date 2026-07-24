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
      url "https://github.com/tenequm/pond/releases/download/v0.14.2/pond-aarch64-apple-darwin.tar.xz"
      sha256 "6f64ad2a8ca101a00fc69017fd39994201780e3a0e20bb1981f0cf249514a0db"
    end
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.2/pond-aarch64-apple-darwin.tar.xz"
      sha256 "6f64ad2a8ca101a00fc69017fd39994201780e3a0e20bb1981f0cf249514a0db"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.2/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c2936333fda6c33abfeb12b0439d1d94ddb5acdcf5d92be38528c8899da4f6ab"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.14.2/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "944fc24f93c9deb15520d304c40880168debe05c7984bb7c2dca7a8f95178b99"
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
