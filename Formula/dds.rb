class Dds < Formula
  desc "Double dummy bridge hand solving library"
  homepage "https://privat.bahnhof.se/wb758135/bridge/index.html"
  url "https://github.com/dds-bridge/dds/archive/refs/tags/v2.9.0.tar.gz"
  sha256 "9ef36d8c36bf697ba3b499fcb9dca51a4b423278ac72e947235ac86f0b5fc38a"
  license "Apache-2.0"

  def install
    cp "src/Makefiles/Makefile_Mac_clang_static", "src/Makefile"
    inreplace "src/Makefile" do |s|
      s.gsub!(/^THREADING[[:blank:]]*=.*/, "THREADING = -DDDS_THREADS_STL")
      s.gsub!(/^THREAD_LINK[[:blank:]]*=.*/, "THREAD_LINK =")
      s.gsub!(/^CC[[:blank:]]*=.*/, "CC = c++")
    end
    system "make", "-C", "src"
    lib.install "src/libdds.a" => "libdds.a"
    include.install "include/dll.h" => "dds.h"
  end

  test do
    system "false"
  end
end
