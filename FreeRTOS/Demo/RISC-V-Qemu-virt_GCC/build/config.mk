_CROSS_COMPILER_PREFIX_=/opt/riscv/bin/riscv64-unknown-elf-

_CROSS_COMPILER_GCC_=$(_CROSS_COMPILER_PREFIX_)gcc
_CROSS_COMPILER_G++_=$(_CROSS_COMPILER_PREFIX_)g++
_CROSS_COMPILER_LD_=$(_CROSS_COMPILER_PREFIX_)ld
_CROSS_COMPILER_OBJDUMP_=$(_CROSS_COMPILER_PREFIX_)objdump
_CROSS_COMPILER_OBJCOPY_=$(_CROSS_COMPILER_PREFIX_)objcopy
_CROSS_COMPILER_AR_=$(_CROSS_COMPILER_PREFIX_)ar
_CROSS_COMPILER_GDB_=$(_CROSS_COMPILER_PREFIX_)gdb
_CROSS_COMPILER_SIZE_=$(_CROSS_COMPILER_PREFIX_)size

C_FLAGS += -nostartfiles -march=rv32imac_zicsr -mabi=ilp32 -mcmodel=medany \
	-Xlinker --gc-sections -Wall -fmessage-length=0 -ffunction-sections \
	-fdata-sections -fno-builtin-printf -MMD -MP

LD_FLAGS += -nostartfiles -march=rv32imac -mabi=ilp32 -mcmodel=medany \
	-Xlinker --gc-sections -Xlinker --defsym=__stack_size=1000

ifeq ($(BUILD_TYPE), debug)
	C_FLAGS += -Og -ggdb3
else
	C_FLAGS += -O2
endif
