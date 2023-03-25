class Whisper < Formula
  desc "Very simple speech transription model"
  homepage "https://github.com/ggerganov/whisper.cpp"
  url "https://github.com/ggerganov/whisper.cpp/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "69d47fc2ba982c42bd5bade4b7c827d5b3ed74b9c59323991c45a9f0f24eb6ed"

  license "MIT"
  revision 1

  resource("jfk_fellow_americans") do
    url "https://raw.githubusercontent.com/ggerganov/whisper.cpp/master/samples/jfk.wav"
    sha256 "59dfb9a4acb36fe2a2affc14bacbee2920ff435cb13cc314a08c13f66ba7860e"
  end

  resource("ggml_base_en") do
    url "https://huggingface.co/datasets/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin"
    sha256 "a03779c86df3323075f5e796cb2ce5029f00ec8869eee3fdfb897afe36c6d002"
  end

  def install
    system "make", "main", "libwhisper.a", "libwhisper.so"
    bin.install "main" => "whisper"
    lib.install "libwhisper.a", "libwhisper.so"
    include.install "ggml.h", "whisper.h"
  end

  test do
    resource("jfk_fellow_americans").stage do
      resource("ggml_base_en").stage do
        assert_match "fellow Americans", shell_output("#{bin}/whisper -f jfk.wav -m ggml-base.en.bin")
      end
    end
  end
end
