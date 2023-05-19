CMD:darpet(playerid, params[]) {
    new targetid, petmodel;

    if(PlayerInfo[playerid][pAdmin] <= 5) return SendClientMessage(playerid, COLOR_LIGHTRED, "{FFFFFF}Você não é um administrador.");

    if(sscanf(params, "ud", targetid, petmodel)) return SendClientMessage(playerid, COLOR_LIGHTRED, "/darpet [playerid] [modelo]");
    if(!IsPlayerConnected(targetid)) return SendNotConnectedMessage(playerid);
    if(!IsValidPetModel(petmodel)) return SendClientMessage(playerid, COLOR_LIGHTRED, "Modelo inválido. Modelos válidos: 29900 ~ 29919.");   

    PetData[targetid][petModelID] = petmodel;
    format(PetData[targetid][petName], 128, "Jack");
    SendServerMessage(playerid, "Você deu um animal de estimação para %s.", pNome(targetid));
    format(logString, sizeof(logString), "%s deu um animal de estimação para %s.", PlayerName(targetid, 0), pNome(targetid));
	logCreate(playerid, logString, 1);
    return true;
}

CMD:pet(playerid, params[]) {
    if(pInfo[playerid][pDonator] != 3) return SendClientMessage(playerid, COLOR_LIGHTRED, "Você deve possuir um Premium Ouro ativo para utilizar isso.");
    if(!PetData[playerid][petModelID]) return SendClientMessage(playerid, COLOR_LIGHTRED, "Você não possui um animal de estimação.");

    ShowPetMenu(playerid);
    return true;
}