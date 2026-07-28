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
      url "https://github.com/tenequm/pond/releases/download/v0.14.3/pond-aarch64-apple-darwin.tar.xz"
      sha256 "e06195a28edb2345f7cc0cc870ef478d093a867a98990be5f3dee7dc47314f3a"
    end
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.3/pond-aarch64-apple-darwin.tar.xz"
      sha256 "e06195a28edb2345f7cc0cc870ef478d093a867a98990be5f3dee7dc47314f3a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.3/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5352511f48ba464d0f6b95c18bcfe337404bef3526c32aa75873cf18aab0a5ea"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.14.3/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8a44565cb3c8d58f4606005707f2787db1ccbcf62e650d0e1481d8a87c0cce57"
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
