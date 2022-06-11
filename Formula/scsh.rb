class Scsh < Formula
  desc "A shell embedded in Scheme"
  homepage "https://scsh.net"
  url "https://github.com/scheme/scsh.git", revision: "4acf6e4ed7b65b46186ef0c9c2a1e10bef8dc052"
  version "0.7"
  license "BSD-3-Clause"

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "scheme48"

  def install
    system "autoreconf", "-i"
    system "./configure", *std_configure_args
    system "make"
    system "make", "install"
  end

end
