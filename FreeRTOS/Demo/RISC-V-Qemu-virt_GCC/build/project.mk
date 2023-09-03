include $(BUILD_DIR)/project.config

FREERTOS_ROOT_DIR=$(shell pwd)/../../../..
FREERTOS_VERSION=FreeRTOS_main
PROJECT=RISC-V-Qemu-virt_GCC

FREERTOS_DIR = $(FREERTOS_ROOT_DIR)/$(FREERTOS_VERSION)
RTOS_SOURCE_DIR = $(FREERTOS_DIR)/FreeRTOS/Source
RTOS_DEMO_DIR=$(FREERTOS_DIR)/FreeRTOS/Demo
PROJECT_DIR = $(RTOS_DEMO_DIR)/$(PROJECT)

DEMO_SOURCE_DIR = $(FREERTOS_DIR)/FreeRTOS/Demo

INCLUDES += -I$(DEMO_SOURCE_DIR)/Common/include
INCLUDES += -I$(PROJECT_DIR)
INCLUDES += -I$(RTOS_SOURCE_DIR)/include
INCLUDES += -I$(RTOS_SOURCE_DIR)/portable/GCC/RISC-V

C_FILES += main.c main_blinky.c riscv-virt.c ns16550.c \
	$(DEMO_SOURCE_DIR)/Common/Minimal/EventGroupsDemo.c \
	$(DEMO_SOURCE_DIR)/Common/Minimal/TaskNotify.c \
	$(DEMO_SOURCE_DIR)/Common/Minimal/TimerDemo.c \
	$(DEMO_SOURCE_DIR)/Common/Minimal/blocktim.c \
	$(DEMO_SOURCE_DIR)/Common/Minimal/dynamic.c \
	$(DEMO_SOURCE_DIR)/Common/Minimal/recmutex.c \
	$(RTOS_SOURCE_DIR)/event_groups.c \
	$(RTOS_SOURCE_DIR)/list.c \
	$(RTOS_SOURCE_DIR)/queue.c \
	$(RTOS_SOURCE_DIR)/stream_buffer.c \
	$(RTOS_SOURCE_DIR)/tasks.c \
	$(RTOS_SOURCE_DIR)/timers.c \
	$(RTOS_SOURCE_DIR)/portable/MemMang/heap_4.c \
	$(RTOS_SOURCE_DIR)/portable/GCC/RISC-V/port.c

ASM_FILES += $(PROJECT_DIR)/start.S
ASM_FILES += $(PROJECT_DIR)/vector.S
ASM_FILES += $(RTOS_SOURCE_DIR)/portable/GCC/RISC-V/portASM.S

COMMON_DIR = $(FREERTOS_ROOT_DIR)/common
INCLUDES += -I$(COMMON_DIR)
C_FILES += $(COMMON_DIR)/source/log.c
C_FILES += $(COMMON_DIR)/test/test_list.c

PLATFORM_DIR = $(abspath ../../../../platform/riscv)
INCLUDES += -I$(PLATFORM_DIR)
C_FILES += $(PLATFORM_DIR)/source/time.c
C_FILES += $(PLATFORM_DIR)/source/uart.c

LD_SCRIPT=$(PROJECT_DIR)/fake_rom.lds
LD_FLAGS += -Wl,--wrap,printf

C_FLAGS += -DCFG_USART_SUPPORT

C_FLAGS += \
	-D__riscv_float_abi_soft \
	-DportasmHANDLE_INTERRUPT=handle_trap

INCLUDES += -I../Common/include
INCLUDES += -I$(RTOS_SOURCE_DIR)/include
INCLUDES += -I$(RTOS_SOURCE_DIR)/portable/GCC/RISC-V
INCLUDES += -I$(RTOS_SOURCE_DIR)/portable/GCC/RISC-V/chip_specific_extensions/RV32I_CLINT_no_extensions
