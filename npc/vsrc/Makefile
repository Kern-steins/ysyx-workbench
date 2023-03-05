SRC_ALL = $(wildcard *)
SRC_MAKE = $(wildcard Makefile)
SRC = $(filter-out $(SRC_MAKE), $(SRC_ALL))
PWD = $(shell pwd)

copy:$(SRC)
	cp $(SRC) ~/ysyx-workbench/nvboard/steins/vsrc

echo:
	@echo $(SRC_ALL)

.PHONY: copy echo
