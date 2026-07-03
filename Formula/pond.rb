# typed: false
# frozen_string_literal: true

class Pond < Formula
  desc "Lossless storage and hybrid search for sessions from any AI agent client"
  homepage "https://pond.locker/"
  version "0.12.0"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_releases
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.12.0/pond-aarch64-apple-darwin.tar.xz"
      sha256 "50923d9151e6a3dc0ed8645a05883f8d11cb1cf3878d067faac2b920e0e81775"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/pond/releases/download/v0.12.0/pond-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "05a2e2b4e80cf3af114906dd7bf44870e5886c66e7d0738aa20584472037dde1"
    end
    on_arm do
      url "https://github.com/tenequm/pond/releases/download/v0.12.0/pond-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "561d54edce645822f3dd273a24f1cd0795848c34ba1b3541992841048a16adac"
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
