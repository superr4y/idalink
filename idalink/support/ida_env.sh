#!/bin/bash

# Copyright (C) 2013- Yan Shoshitaishvili aka. zardus
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

export TERM=xterm

#IDA="/home/amoco/idadir/idaq.exe"
IDA="$1"
shift
wine $IDA "$@"
#wine $IDA -A -S"/home/amoco/git/idalink/idalink/server.py 41293 metapc" -L"/tmp/idalink-41293.log" -pmetapc /home/amoco/samples/mytest

#tmux new-session -d -s idalink-41293 /home/amoco/git/idalink/idalink/support/ida_env.sh /home/amoco/idadir/idaq.exe -S/home/amoco/git/idalink/idalink/server.py 41293 metapc -L"/tmp/idalink-41293.log" -pmetapc /home/amoco/samples/mytest
