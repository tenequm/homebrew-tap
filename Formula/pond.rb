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
      url "https://github.com/tenequm/pond/releases/download/v0.17.2/pond-aarch64-apple-darwin.tar.xz"
      sha256 "9feb9ee2ac1a0df17e8ba6002f93fa223a065c042af0ee48fc951c29dd9ff729"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.17.2/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "82298d1cdced9cc45bb110fca89b2c8767844e0faca8efd84bd42987747c8fc0"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.17.2/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f744319d8ed5459f8aa2f79a708bf6536e0dcbaeebefcdaa5a644bb8932842b5"
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
