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
      url "https://github.com/tenequm/pond/releases/download/v0.19.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "48b1889236d923d673417ee88948f37f4c902f995cde7f9c4bdea385a5f63c65"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.19.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "63758b0f0a5414d7756e1324226ff24185923cf46ff2d208c8a673f14e46da68"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.19.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "913b2bb52352bbc9d641882fea2e05cda9e238a0fa438bc8d1463981d31d7c35"
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
