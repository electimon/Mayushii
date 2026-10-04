VER := 0.0
SRCS := $(wildcard srcs/*.m)
OBJS := $(SRCS:.m=.o)
SYSDATADIR ?= /usr/local/share
SYSINCDIR ?= /usr/local/include
SYSLIBDIR ?= /usr/local/lib

IS_WINDOWS := false
MACHINE_OS := $(shell clang -dumpmachine | cut -d'-' -f3)
INSTALL_TARGET := libmayushii.so
ifeq ($(MACHINE_OS),windows)
IS_WINDOWS := true
INSTALL_TARGET := mayushii.dll
endif

build: $(OBJS)
ifneq ($(IS_WINDOWS),true)
	clang -shared $(shell objfw-config --libs) $(shell objfw-config --ldflags) -fPIC -Wl,--soname,libmayushii.so  -o libmayushii.so $(OBJS)
else
	clang -shared $(shell objfw-config --libs) $(shell objfw-config --ldflags) -fPIC  -o mayushii.dll $(OBJS)
endif
	echo Done!

srcs/%.o: srcs/%.m
	clang -DSYSDATADIR=\"$(SYSDATADIR)/mayushii\" $(shell objfw-config --objcflags) $(if $(filter %-NoArc.m,$<),-fno-objc-arc,-fobjc-arc) -fPIC -c -o $@ $<

all: build
clean:
	rm -f $(INSTALL_TARGET) $(OBJS) || true
	echo Done!

HDRS := $(wildcard srcs/*.h)

install: build
	install -Dm644 $(INSTALL_TARGET) $(SYSLIBDIR)/$(INSTALL_TARGET)
	install -d -m 0755 $(SYSINCDIR)/mayushii
	for hdr in $(subst srcs/,,$(HDRS)); do \
		install -Dm644 "srcs/$$hdr" "$(SYSINCDIR)/mayushii/$$hdr"; \
	done
	install -d -m 0755 $(SYSDATADIR)/mayushii
	install -Dm644 srcs/mime.types $(SYSDATADIR)/mayushii/mime.types
