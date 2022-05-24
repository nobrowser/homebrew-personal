class Souffle < Formula
  desc "Logic Defined Static Analysis"
  homepage "https://souffle-lang.github.io/"
  url "https://github.com/souffle-lang/souffle/archive/refs/tags/2.3.tar.gz"
  sha256 "db03f2d7a44dffb6ad5bc65637e5ba2b7c8ae6f326d83bcccb17986beadc4a31"
  license "UPL-1.0"

  depends_on "bison" => :build
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
