# typed: false

class SwiPrologFixed < Formula
  desc "ISO/Edinburgh-style Prolog interpreter"
  homepage "https://www.swi-prolog.org/"
  url "https://www.swi-prolog.org/download/stable/src/swipl-8.4.3.tar.gz"
  sha256 "946119a0b5f5c8f410ea21fbf6281e917e61ef35ac0aabbdd24e787470d06faa"
  license "BSD-2-Clause"
  revision 1
  head "https://github.com/SWI-Prolog/swipl-devel.git", branch: "master"

  livecheck do
    url "https://www.swi-prolog.org/download/stable/src/"
    regex(/href=.*?swipl[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "berkeley-db"
  depends_on "gmp"
  depends_on "jpeg"
  depends_on "libarchive"
  depends_on "libyaml"
  depends_on "openssl@1.1"
  depends_on "ossp-uuid"
  depends_on "pcre"
  depends_on "readline"
  depends_on "unixodbc"

  uses_from_macos "libxcrypt"
  uses_from_macos "ncurses"
  uses_from_macos "zlib"

  conflicts_with "swi-prolog", because: "this is just a fixed version of swi-prolog"

  def install
    args = ["-DSWIPL_PACKAGES_JAVA=OFF", "-DCMAKE_INSTALL_RPATH=@loader_path"]
    with_env(CPPFLAGS: "-I/usr/local/opt/libarchive/include", LDFLAGS: "-L/usr/local/opt/libarchive/lib") do
      system "cmake", "-G", "Ninja", "-S", ".", "-B", "build", *std_cmake_args, *args
    end
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    lib.install_symlink "../share/pkgconfig"
  end

  test do
    (testpath/"test.pl").write <<~EOS
      test :-
          write('Homebrew').
    EOS
    assert_equal "Homebrew", shell_output("#{bin}/swipl -s #{testpath}/test.pl -g test -t halt")
  end
end
