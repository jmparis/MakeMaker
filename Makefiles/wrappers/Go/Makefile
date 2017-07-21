#
# Makefile by MakeMaker
# 06/07/2017 16:03 CEST
# C++ Executable wrapper
#

# Ensure we can compute the rest of the Makefile
ifndef	MKMK_HOME
$(error Error the variable 'MKMK_HOME' is not defined!)
endif

# Target is Go, No type.
LANG=Go
TYPE=

# Include the skeleton defined for the language
include ${MKMK_HOME}/Makefiles/skeletons/$(LANG).mk

# Ensure Makefile wrapper is always up todate
include ${MKMK_HOME}/Makefiles/rules/Makefile-update.mk
