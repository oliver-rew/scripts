#!/bin/bash

# this script takes replaces a specific sequence of bytes in the original
# file with a new sequence of bytes, and outputs it to a file with the same
# name as the input file, suffixes with new
#
# For example, to replace the sequence fa657eb2 with fa0000b2 in a file a.out
# you would run:
#
# $ ./byterepl.sh a.out fa657eb2 fa0000b2
# Replacing 1 instances of fa657eb2 with fa0000b2
#
# the number of replacements is printed to ensure you onlt replace as many
# instances as you intended

BIN=$1
NEW=$BIN\_new
ORIG=$2
REPL=$3

# this is a gnarly command. I could just run the xxd and tr parts twice, but
# where's the fun in that. 
#
# use xxd to convert file into stream of bytes
xxd -ps $BIN | \

  # xxd leaves newlines, which could cause us to lose a sequence, so instead
  # remove the newlines with tr
  tr -d '\n' | \

  # at this point we want to use this stream of bytes to both replace the byte
  # sequence and also count the number of instances of the original pattern.
  # Use tee the split the output into 2 separate streams
  tee >(

  # in a tee sub-shell use sed and xxd to replace the byte sequence and
  # re-encode as the file and copy the original permissions
  sed "s/$ORIG/$REPL/g" | xxd -ps -r > $NEW; chmod --reference $BIN $NEW) | \
  
  # in the other tee stream, use grep and wc to count the number of occurences
  grep -o $ORIG | wc -l | \

  # print the user friendly message
  { read COUNT; echo Replacing $COUNT instances of $ORIG with $REPL;}

