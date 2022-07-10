class Snd < Formula
  desc "Sound toolkit embedded in Scheme"
  homepage "https://ccrma.stanford.edu/software/snd/"
  url "https://ccrma.stanford.edu/software/snd/snd-22.5.tar.gz"
  sha256 "6bf9d8aba09f6f1f778df03a23c8adf94d14dfa74e0054a9462b37daca4f92ce"
  license "TCL"
  revision 1

  depends_on "flac"
  depends_on "gsl"
  depends_on "mpg123"
  depends_on "vorbis-tools"

  def install

    system "./configure", "--without-gui", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    assert_equal "3", shell_output("#{bin}/snd -eval '(begin (display (+ 1 2)) (exit))'")
  end
end
