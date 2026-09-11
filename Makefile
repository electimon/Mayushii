VER := 0.0
SRCS := $(wildcard srcs/*.m)

build:
	objfw-compile --lib $(VER) -o mayushii $(SRCS)
	echo Done!

all: build
clean:
	rm libmayushii.so
	echo Done!
