# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage, full-text search, and optional semantic search for sessions from any AI agent client"
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
    url "https://github.com/tenequm/pond/releases/download/v0.16.3/pond-aarch64-apple-darwin.tar.xz"
    sha256 "14437d58572bf93e6c9e261f5869977c2a8d9a27c098e088435429ce2a110b0c"
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.16.3/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "68888f85f17020ab95460391dc23b7abb51cb48146f43595256abe7491e660c6"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.16.3/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2ef8b2e7a9c542fd11ec18fa7c4fe17663ad3ddc4d6ae90ee6616dc08156c5bb"
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
