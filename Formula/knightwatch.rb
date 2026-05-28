class Knightwatch < Formula
  desc "System Monitoring tool"
  homepage "https://github.com/YofaGh/knightwatch"
  version "1.0.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.8/knightwatch-aarch64-apple-darwin.tar.xz"
      sha256 "f6c84ce34f4f30fc718ace7de0d666d9864bac52c84719f3342a0518d299a1d2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.8/knightwatch-x86_64-apple-darwin.tar.xz"
      sha256 "56f36a88068a57964201a87912a1bde664ef093189c169d2690c5f82fba5550c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.8/knightwatch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6b441b9abff5d9329746ebc9233265444045e9107be7f900e24073c6c2b15a4c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.8/knightwatch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "99b2709507d26ee0dd96b213761d07bd7211e2bd44eb56ad2e553bb600924ce0"
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
