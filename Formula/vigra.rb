class Vigra < Formula
  desc "Image processing library mostly based on C++ templates"
  homepage "https://ukoethe.github.io/vigra"
  url "https://github.com/ukoethe/vigra/releases/download/Version-1-11-1/vigra-1.11.1-src.tar.gz"
  sha256 "a5564e1083f6af6a885431c1ee718bad77d11f117198b277557f8558fa461aaf"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "openexr"

  resource("vigra_flip_source") do
    url "https://raw.githubusercontent.com/nobrowser/homebrew-personal/master/fixtures/vigra_flip.c%2B%2B"
    sha256 "b7ffeae63d9c24233c5b5bf7610639d67ab13b3cdcb646f762bded69eade1551"
  end

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    resource("vigra_flip_source").stage do
      assert_equal "", shell_output("c++ -w -o a.out -L #{lib} -l vigraimpex vigra_flip.c++")
    end
  end
end
