.global _start

.section .data
.align 3
sockaddr:
        .half 2 # AF_INET (IPV4)
        .half 0xb414 # port 5300
        .word 0x0100007F # localhost
        .zero 8

.section .text

_start:
        # --- Socket creation through a sys_socket syscall ---
        li a7, 198 # sys_socket
        li a0, 2 # domain : AF_INET
        li a1, 1 # type: SOCK_STREAM
        li a2, 0 # protocol = 0
        ecall # syscall

        mv s0, a0 # Persistent saving of the socket file descriptor

        # --- Socket binding to localhost:5300 ---
        li a7, 200 # sys_bind
        mv a0, s0 # socket file descriptor
        la a1, sockaddr # pointer to sockaddr address
        li a2, 16 # sockaddr's size (16 bytes)
        ecall

        # --- Call to sys_listen ---
        li a7, 201 # sys_listen
        mv a0, s0 # socket file descriptor
        li a1, 5 # Max socket size (set to five, not really convenient for a root server)
        ecall       

loop_accept:
        # --- Call to sys_accept ---
        li a7, 202 # sys_accept
        mv a0, s0 # socket file descriptor
        li a1, 0 # set to NULL, not interested in peer client's IP
        li a2, 0 # also set to NULL, as specified in man accept
        li a3, 0
        ecall

        bltz a0, loop_accept

        mv s1, a0 # s1 = client's socket file descriptor

        jal ra, handle_client # client handling logic
        
        j loop_accept # Infinite loop

handle_client:
        # We create a 4096 byte buffer to read the incoming message
        li t0, -4096
        add sp, sp, t0
        # --- Call to read ---
        li a7, 63 # read
        mv a0, s1 # client's socket file descriptor
        mv a1, sp # the buffer is saved in the stack, so we pass its address
        li a2, 4096 # size to read (4096 bytes)
        ecall

        blez a0, end_client
        # --- Write the received message in stdout ---
        li a7, 64 # write
        li a0, 1 # stdout
        mv a1, sp # buffer address inside the stack
        li a2, 4096 # size to write
        ecall

        # Echo the message to the client
        li a7, 64 # write
        mv a0, s1 # client's socket file descriptor
        mv a1, sp # the buffer with the contents
        li a2, 4096 # buffer's size
        ecall
        
end_client:
        li t0, 4096
        add sp, sp, t0
        ret
