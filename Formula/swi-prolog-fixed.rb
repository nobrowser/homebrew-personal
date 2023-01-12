# typed: false

class SwiPrologFixed < Formula
  desc "ISO/Edinburgh-style Prolog interpreter"
  homepage "https://www.swi-prolog.org/"
  url "https://www.swi-prolog.org/download/stable/src/swipl-9.0.3.tar.gz"
  sha256 "e2919bc58710abd62b9cd40179a724c30bdbe9aa428af49d7fdc6d0158921afb"
  license "BSD-2-Clause"
  head "https://github.com/SWI-Prolog/swipl-devel.git", branch: "master"
  revision 2

  livecheck do
    url "https://www.swi-prolog.org/download/stable/src/"
    regex(/href=.*?swipl[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "berkeley-db@5"
  depends_on "gmp"
  depends_on "libarchive"
  depends_on "libyaml"
  depends_on "openssl@3"
  depends_on "ossp-uuid"
  depends_on "pcre2"
  depends_on "readline"
  depends_on "unixodbc"

  uses_from_macos "libxcrypt"
  uses_from_macos "ncurses"
  uses_from_macos "zlib"

  conflicts_with "swi-prolog", because: "this is just a fixed version of swi-prolog"

  def install
    ENV["PKG_CONFIG_PATH"] = "/usr/local/opt/libarchive/lib/pkgconfig:/usr/local/opt/openssl@3/lib/pkgconfig:/usr/local/opt/readline/lib/pkgconfig"
    ENV["LDFLAGS"] = "-L/usr/local/opt/berkeley-db@5/lib -L/usr/local/opt/libarchive/lib -L/usr/local/opt/openssl@3/lib -L/usr/local/opt/readline/lib"
    ENV["CPPFLAGS"] = "-I/usr/local/opt/berkeley-db@5/include -I/usr/local/opt/libarchive/include -I/usr/local/opt/openssl@3/include -I/usr/local/opt/readline/include"
    args = ["-DSWIPL_PACKAGES_JAVA=OFF", "-DSWIPL_PACKAGES_X=OFF", "-DCMAKE_INSTALL_RPATH=#{loader_path}"]
    system "cmake", "-G", "Ninja", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    cp_r "#{share}/pkgconfig", "#{lib}/pkgconfig"
  end

  test do
    (testpath/"test.pl").write <<~EOS
      test :-
          write('Homebrew').
    EOS
    assert_equal "Homebrew", shell_output("#{bin}/swipl -s #{testpath}/test.pl -g test -t halt")
  end
end
