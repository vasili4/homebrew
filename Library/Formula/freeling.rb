require 'formula'

class Freeling < Formula
  homepage 'http://nlp.lsi.upc.edu/freeling/'
  url 'http://devel.cpl.upc.edu/freeling/downloads/32'
  version '3.1'
  sha1 '42dbf7eec6e5c609e10ccc60768652f220d24771'

  depends_on 'icu4c'
  depends_on 'boost' => 'with-icu'
  depends_on 'libtool' => :build

  def install
    icu4c_prefix = Formula.factory('icu4c').prefix
    libtool_prefix = Formula.factory('libtool').prefix
    ENV.append 'LDFLAGS', "-L#{libtool_prefix}/lib"
    ENV.append 'LDFLAGS', "-L#{icu4c_prefix}/lib"
    ENV.append 'CPPFLAGS', "-I#{libtool_prefix}/include"
    ENV.append 'CPPFLAGS', "-I#{icu4c_prefix}/include"

    system "./configure", "--prefix=#{prefix}", "--enable-boost-locale"

    system "make install"
  end

  def test
    system "echo 'Hello world' | #{bin}/analyze -f #{share}/freeling/config/en.cfg | grep -c 'world world NN 1'"
  end
end
