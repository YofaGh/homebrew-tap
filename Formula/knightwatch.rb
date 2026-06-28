class Knightwatch < Formula
  desc "System Monitoring tool"
  homepage "https://github.com/YofaGh/knightwatch"
  version "1.0.18"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/YofaGh/knightwatch/releases/download/1.0.18/knightwatch-aarch64-apple-darwin.tar.gz"
      sha256 "f0aa7d28083954f1ed1b5647ba745af55a3cbaca5dc853fb77f58dd596489feb"
    end
    on_intel do
      url "https://github.com/YofaGh/knightwatch/releases/download/1.0.18/knightwatch-x86_64-apple-darwin.tar.gz"
      sha256 "2073e1b1c92c5495f6762357afa500594ea6aab9aa7d15be21363e09da560be5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/YofaGh/knightwatch/releases/download/1.0.18/knightwatch-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "74c148aa267b996cde370fb210d7680a0f25a63d57a77ffd5e8f14f378e57c1d"
    end
    on_intel do
      url "https://github.com/YofaGh/knightwatch/releases/download/1.0.18/knightwatch-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ada7b2b906295019d29e0169f51cbe7af70e6ec3e0e10bbe4facdee0ba35dc20"
    end
  end

  def install
    bin.install "knightwatch"
  end

  test do
    system "#{bin}/knightwatch", "--version"
  end
end
