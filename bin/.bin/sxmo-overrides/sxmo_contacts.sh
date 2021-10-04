#!/usr/bin/env sh
# This script prints in reverse chronological order unique entries from the
# modem log merged with contact names defined in contacts file tsv.
#   Wherein $CONTACTSFILE is tsv with two fields: number\tcontact name
#   Wherein $LOGFILE is *sorted* tsv with three fields: date\tevt\tnumber
#
#   Most normal numbers should be a full phone number starting with + and the country number
#   Some special numbers (ie. 2222, "CR AGRICOLE") can ignore this pattern
#
# Prints in output format: "number: contact"
#
# CHANGES BY JH
# I dont want a tsv file of contacts. Instead, I will use abook to maage my contacts

# include common definitions
# shellcheck source=scripts/core/sxmo_common.sh
. "/usr/bin/sxmo_common.sh"

CONTACTSFILE="$XDG_CONFIG_HOME"/sxmo/contacts.tsv
LOGFILE="$XDG_DATA_HOME"/sxmo/modem/modemlog.tsv
ABOOKFILE="$XDG_DATA_HOME"/abook/addressbook

abook_to_tsv(){
	cat "$ABOOKFILE" |
	grep -E '(\[[0-9]+\]|^$|name|phone|mobile)' |
	awk -v RS="\n\n" -v ORS="\n" '{gsub("\n","\t",$0); print $0}' |
	sed 's/^[[:space:]]*//' |
	grep -E "(phone|mobile)" | while read -r line; do
		name="$(echo "$line" | cut -d '	' -f 2 | cut -d '=' -f 2)"
		echo "$line" | tr '\t' '\n' |
			grep -E '(phone|mobile)' | while read -r numLine; do
				num="$(echo "$numLine" | cut -d '=' -f 2 | tr -d ' ' |
					sed 's/+44(0)/+44/' | sed 's/^0/+44/')"
				numType="$(echo "$numLine" | cut -d '=' -f 1)"
				echo -e "$num\t$name ($numType)"
			done
	done > "$CONTACTSFILE"

}

prepare_contacts_list() {
	cut -f3 |
	tac |
	awk '!($0 in a){a[$0]; print}' |
	sed '/^[[:space:]]*$/d' |
	awk -F'\t' '
		FNR==NR{a[$1]=$2; next}
		{
			if (!a[$1]) a[$1] = "Unknown Number";
			print $0 ": " a[$1]
		}
	' "$CONTACTSFILE" -
}

contacts() {
	prepare_contacts_list < "$LOGFILE"
}

texted_contacts() {
	grep "\(recv\|sent\)_txt" "$LOGFILE" | prepare_contacts_list
}

called_contacts() {
	grep "call_\(pickup\|start\)" "$LOGFILE" | prepare_contacts_list
}

all_contacts() {
	awk -F'\t' '{
		print $1 ": " $2
	}' "$CONTACTSFILE" | sort -f -k 2
}

unknown_contacts() {
	contacts \
		| grep "Unknown Number$" \
		| cut -d: -f1 \
		| grep "^+[0-9]\{9,14\}$"
}


# if the abook file doens't exist, touch conatacts file in order to prevent errors
[ -f "$ABOOKFILE" ] || touch "$CONTACTSFILE"

# If abook file is newer than contacts, re-genreate contacts tsv
[ "$ABOOKFILE" -nt "$CONTACTSFILE" ] && abook_to_tsv

if [ "$1" = "--all" ]; then
	all_contacts
elif [ "$1" = "--unknown" ]; then
	unknown_contacts
elif [ "$1" = "--texted" ]; then
	texted_contacts
elif [ "$1" = "--called" ]; then
	called_contacts
elif [ -n "$*" ]; then
	all_contacts | grep -i "$*"
else
	contacts
fi
