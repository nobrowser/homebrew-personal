class GraphvizLite < Formula
  desc "Graph visualization software from AT&T and Bell Labs"
  homepage "https://www.graphviz.org/"
  sha256 "18aa54015337a6d16d323fa487ed386a8291adeb4b1378025bb115dfb0e64e93"
  url "https://gitlab.com/api/v4/projects/4207231/packages/generic/graphviz-releases/2.49.1/graphviz-2.49.1.tar.xz"
  license "EPL-1.0"
  version_scheme 1

  depends_on "pkg-config" => :build
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
