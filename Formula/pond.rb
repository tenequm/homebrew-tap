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
      url "https://github.com/tenequm/pond/releases/download/v0.14.4/pond-aarch64-apple-darwin.tar.xz"
      sha256 "5792db392490f5b94d6f5ee45a5cb56b6e5572760e7a7b9b53d38442e5b92460"
    end
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.4/pond-aarch64-apple-darwin.tar.xz"
      sha256 "5792db392490f5b94d6f5ee45a5cb56b6e5572760e7a7b9b53d38442e5b92460"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.4/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0afd216c67c031a2fa371eaef3a44155d272bf75195f1fd30108b2420489847e"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.14.4/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "06336466923388c126a86cd029e5b3cbd28bf27210e06b8f2472badc456b209c"
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
