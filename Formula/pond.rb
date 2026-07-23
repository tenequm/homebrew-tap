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
      url "https://github.com/tenequm/pond/releases/download/v0.14.1/pond-aarch64-apple-darwin.tar.xz"
      sha256 "5c651b34875721a2c8b2f3a093718d3cce62db0130c5fdafb6acbb0490779acf"
    end
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.1/pond-aarch64-apple-darwin.tar.xz"
      sha256 "5c651b34875721a2c8b2f3a093718d3cce62db0130c5fdafb6acbb0490779acf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.1/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0906bf87b353561efb2f8f2096645330abc4b5357019b159849186c29455a186"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.14.1/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3b4b7050f4b21d662f54e805eef553a7bc1daabf8374804b14a74bdb3f225ee3"
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
