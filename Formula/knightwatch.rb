class Knightwatch < Formula
  desc "System Monitoring tool"
  homepage "https://github.com/YofaGh/knightwatch"
  version "1.0.17"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.17/knightwatch-aarch64-apple-darwin.tar.xz"
      sha256 "f821e3c006e8015524c69e7a21e5700541438bc702cd91d10a93b5641e2d4693"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.17/knightwatch-x86_64-apple-darwin.tar.xz"
      sha256 "42ff8b85388238c89eaf0812c43a18a6983dc30600fcd9b9172b4b4627983b1b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.17/knightwatch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a224bb9e55b844227c1223e8a4ead60beae426432962915c1e92e1e9621e6b9a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/YofaGh/knightwatch/releases/download/v1.0.17/knightwatch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7efe505ffe4b129cc0a696ea79d4cd2cac5f71681df567fab1244a11893768fa"
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
