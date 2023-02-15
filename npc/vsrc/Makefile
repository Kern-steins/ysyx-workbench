SRC_ALL = $(wildcard *)
SRC_MAKE = $(wildcard Makefile)
SRC = $(filter-out $(SRC_MAKE), $(SRC_ALL))
PWD = $(shell pwd)

.PHONY: copy
copy:$(SRC)
	@cp $(SRC) ~/steins_verilog/

