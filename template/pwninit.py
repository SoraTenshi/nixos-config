#!/usr/bin/env python3
from pwn import *
import warnings

warnings.filterwarnings(action='ignore', category=BytesWarning)

{bindings}

context.binary = {bin_name}

IP, PORT = "address", 12345

gdbscript = '''
tbreak main
continue
'''

def start():
    if args.GDB:
        return gdb.debug([elf.path], gdbscript)
    elif args.REMOTE:
        return remote(IP, PORT)
    else:
        return elf.process()

p = start()

# ----- Exploit ----- #

p.interactive()
