#!/bin/bash
Syntax() {
	echo "Syntax:  $0 classname [args]"
	echo "Example: $0 JScriptAE3 test.js"
	exit 1
}
classpath() {
	local FIRST=true
	DIR=$1
	shift
	FIRST=true
	PARAMS=""
	for PARAM in $@;do
		if [ $FIRST != true ]; then
			PARAMS="$PARAMS -o -name '*${PARAM}*'";
		else
			PARAMS="-name '*${PARAM}*'"
			FIRST=false
		fi
	done
	for ITEM in `eval "find $DIR $PARAMS"`; do
		test $FIRST = true && FIRST=false || echo -n ":"
		echo -n "$ITEM"
	done
	echo
}
[ -z "$1" ] && Syntax
CLASS=$1
shift
P_ARGS=$@
CLASSPATH="`classpath ../../../axiom`"
if [ -f "../../../tools/$CLASS.class" ]; then
	java -server -Djava.awt.headless=true -Xmx386m -Xms386m -Xshare:off -classpath $CLASSPATH:../../../tools $CLASS $P_ARGS
	exit 0
fi
echo "Not found: $CLASS (in tools/)"
exit 1
