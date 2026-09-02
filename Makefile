PREFIX = riscv64-linux-gnu-
AS = $(PREFIX)as
LD = $(PREFIX)ld
EMU = qemu-riscv64

TARGET = main
SRCS = main.S
OBJS = main.o

.PHONY: all run clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) -o $@ $^

%.o: %.S
	$(AS) -o $@ $<

run: $(TARGET)
	$(EMU) ./$(TARGET)

clean:
	rm -f $(OBJS) $(TARGET)
