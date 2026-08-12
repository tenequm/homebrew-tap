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
    url "https://github.com/tenequm/pond/releases/download/v0.14.9/pond-aarch64-apple-darwin.tar.xz"
    sha256 "1ab569676002f9b48126682462f6a26fd1bc2b59981d0027ef75c77911e301a9"
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.9/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "65eb23a8c3f3ebb03b413599c02caee48da1cc50cfa70be7f78abc254cd8c7ff"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.14.9/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "152bf781697fb09f907ee0311de1ae8bf84498f9515633129918428c54909908"
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
