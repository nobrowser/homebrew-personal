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
    system "make", "-j1"
    system "make", "-j1", "install"
  end

  test do
    assert_match "> 2\n",
      shell_output("{ echo '(+ 1 1)' ; echo ',exit' ; } | #{bin}/scsh | sed -n -e 3p")
  end

end
