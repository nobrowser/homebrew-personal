class GraphvizLite < Formula
  desc "Graph visualization software from AT&T and Bell Labs"
  homepage "https://www.graphviz.org/"
  sha256 "59931082a3638139e06c296b96e860a9d338432af06f7f57a6ad8da5cbf465c7"
  url "https://gitlab.com/graphviz/graphviz/-/archive/3.0.0/graphviz-3.0.0.tar.gz"

  license "EPL-1.0"
  version_scheme 1

  depends_on "pkg-config" => :build
  depends_on "bison" => :build
  depends_on "expat"
  depends_on "freetype"
  depends_on "fontconfig"
  depends_on "gd"
  conflicts_with "graphviz", because: "graphviz-lite is just a light build of the same package"

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
