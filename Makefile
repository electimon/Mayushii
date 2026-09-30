VER := 0.0
SRCS := $(wildcard srcs/*.m)
DATADIR ?= /usr/local/share
INCDIR ?= /usr/local/include
LIBDIR ?= /usr/local/lib

build:
	clang -DDATADIR=\"$(DATADIR)/mayushii\" -shared -fobjc-arc $(shell objfw-config --objcflags) -fPIC -Wl,-soname,libmayushii.so  -o libmayushii.so $(SRCS)
	echo Done!

all: build
clean:
	rm -f libmayushii.so || rm mayushii0.dll || true
	echo Done!

HDRS := $(wildcard srcs/*.h)

install: build
	install -Dm644 libmayushii.so $(LIBDIR)/libmayushii.so
	install -d -m 0755 $(INCDIR)/mayushii
	for hdr in $(subst srcs/,,$(HDRS)); do \
		install -Dm644 "srcs/$$hdr" "$(INCDIR)/mayushii/$$hdr"; \
	done
	install -d -m 0755 $(DATADIR)/mayushii
	install -Dm644 srcs/mime.types $(DATADIR)/mayushii/mime.types