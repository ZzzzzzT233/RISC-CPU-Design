# Data setup
    li x1, 0x48                   # store hex value of ASCII 'H'in x1
    li x2, 0x69                   # store hex value of ASCII 'i'in x2
    li x3, 0x00000500             # store the address for UART data transmission and reception in x3
    li x4, 0x00000504             # store the address for UART status in x4

# Transmit 'H'
transmit_H:
    lw x10, 0(x4)                 # Load UART status value to x10
    andi x11, x10, 0x01           # Check if TxRDY is set, store the value into x11
    beqz x11, transmit_H          # If not ready (x11 == 0), loop and check again
    sw x1, 0(x3)                  # If ready, store the x1 value ('H') into the x3 (address for UART data transmission and reception)

# Receive 'H'
receive_H:
    lw x12, 0(x4)                 # Load UART status value to x12
    andi x13, x12, 0x02           # Check if RxRDY is set, store the value into x13
    beqz x13, receive_H       	  # If not ready (x13 == 0), loop and check again
    lw x5, 0(x3)                  # If ready, load the value ('H') from x3 (address for UART data transmission and reception), store the value into x5

# Transmit 'i'
transmit_i:
    lw x10, 0(x4)                 # Load UART status value to x10
    andi x11, x10, 0x01           # Check if TxRDY is set, store the value into x11
    beqz x11, transmit_i          # If not ready (x11 == 0), loop and check again
    sw x2, 0(x3)                  # If ready, store the x2 value ('i') into the x3 (address for UART data transmission and reception)

# Receive 'i'
receive_i:
    lw x12, 0(x4)                 # Load UART status value to x12
    andi x13, x12, 0x02           # Check if RxRDY is set, store the value into x13
    beqz x13, receive_i           # If not ready (x13 == 0), loop and check again
    lw x5, 0(x3)                  # If ready, load the value ('i') from x3 (address for UART data transmission and reception), store the value into x5

end:
    j end                         # infinite loop