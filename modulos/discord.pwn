DISCORD:white(DCC_Channel: channel, DCC_User: author, params[]){
    new nick[MAX_PLAYER_NAME], str[128];
    if(sscanf(params, "s", nick)) return DCC_SendChannelMessage(channel, "Uso: /white [seu nome]");
    format(str, sizeof str, "O nick: %s esta pedindo para ser autorizado.", nick);
    MensageAdmin(azul, str);
    return 1;
}
// Sistema de bugs
DISCORD:reportarbug(DCC_Channel: channel, DCC_User: author, params[]){
    new arquivo4[60];
    new bug[228], nick[MAX_PLAYER_NAME];
    if(sscanf(params, "ss[228]", nick, bug)) return DCC_SendChannelMessage(channel, "Uso: /reportarbug [seu nome] [bug]");
    format(arquivo4, sizeof arquivo4, "Bugs/%s.bug", nick);
    DOF2_CreateFile(arquivo4);
    DOF2_SetString(arquivo4, "Bug", bug);
    DOF2_SaveFile();
    return 1;
}

public OnDiscordCommandPerformed(DCC_Channel: channel, DCC_User: author, bool: success){
    if(!success){
        DCC_SendChannelMessage(channel, "Comando inexistente.");
    }
    return 1;
}