# idalink

idalink arose of the need to easily use IDA's API for analysis without wanting
to be stuck in the IDA interface. It's rather hackish still and and we provide
no warranty of any kind (express or implied), but we are doing our best to fix
any issues you find. Pull requests are -of course- also encouraged!

idalink works by spawning an IDA CLI session in the background (in a detached
screen session), and connects to it using RPyC.

## Requirements

idalink requires the following:

- IDA Pro 
- tmux
- libssl0.9.8:i386 (for IDA's Python version, should work with anaconda)

idalink uses:
- rpyc in your Python environment outside of IDA
- rpyc in your IDA Python environment.

## Setup

- install Anaconda python 2.7 32bit in wine, make it the system default python.
- install rpyc in IDA Pro python prompt with: import os;os.system("pip install rpyc") 
- install rpyc in linux with: pip install rpyc
- install tmux on you linux box

## Usage

To use idalink, put it in a place where you can import it and do, in any python
session (ie, outside of IDA):
    #!/usr/bin/env python
    # -*- coding: utf-8 -*-

    from __future__ import print_function

    from idalink import idalink

    # We want debug messages for now
    import logging
    idalink_log = logging.getLogger('idalink')
    idalink_log.addHandler(logging.StreamHandler())
    idalink_log.setLevel(logging.DEBUG)

    # Let's do some testing with idalink!
    with idalink('/home/amoco/samples/mytest', '/home/amoco/idadir/idaq.exe') as ida:
        # use idc
        s = ida.idc.ScreenEA()
        print('Default ScreenEA is {:x}'.format(s))

        # use idautils
        print('All segments')
        for s in ida.idautils.Segments():
            print(' - Segment at {:x} is named {}'.format(s, ida.idc.SegName(s)))

        # use idaapi
        print('First byte for each function')
        for i, s in enumerate(ida.idautils.Functions()):
            print(' - Byte at {:x} is {:02x}'.format(s, ida.idaapi.get_byte(s)))

        # access IDA memory in a dict way
        print('Accessing memory directly')
        functions = next(ida.idautils.Functions())
        #print(' - Byte at {:x} is {}'.format(s, ida.memory[s]))

And that's that. Basically, you get access to the IDA API from outside of IDA.
Good stuff.

## Issues

Some issues remain, that we will take care of almost extremely soon:

- The detection for whether to use idal or idal64 is very simplistic (greps for
  32 or 64 in the output of the file command) and probably needs to be improved
- A random port between 40000 and 49999 is chosen for communication, with no
  error-checking for failed IDA startups or if the port is already in use.
- IDA-backed memory is not really tested, and uses Heads for getting the
  "mapped" list, which is slow and incomplete
