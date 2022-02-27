class Encpipe < Formula
  desc "Extremely simple encryption filter"
  homepage "https://github.com/jedisct1/encpipe"
  url "https://github.com/nobrowser/encpipe/releases/download/0.5/encpipe-0.5.tar.xz"
  sha256 "3c7f889080255738cf8d0de9c8bad51722b6544635cee2b29d89becb63d0b7c4"
  license "ISC"

  def install
    system "make"
    system "env", "PREFIX=#{prefix}", "make", "install"
  end

  test do
    system "sh", "-c", "echo test | ./encpipe -e -p password | ./encpipe -d -p password -o /dev/null"
  end
end
