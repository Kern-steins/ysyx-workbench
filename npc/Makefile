SHELL := /bin/bash

MODULE =dut
VSRC = $(shell find $(abspath ./vsrc) -name "*.v" -o -name "*.sv")
INC = $(wildcard ./csrc/*.h)
SRC_ALL = $(wildcard ./csrc/*.cpp ./csrc/*.c)
MAIN_SRC = $(wildcard ./csrc/main.cpp)
SRC = $(filter-out $(MAIN_SRC), $(SRC_ALL))
TRASH = $(wildcard *.o main)
LIB_SRC = $(wildcard libsteins.a)
TB_SRC = $(shell find $(abspath .) -name "tb*.cpp")
EMPTY=

VERILATOR = verilator
VERILATOR_CFLAGS += -MMD --build -cc \
					-O3 --trace --x-assign fast \
					--x-initial fast --noassert 

OBJ_DIR = ./obj_dir
INC_PATH ?=
BIN = $(BUILD_DIR)/$(MODULE)

INCFLAGS = $(addprefix -I, $(INC_PATH))
CFLAGS += $(INCFLAGS) -DTOP_NAME="\"V$(MODULE)\""
LDFLAGS += -lSDL2 -lSDL2_image

default:$(BIN)

echo:
	@echo $(VSRC)
sim: waveform.vcd
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@echo "### WAVES ###"	
	gtkwave waveform.vcd -a gtkwave_setup.gtkw


waveform.vcd: $(OBJ_DIR)/V$(MODULE)
	@echo
	@echo "### SIMULATING ###"
	$(OBJ_DIR)/V$(MODULE) +verilator+rand+reset+2 

$(OBJ_DIR)/V$(MODULE): $(BIN) 
	@echo
	@echo "### BUILDING SIM ###"
	make -C obj_dir -f V$(MODULE).mk V$(MODULE)

$(BIN): $(VSRC) $(TB_SRC) 
	@echo
	@echo "### VERILATING ###"
	$(VERILATOR) $(VERILATOR_CFLAGS) \
		--top-module $(MODULE) -cc $(VSRC) \
		--exe $(TB_SRC)
.PHONY:lint
lint: ./vsrc/$(MODULE).sv
	verilator --lint-only ./vsrc/$(MODULE).sv

.PHONY:main	
main : $(MAIN_SRC)
ifeq ($(LIB_SRC), $(EMPTY))
	g++ $(MAIN_SRC) -Wall -Og -g -o main
else
	g++ $(MAIN_SRC) -Wall -Og -g -L. -lsteins -Iinc -o main
endif

.PHONY:lib
lib: $(SRC) $(INC) 
	$(call clean_trash)
	@echo "building lib file"
	gcc -c $(SRC)
	ar rs libsteins.a $(wildcard *.o)
	$(call clean_trash)

.PHONY:indent
indent: $(SRC_ALL) $(INC)
	-astyle --style=kr $(SRC_ALL)
	-astyle --style=kr $(INC)

.clean_trash:
ifeq ($(TRASH), $(EMPTY))

else
	@rm $(TRASH)
	@echo "clean done"
endif

include ../Makefile

.PHONY: default sim 