class Sfsexp < Formula
  desc "Simple library for parsing s-expressions"
  homepage "https://github.com/mjsottile/sfsexp"
  url "https://github.com/nobrowser/sfsexp/archive/refs/tags/1.3.1+gitd64ec00.tar.gz"
  version "1.3.1+gitd64ec00"
  sha256 "14e2c18a80bb3f37793aed7348772332435fa189f31575d7b0d943489ff00b78"
  license "LGPL-2.1-or-later"

  depends_on "autoconf" => :build

  def install
    system "autoreconf -i"
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make"
    system "make", "install"
  end

  test do
    # This is bad. I know!! I'll fix it later, I promise.
    system "false"
  end
end
