BASEDIR	=	.

SRCDIR	=	$(BASEDIR)/src

GOFILES	=	$(wildcard  $(SRCDIR)/*.go)

.DEFAULT_GOAL := nothing

.IGNORE: run
run:
	go run $(GOFILES)

nothing:
