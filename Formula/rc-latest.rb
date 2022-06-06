class Rc < Formula
  desc "Implementation of the AT&T Plan 9 shell"
  homepage "http://doc.cat-v.org/plan_9/4th_edition/papers/rc"
  head "https://github.com/rakitzis/rc.git", revision "ceb59bb2a644f4ebc1645fe15f1063029579fa7c"
  license "Zlib"

  depends_on "automake" => :build
  depends_on "autoconf" => :build

  uses_from_macos "libedit"

  def install
    system "autoreconf", "-i"
    system "automake"
    system "./configure", "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--with-edit=edit"
    system "make"
    system "make", "install"
  end

  test do
    assert_equal "Hello!", shell_output("#{bin}/rc -c 'echo Hello!'").chomp
  end
end
