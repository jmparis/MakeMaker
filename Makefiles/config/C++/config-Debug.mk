# C++ Compiler flags, debug mode
CPPFLAGS_DBG ?=	-g3 -DDEBUG_ALL -std=c++14
CPPFLAGS	 +=	$(CPPFLAGS_DBG)
#