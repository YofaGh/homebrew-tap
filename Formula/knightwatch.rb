class Knightwatch < Formula
  desc "System Monitoring tool"
  homepage "https://github.com/YofaGh/knightwatch"
  version "1.0.12"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.12/knightwatch-aarch64-apple-darwin.tar.xz"
      sha256 "5bedfae55018bed040d7d3d85db270c38ca50c0fb94b67a498242c8a04df7d1d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.12/knightwatch-x86_64-apple-darwin.tar.xz"
      sha256 "1dd4757c2d748712334d493cc8701dadb38ba8a371312abfecccfeda1a50fc93"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.12/knightwatch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b3426a46d3cc5f9477a1cd72a1ada3b3bf4ecc896d243167b1694e66102379a3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.12/knightwatch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d0f22dd28950af09fbae3b6e88465e8ce08d7d7f055415febf25f359cc339a14"
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
