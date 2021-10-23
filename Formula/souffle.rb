class Souffle < Formula
  desc "Logic Defined Static Analysis"
  homepage "https://souffle-lang.github.io/"
  url "https://github.com/souffle-lang/souffle/archive/refs/tags/2.1.tar.gz"
  sha256 "866b5aeaf88c0c5c2c1b6cb2b33faa6a0084154f5396e644f11767d6fe82b1d6"
  license "UPL-1.0"

  depends_on "bison" => [:build, "3.0.4"]
  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "pkg-config" => :build
  depends_on "mcpp"
  uses_from_macos "libffi"

  def install
    # disable this BROKEN FKING SHITE !!!!
    system "sed", "-i", ".~bk~", "-e", "/^# Installing bash completion/,/^# [^-]/d", "CMakeLists.txt"
    with_env("CXX" => "/usr/bin/clang++") do
      system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    end
    system "cmake", "--build", "build"
    system "cmake", "--build", "build", "--target", "install"
  end

  test do
    assert_match "-- Analysis logs --\n\n-- Result --\n\n",
      shell_output("#{bin}/souffle --show=type-analysis /dev/null")
  end
end
