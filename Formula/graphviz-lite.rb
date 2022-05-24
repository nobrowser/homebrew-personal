class GraphvizLite < Formula
  desc "Graph visualization software from AT&T and Bell Labs"
  homepage "https://www.graphviz.org/"
  url "https://gitlab.com/graphviz/graphviz.git",
      tag:      "3.0.0",
      revision: "24cf7232bb8728823466e0ef536862013893e567"
  license "EPL-1.0"
  version_scheme 1
  head "https://gitlab.com/graphviz/graphviz.git", branch: "main"

  depends_on "pkg-config" => :build
  depends_on "bison" => :build
  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "expat"
  depends_on "freetype"
  depends_on "fontconfig"
  depends_on "gd"
  conflicts_with "graphviz", because: "graphviz-lite is just a light build of the same package"

  uses_from_macos "flex" => :build

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
      --disable-swig
      --disable-lefty
      --without-x
      --without-gdk
      --without-gdk-pixbuf
      --without-ghostscript
      --without-gtk
      --without-poppler
      --without-rsvg
      --with-freetype2
      --with-fontconfig
      --with-libgd
      --without-webp
      --with-expat
      YACC=/usr/local/opt/bison/bin/yacc
      LDFLAGS=-L/usr/local/opt/bison/lib
    ]

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"

    (bin/"gvmap.sh").unlink
  end

  test do
    (testpath/"sample.dot").write <<~EOS
      digraph G {
        a -> b
      }
    EOS

    system "#{bin}/dot", "-Tps2", "-o", "sample.pdf", "sample.dot"
  end
end
