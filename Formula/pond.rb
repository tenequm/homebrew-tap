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
      url "https://github.com/tenequm/pond/releases/download/v0.18.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "4bd5c3a9e10e40b77c254418dca94b6b99b5ed801fa2120b9a8769d641a85d18"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.18.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "afa2475309e9b5ff388a4c82222dacb1f604b65892976a1a7b39ef48cc4ceda4"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.18.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "928c9a8079fc9efcbe780915c47a50531b4bf23e2a835564e67a4aad1e9c2567"
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
