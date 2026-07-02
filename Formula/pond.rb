# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.locker/"
  version "0.11.1"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^pond[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.11.1/pond-aarch64-apple-darwin.tar.xz"
      sha256 "a0ed793214b27136a08ab54569c797f35060f7dd3a8b80f316dd967458519ee5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.11.1/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "18edda94f793fb92fab4393b9cf341d92d78142a4813c005f385e3bfe9393320"
    end
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.11.1/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fc5ab3753ee34b630b0045f9eb0212882f92011d7c13b7c60eb5b322a8d0f92d"
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
