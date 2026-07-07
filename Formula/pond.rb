# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.locker/"
  version "0.12.2"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.12.2/pond-aarch64-apple-darwin.tar.xz"
      sha256 "b3aca6948e76247f1fa9edce2cfa7185d71147fbe10bb434a6aaf5681c2508c4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.12.2/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8199a367d96335b2568dfc3da27d7a5ef5d604657e04908bad23d45cdb5dbf8c"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.12.2/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "92d9f7df1037fcd5e0ad8646dce0f9210dc93ea89f7f949e5b9688bb40475209"
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
