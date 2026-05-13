################################################################################
#                                                                              #
# Copyright (c) 2026 Christian Gauger-Cosgrove                                 #
#                                                                              #
# Permission is hereby granted, free of charge, to any person obtaining a copy #
# of this software and associated documentation files (the "Software"), to     #
# deal in the Software without restriction, including without limitation the   #
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or  #
# sell copies of the Software, and to permit persons to whom the Software is   #
# furnished to do so, subject to the following conditions:                     #
#                                                                              #
# The above copyright notice and this permission notice (including the next    #
# paragraph) shall be included in all copies or substantial portions of the    #
# Software.                                                                    #
#                                                                              #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR   #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,     #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  #
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER       #
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING      #
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS #
# IN THE SOFTWARE.                                                             #
#                                                                              #
################################################################################



# Project-wide settings
debug ?= 0
NAME := libdatastore
BUILD_DIR := build
INCLUDE_DIR := include
LIB_DIR := lib
SRC_DIR := src

# object file paths
OBJS := $(patsubst %.c,%.o,$(wildcard $(SRC_DIR)/*.c))

# Compilers & Utilities
CC := gcc
AR := ar
RM := rm -rf

# General flag settings
#   CFLAGS
#     -std=c99: use ISO C99 standard
#     -fPIC: compile as position-indepdent code
#   CPPFLAGS
#     -D_LIB: 
#   ARFLAGS
#     rcs
CFLAGS := -std=c99 -fPIC
CPPFLAGS := -I$(INCLUDE_DIR)/ -D_LIB
ARFLAGS := rcs

# Debug & Release build specific settings
#     Debug Builds
#     ============
#   CFLAGS
#     -g: include debugging symbols
#     -O0: no optimizations
#   CPPFLAGS
#     -D_DEBUG: 
#
#     Release Builds
#     ==============
#   CFLAGS
#     -Ofast: optimize for speed
ifeq ($(debug), 1)
	CFLAGS += -g -O0
	CPPFLAGS += -D_DEBUG
else
	CFLAGS += -Ofast
endif

.PHONY: clean dir

all: $(NAME)

clean:
	$(RM) $(BUILD_DIR)
	$(RM) $(LIB_DIR)

dir:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(LIB_DIR)

$(NAME): dir $(OBJS)
	$(AR) $(ARFLAGS) $(patsubst %,$(LIB_DIR)/%.a,$@) \
	$(patsubst %,build/%,$(OBJS))

$(OBJS): dir
	mkdir -p $(BUILD_DIR)/$(@D)
	$(CC) $*.c $(CPPFLAGS) $(CFLAGS) -c -o $(BUILD_DIR)/$@
