Protobuf 3.6.0

This is pre-packaged and prepared to be placed inside your dependencies directory.

To build from source, (not required), run the following commands:
wget https://github.com/google/protobuf/releases/download/v3.6.0/protobuf-cpp-3.6.0.tar.gz
tar xzf protobuf-cpp-3.6.0.tar.gz
cd protobuf-3.6.0
./autogen.sh
./configure
make
make check
sudo make install

Search for the /usr/local/lib/libprotobufd.so.16 file and copy it into the dependencies/protobuf/linux/x64/lib directory.
