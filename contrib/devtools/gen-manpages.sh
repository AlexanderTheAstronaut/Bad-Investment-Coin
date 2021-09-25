#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

BADINVESTMENTCOIND=${BADINVESTMENTCOIND:-$BINDIR/badinvestmentcoind}
BADINVESTMENTCOINCLI=${BADINVESTMENTCOINCLI:-$BINDIR/badinvestmentcoin-cli}
BADINVESTMENTCOINTX=${BADINVESTMENTCOINTX:-$BINDIR/badinvestmentcoin-tx}
BADINVESTMENTCOINQT=${BADINVESTMENTCOINQT:-$BINDIR/qt/badinvestmentcoin-qt}

[ ! -x $BADINVESTMENTCOIND ] && echo "$BADINVESTMENTCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
BTCVER=($($BADINVESTMENTCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for badinvestmentcoind if --version-string is not set,
# but has different outcomes for badinvestmentcoin-qt and badinvestmentcoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$BADINVESTMENTCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $BADINVESTMENTCOIND $BADINVESTMENTCOINCLI $BADINVESTMENTCOINTX $BADINVESTMENTCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BTCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BTCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
