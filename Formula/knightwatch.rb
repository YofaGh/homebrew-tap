class Knightwatch < Formula
  desc "System Monitoring tool"
  homepage "https://github.com/YofaGh/knightwatch"
  version "1.0.19"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/YofaGh/knightwatch/releases/download/knightwatch/1.0.19/knightwatch-aarch64-apple-darwin.tar.gz"
      sha256 "51ed1efdb101a411b9a896aeba7ab8e04ff59fcab40e5eb5c09b0f84059a836c"
    end
    on_intel do
      url "https://github.com/YofaGh/knightwatch/releases/download/knightwatch/1.0.19/knightwatch-x86_64-apple-darwin.tar.gz"
      sha256 "56c7bdf47a736b000943ee4685dbc7174159b71db28ef66bf3ba2e5712d93819"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/YofaGh/knightwatch/releases/download/knightwatch/1.0.19/knightwatch-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b6b413f64c5037a89739ee182469ddc00ccaeecfe81a3ec88572cd9c9e5c5fa3"
    end
    on_intel do
      url "https://github.com/YofaGh/knightwatch/releases/download/knightwatch/1.0.19/knightwatch-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8045e2372420979f3a75fbc694340ea6a6c4c2f30073fa859730dbe37038da34"
    end
  end

  def install
    bin.install "knightwatch"
  end

  test do
    system "#{bin}/knightwatch", "--version"
  end
end
