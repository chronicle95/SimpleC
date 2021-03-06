#!/bin/bash
source ./common.sh
IFILE=$IDIR/sample
OFILE=$ODIR/sample_fc
echo "Compiling with FemtoC..."
cat $IFILE.c | ../cc > $OFILE.s
if ! grep -q "no errors encountered" $OFILE.s; then
	echo "${CR}Compilation failed${RC}"
	exit 1
fi
echo "Assembling..."
if ! as $OFILE.s -o $OFILE.o; then
	echo "${CR}Assembly failed${RC}"
	exit 1
fi
echo "Linking..."
if ! ld $OFILE.o -o $OFILE; then
	echo "${CR}Linkage failed${RC}"
	exit 1
fi
echo "Clean up"
rm $OFILE.o $OFILE.s
