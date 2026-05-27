class Pond < Formula
  desc "Local session storage and retrieval for agentic clients"
  homepage "https://github.com/tenequm/pond"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.1.0/pond-aarch64-apple-darwin.tar.gz"
      sha256 "1e3c4ff656c2eb70d110f5cb0a3eeb1c76f2bcb7aed4cc3da6265342518a8fec"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tenequm/homebrew-tap/releases/download/pond-v0.1.0/pond-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c6725de789949042552f5ab8bb0827d04d94b9009014782c349a7742181611f8"
    end
  end

  def install
    bin.install "pond"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pond --version")
  end
end
