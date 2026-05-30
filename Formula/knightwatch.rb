class Knightwatch < Formula
  desc "System Monitoring tool"
  homepage "https://github.com/YofaGh/knightwatch"
  version "1.0.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.10/knightwatch-aarch64-apple-darwin.tar.xz"
      sha256 "caa5402b2776d8d6cddfb07d90d239bbcaa1a64a54f7876245a6fff55e9b7965"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.10/knightwatch-x86_64-apple-darwin.tar.xz"
      sha256 "bdf9391ac4f1a3346b29e60456fb0e19310d94c3b6e59d0f652ba417209201e9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.10/knightwatch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "659d6bc3cbbfb60cfe315972a68fb2544b08afbf9cfd037f39ac408db06356fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.10/knightwatch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9067e55a136e5309b129945a2b60f9870ae3b227c30b030d4555224992fe4d0b"
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
