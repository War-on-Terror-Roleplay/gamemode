//███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
//█░░░░░░░░░░░░░░███░░░░░░░░██░░░░░░░░████░░░░░░░░░░░░░░█░░░░░░██████████░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█
//█░░▄▀▄▀▄▀▄▀▄▀░░███░░▄▀▄▀░░██░░▄▀▄▀░░████░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░░░░░░░░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█
//█░░▄▀░░░░░░▄▀░░███░░░░▄▀░░██░░▄▀░░░░████░░▄▀░░░░░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░██░░▄▀░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░▄▀░░█
//█░░▄▀░░██░░▄▀░░█████░░▄▀▄▀░░▄▀▄▀░░██████░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░▄▀░░██░░▄▀░░█░░▄▀░░█████████░░▄▀░░█████████░░▄▀░░██░░▄▀░░█
//█░░▄▀░░░░░░▄▀░░░░███░░░░▄▀▄▀▄▀░░░░██████░░▄▀░░░░░░▄▀░░█░░▄▀░░██░░▄▀░░██░░▄▀░░█░░▄▀░░█████████░░▄▀░░█████████░░▄▀░░░░░░▄▀░░█
//█░░▄▀▄▀▄▀▄▀▄▀▄▀░░█████░░░░▄▀░░░░████████░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀░░██░░▄▀░░█░░▄▀░░██░░░░░░█░░▄▀░░██░░░░░░█░░▄▀▄▀▄▀▄▀▄▀░░█
//█░░▄▀░░░░░░░░▄▀░░███████░░▄▀░░██████████░░▄▀░░░░░░▄▀░░█░░▄▀░░██░░▄▀░░██░░▄▀░░█░░▄▀░░██░░▄▀░░█░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░▄▀░░█
//█░░▄▀░░████░░▄▀░░███████░░▄▀░░██████████░░▄▀░░██░░▄▀░░█░░▄▀░░██░░▄▀░░░░░░▄▀░░█░░▄▀░░██░░▄▀░░█░░▄▀░░██░░▄▀░░█░░▄▀░░██░░▄▀░░█
//█░░▄▀░░░░░░░░▄▀░░███████░░▄▀░░██████████░░▄▀░░██░░▄▀░░█░░▄▀░░██░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░░░░░▄▀░░█░░▄▀░░░░░░▄▀░░█░░▄▀░░██░░▄▀░░█
//█░░▄▀▄▀▄▀▄▀▄▀▄▀░░███████░░▄▀░░██████████░░▄▀░░██░░▄▀░░█░░▄▀░░██░░░░░░░░░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀░░█
//█░░░░░░░░░░░░░░░░███████░░░░░░██████████░░░░░░██░░░░░░█░░░░░░██████████░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░██░░░░░░█
//███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████

//REMADE FROM https://forum.sa-mp.com/showthread.php?t=646843 by Inn0cent

#include <sscanf2>
#include <YSI\y_va>
#include <discord-connector>

#define DC_CMD:%0(%1,%2)          \
			forward dc_cmd_%0(%1[],%2[]); \
			public dc_cmd_%0(%1[],%2[])
			
forward OnDCCommandPerformed(args[], success);	

//Discord Channel Callback
new DCC_Channel:g_Discord_Command_Place;
new DCC_Channel:BotChannel;

forward SendDC(channel[], const fmat[], va_args<>);
public SendDC(channel[], const fmat[], va_args<>)
{
	new
        str[145];
    va_format(str, sizeof (str), fmat, va_start<2>);
	BotChannel = DCC_FindChannelById(channel);
    return DCC_SendChannelMessage(BotChannel, str);
}

forward DCC_OnMessageCreate(DCC_Message:message);
public DCC_OnMessageCreate(DCC_Message:message)
{
    new realMsg[100];
    DCC_GetMessageContent(message, realMsg, 100);
    new bool:IsBot;
    new DCC_Channel:channel;
    DCC_GetMessageChannel(message, channel);
    new DCC_User:author;
    DCC_GetMessageAuthor(message, author);
	new user_name[144];
	DCC_GetUserName(author, user_name);
    DCC_IsUserBot(author, IsBot);
	g_Discord_Command_Place = DCC_FindChannelById(DISCORD_CHANNEL_ID);
    if(channel == g_Discord_Command_Place && !IsBot) //!IsBot will block BOT's message in discord like (Bot A : /ban 1 test")
    {
        new dmsg[10][128];
		explode(dmsg, realMsg, " ", 2);
		new command[10], args[50];
		sscanf(realMsg, "s[10]s[50]", command, args); // Sperate message in COMMAND and arguments.
		if(strfind(command, DISCORD_PREFIX, true) != -1) // Check if command have prefix defined above.
		{
			new funcdc[128];
			strdel(command, 0, 1);
			format(funcdc, sizeof(funcdc), "dc_cmd_%s", command); // Format function.
			
			if(isnull(dmsg[1])) {
				CallLocalFunction("OnDCCommandPerformed", "si", realMsg, CallLocalFunction(funcdc, "ss", user_name, "\1"));
			} else CallLocalFunction("OnDCCommandPerformed", "si", realMsg, CallLocalFunction(funcdc, "ss", user_name, args));
		}
    }

    return 1;
}

stock explode(aExplode[][], const sSource[], const sDelimiter[] = " ", iVertices = sizeof aExplode, iLength = sizeof aExplode[])
{
	new
		iNode,
		iPointer,
		iPrevious = -1,
		iDelimiter = strlen(sDelimiter);

	while(iNode < iVertices)
	{
		iPointer = strfind(sSource, sDelimiter, false, iPointer);

		if(iPointer == -1)
		{
			strmid(aExplode[iNode], sSource, iPrevious, strlen(sSource), iLength);
			break;
		}
		else
		{
			strmid(aExplode[iNode], sSource, iPrevious, iPointer, iLength);
		}

		iPrevious = (iPointer += iDelimiter);
		++iNode;
	}

	return iPrevious;
}