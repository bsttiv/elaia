# Elaia - a DNS Root Server written in RISC-V

Elaia is a *DNS Referral Root Server* entirely implemented in **RISC-V (RV64)** assembly. Therefore, the server
interacts directly with *Linux System Calls* without depending on **glibc**.

---

## Objectives

The main goal of this project is to build a DNS Root Server in a low level programming language for
educational purposes:
- Understand the format of DNS messages
- Handle raw UDP sockets through Linux's syscall ABI on RISC-V
- Implement the logic for resolving delegations to TLD's servers without a high level approach

---

## Requirements

If you are using a **x86_64** machine, you'll need the 64 bit RISC-V cross compilation toolchain and QEMU for
emulation:

### Debian / Ubuntu / WSL:
```bash
sudo apt update
sudo apt install -y gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu qemu-user gdb-multiarch dnsutils
```

## Running the program

Just run the following commands

```bash
make
qemu-riscv64 ./main
```

## What the fuck is that name

Elaia is the Ancient Greek word for 'Olive'. More specifically, it is said that the goddess Athena gifted an
olive tree to Athens, so that it gave its people peace and prosperity. Thus, I thought that, as this server
is basically the root of the chain of a number of other servers, it should have a mythical meaning.

## AI Usage

AI was only used for doubt solving purposes regarding the format of DNS messages, aswell as finding bugs
in the code that I personally couldn't see. No code was written by an AI.
