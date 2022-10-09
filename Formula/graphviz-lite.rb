class GraphvizLite < Formula
  desc "Graph visualization software from AT&T and Bell Labs"
  homepage "https://www.graphviz.org/"
  sha256 "8eae137c4a2bdac7aa99bb13b748c55b9da9e9fb59f927fd50b84b56bf07f4cc"
  url "https://gitlab.com/api/v4/projects/4207231/packages/generic/graphviz-releases/6.0.1/graphviz-6.0.1.tar.xz"

  license "EPL-1.0"
  version_scheme 1
  revision 1

  depends_on "pkg-config" => :build
  depends_on "bison" => :build
  depends_on "expat"
  depends_on "freetype"
  depends_on "fontconfig"
  depends_on "gd"
  depends_on "webp"
  conflicts_with "graphviz", because: "graphviz-lite is just a light build of the same package"

  uses_from_macos "flex" => :build

  def install
    ENV["YACC"] = "/usr/local/opt/bison/bin/yacc"
    ENV["PKG_CONFIG_PATH"] = "/usr/local/opt/expat/lib/pkgconfig"
    ENV["LDFLAGS"] = "-L/usr/local/opt/bison/lib -L/usr/local/opt/expat/lib -L/usr/local/opt/webp/lib"
    ENV["CPPFLAGS"] = "-I/usr/local/opt/expat/include -I/usr/local/opt/webp/include"
    args = %W[
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
      --with-webp
      --with-expat
    ]

    system "./configure", *std_configure_args, *args
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
