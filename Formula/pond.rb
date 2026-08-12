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
    # Apple Silicon only: there is no x86_64-apple-darwin build, so
    # depends_on refuses Intel before any download is attempted.
    depends_on arch: :arm64
    url "https://github.com/tenequm/pond/releases/download/v0.14.8/pond-aarch64-apple-darwin.tar.xz"
    sha256 "c7a9439a2c389681bd3f33ebbad33b5f904c2f7d4439384487f88a52df06d7e8"
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.8/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f4a0b49c12b494231af02b21bf80ae7e4bf081f6d42cb3a1cb30d94ed9b10e86"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.14.8/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a29b07023f203397fe3783c7b64bd836a6b8ffba5aa99e95ec76819ce8af331d"
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
