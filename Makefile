VER := 0.0
SRCS := $(wildcard srcs/*.m)

build:
	clang -shared -fobjc-arc $(shell objfw-config --objcflags) -fPIC -Wl,-soname,libmayushii.so  -o libmayushii.so $(SRCS)
	echo Done!

all: build
clean:
	rm -f libmayushii.so || rm mayushii0.dll || true
	echo Done!

install: build
	install -Dm644 libmayushii.so /usr/local/lib/libmayushii.so
	install -d -m 0755 /usr/local/include/mayushii
	install -Dm644 srcs/MYArgParser.h /usr/local/include/mayushii/MYArgParser.h
	install -Dm644 srcs/MYArgParser-Classes.h /usr/local/include/mayushii/MYArgParser-Classes.h
