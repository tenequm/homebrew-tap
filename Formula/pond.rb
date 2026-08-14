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
    url "https://github.com/tenequm/pond/releases/download/v0.14.10/pond-aarch64-apple-darwin.tar.xz"
    sha256 "dd99960cd6b1989a48cfdb04813a7ee786ed95807741e389ef01c851df8248ea"
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.14.10/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dd0ec19a797a8794803cc913412e7740c0e8e02634b75826f7ae08f106a4b7fc"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.14.10/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "45db06cc2cdaf9aa551f153101b8552bbe780908927e5f7882fee6127d4c65fd"
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
