class GraphvizLite < Formula
  desc "Graph visualization software from AT&T and Bell Labs"
  homepage "https://www.graphviz.org/"
  sha256 "e6f0ac0b975bcadc000559d5a767111737d0a03919dfc0e47ce6450c877c7834"
  url "https://gitlab.com/api/v4/projects/4207231/packages/generic/graphviz-releases/3.0.0/graphviz-3.0.0.tar.gz"

  license "EPL-1.0"
  version_scheme 1
  revision 2

  depends_on "pkg-config" => :build
  depends_on "bison" => :build
  depends_on "expat"
  depends_on "freetype"
  depends_on "fontconfig"
  depends_on "gd"
  conflicts_with "graphviz", because: "graphviz-lite is just a light build of the same package"

  uses_from_macos "flex" => :build

  def install
    ENV["YACC"] = "/usr/local/opt/bison/bin/yacc"
    ENV["PKG_CONFIG_PATH"] = "/usr/local/opt/expat/pkgconfig"
    ENV["LDFLAGS"] = "-L/usr/local/opt/bison/lib -L/usr/local/opt/expat/lib"
    ENV["CPPFLAGS"] = "-I/usr/local/opt/expat/include"
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
    ]

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
