# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and full-text/semantic search for AI agent sessions"
  homepage "https://pond.locker/"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    # Apple Silicon only: there is no x86_64-apple-darwin build, so
    # the arch dependency refuses Intel before any download is attempted.
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.19.2/pond-aarch64-apple-darwin.tar.xz"
      sha256 "dc953f38a79df4ad7694115a5b708d0c2bb24f0613a026cd4902aa03e8f2f7d2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.19.2/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "abe0bfebc37ff5c87386aa51de11705dd6c9dbce66bd638f9ee093c2be8bf02b"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.19.2/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d21cfdd23f43a7dfa7522b411c13f3825a4205b6b086ae8880c5561659257c89"
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
