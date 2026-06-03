class Knightwatch < Formula
  desc "System Monitoring tool"
  homepage "https://github.com/YofaGh/knightwatch"
  version "1.0.13"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.13/knightwatch-aarch64-apple-darwin.tar.xz"
      sha256 "3f5154cedce56b744fbdfaa7ded12ee260283b38ac53d3bb5fa3959425cf1a58"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.13/knightwatch-x86_64-apple-darwin.tar.xz"
      sha256 "f027e9e8f5af8e269f25c25f10a6b90e9f5cbb350a7acf66e4ff67262a401826"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.13/knightwatch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f44253b14e7dfb16480393ce7f5e61bfe5bd7b2679663c061d9cf570a879b58f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.13/knightwatch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8269422f3266f162b77f1212df8dbfa152ed86ce08397e7d153c9a19f1185aa8"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "knightwatch" if OS.mac? && Hardware::CPU.arm?
    bin.install "knightwatch" if OS.mac? && Hardware::CPU.intel?
    bin.install "knightwatch" if OS.linux? && Hardware::CPU.arm?
    bin.install "knightwatch" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
