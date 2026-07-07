# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.locker/"
  version "0.13.0"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.13.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "71fcebbb0b1e51c0e571525a52781082fe85fea8244e582869a72a94886181d4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.13.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a322ec66bf7925cd42f9803fc22da334e9bc00d1750128ea12412f0a9f1c85bf"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.13.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dab643006a089877ce19ac651f45a2a00665e50ae6edb668d04441518de44627"
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
