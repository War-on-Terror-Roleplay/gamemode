CMD:darpet(playerid, params[]) {
    new targetid, petmodel;

    if(PlayerInfo[playerid][pAdmin] <= 5) return SendClientMessage(playerid, COLOR_LIGHTRED, "{FFFFFF}Voc� n�o � um administrador.");

    if(sscanf(params, "ud", targetid, petmodel)) return SendClientMessage(playerid, COLOR_LIGHTRED, "/darpet [playerid] [modelo]");
    if(!IsPlayerConnected(targetid)) return SendNotConnectedMessage(playerid);
    if(!IsValidPetModel(petmodel)) return SendClientMessage(playerid, COLOR_LIGHTRED, "Modelo inv�lido. Modelos v�lidos: 29900 ~ 29919.");   

    PetData[targetid][petModelID] = petmodel;
    format(PetData[targetid][petName], 128, "Jack");
    SendServerMessage(playerid, "Voc� deu um animal de estima��o para %s.", pNome(targetid));
    format(logString, sizeof(logString), "%s deu um animal de estima��o para %s.", PlayerName(targetid, 0), pNome(targetid));
	logCreate(playerid, logString, 1);
    return true;
}

CMD:pet(playerid, params[]) {
    if(pInfo[playerid][pDonator] != 3) return SendClientMessage(playerid, COLOR_LIGHTRED, "Voc� deve possuir um Premium Ouro ativo para utilizar isso.");
    if(!PetData[playerid][petModelID]) return SendClientMessage(playerid, COLOR_LIGHTRED, "Voc� n�o possui um animal de estima��o.");

    ShowPetMenu(playerid);
    return true;
}