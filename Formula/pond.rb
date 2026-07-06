# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.locker/"
  version "0.12.1"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.12.1/pond-aarch64-apple-darwin.tar.xz"
      sha256 "f4bc4f3f3fa6357f7824e12c2a79acac5633deefe9ce476acad7c695ffe40c1a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.12.1/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5b829be61e54fc13d51111038389e36d55662ac4bc1d8a51d7626db4be6cf071"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.12.1/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "78f38da27601da888484ee946720cddb256ff4b3de329efac98b8f2e04cf470b"
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
