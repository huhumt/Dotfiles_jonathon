-- According to the IMAP specification, when trying to write a message
-- to a non-existent mailbox, the server must send a hint to the client,
-- whether it should create the mailbox and try again or not. However
-- some IMAP servers don't follow the specification and don't send the
-- correct response code to the client. By enabling this option the
-- client tries to create the mailbox, despite of the server's response.
-- This variable takes a boolean as a value.  Default is “false”.
options.create = true
-- By enabling this option new mailboxes that were automatically created,
-- get auto subscribed
options.subscribe = true
-- How long to wait for servers response.
options.timeout = 120

-- The directory for all my imapfilder files
imapfilterdir= os.getenv("HOME") .. '/.config/imapfilter/'



function split (inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end
	return t
end

-- This function takes a table of email addresses and flags messages from them in the inbox.
function flagSenders(senders)
	for _, v in pairs(senders) do
		messages = work["Inbox"]:contain_from(v)
		messages:mark_flagged()
	end
end


-- Load my work-account credentials and work specific rules
loadfile(imapfilterdir .. "work-account.lua.secret")()


