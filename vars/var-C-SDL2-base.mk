# SDL2 configuration for C compiler
CFLAGS	+=	$(shell pkg-config --cflags sdl2)
LDLIBS	+=	$(shell pkg-config --libs   sdl2)
#