#!/usr/bin/env bash

__hydra_complete(){
	local toAdd=""
	#if [ -n "${COMP_WORDS[COMP_CWORD]}" ]; then
	#	toAdd=" "
	#	prevArgNo="$COMP_CWORD"
	#else
	#	prevArgNo="$(($COMP_CWORD - 1))"
	#fi

	local curr="${COMP_WORDS[COMP_CWORD]}"
	local prev="${COMP_WORDS[COMP_CWORD-1]}"
	local services="adam6500 asterisk afp cisco cisco-enable cvs firebird ftp ftps http-head http-get http-post http-get-form http-post-form http-proxy http-proxy-urlenum icq imap irc ldap2 ldap3 ldap3-crammd5 ldap3-digestmd5 mssql mysql nntp oracle-listener oracle-sid pcanywhere pcnfs pop3 postgres radmin2 redis rexec rlogin rpcap rsh rtsp s7-300 sip smb smtp smtp-enum snmp socks5 ssh sshkey svn teamspeak telnet vmauthd vnc xmpp"

	case "$prev" in
		-L|-P|-C|-M)
			COMPREPLY=($(compgen -A file -- "$curr"))
			;;
		-l|-p|-t|-h)
			COMPREPLY=()
			;;
		-U)
			COMPREPLY=($(compgen -W "$services" -- "$curr"))
			;;
		*)
			COMPREPLY=($(compgen -W "-l -L -p -P -C -M -t -U -h" -- "$curr"))
			;;
	esac
}

complete -F __hydra_complete hydra
