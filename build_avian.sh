if [ ! -d downloads ]; then
    mkdir downloads
fi

cd downloads

openjdk="openjdk-1.7.0-u80-unofficial-macosx-x86_64-image"

if [ ! -d "$openjdk" ]; then
    curl -OfL https://bitbucket.org/alexkasko/openjdk-unofficial-builds/downloads/$openjdk.zip
    unzip $openjdk.zip
fi

if [ ! -d "jdk7u" ]; then
    hg clone http://hg.openjdk.java.net/jdk7u/jdk7u/
fi

cd jdk7u
bash get_source.sh
cd jdk
hg checkout jdk7u80-b32
cd ../../

patch --verbose -N downloads/jdk7u/jdk/src/share/javavm/export/jvm.h < GetClassLoader.patch

if [ ! -d "avian" ]; then
    git clone https://github.com/readytalk/avian.git
fi

if [ ! -d "lzma-920" ]; then
    wget https://sourceforge.net/projects/sevenzip/files/LZMA%20SDK/lzma920.tar.bz2
    (mkdir -p lzma-920 && cd lzma-920 && tar xjf ../lzma920.tar.bz2)
fi

cd ../
ant package-avian
