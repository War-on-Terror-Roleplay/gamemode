//////////////////////COMANDOS VIP//////////////////////////////


CMD:skin(playerid, params[])
{
	if(pInfo[playerid][pVip] == 0) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao e VIP!");
	new id;
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "Use: /skin [id]");
	if(id > 300) return SendClientMessage(playerid, -1, "Apenas ID Entre 1 - 300");
	if(id == 74) return SendClientMessage(playerid, -1, "Nao pode usar esta skin!");
	if(id == 92) return SendClientMessage(playerid, -1, "Nao pode usar esta skin!");
	if(id == 99) return SendClientMessage(playerid, -1, "Nao pode usar esta skin!");
	if(id <= 0) return SendClientMessage(playerid, -1, "Apenas ID Entre 1 - 300");
	SetPlayerSkin(playerid, id);
	SendClientMessage(playerid, COR_AMARELO, "[INFO] Voce mudou sua skin");
	return 1;
}

CMD:cornick(playerid, params[])
{
	if(pInfo[playerid][pVip] == 0) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao e VIP!");
	ShowPlayerDialog(playerid, 57, DIALOG_STYLE_LIST, "Escolha uma cor", "{FFFF00}AMARELO\n{FF0000}VERMELHO\n{0080FF}AZUL\n{FF8000}LARANJA\n{80FFFF}CIANO\n{C0C0C0}PADRAO", "Escolher", "Cancelar");
	return 1;
}

CMD:corveh(playerid, params[])
{
    if(pInfo[playerid][pVip] == 0) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao e VIP!");
	new vehicleid = GetPlayerVehicleID(playerid);
	new id, id2;
	if(sscanf(params, "dd", id, id2)) return SendClientMessage(playerid, -1, "Use: /corveh [COR1] [COR2]");
	if(id > 7) return SendClientMessage(playerid, -1, "Escolha uma cor de 0 a 7");
	if(id2 > 7) return SendClientMessage(playerid, -1, "Escolha uma cor de 0 a 7");
	ChangeVehicleColor(vehicleid, id, id2);
	return 1;
}



CMD:av(playerid, params[])
{
	if(pInfo[playerid][pVip] == 0) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao e VIP!");
    if(msglog[playerid] == true) return SendClientMessage(playerid, -1, "Aguarde 5s para enviar outra mensagem");
    new Str[200], Name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, Name, sizeof Name);
    format(Str, sizeof Str, "{FFFF00}[Anuncio VIP] {C0C0C0}%s: {FFFFFF}%s", Name, params);
    SendClientMessageToAll(-1, Str);
	SetTimerEx( "delaymsg", 5000, false, "i", playerid);
	msglog[playerid] = true;
    return true;
}

//////////////////////////////////FIM COMANDOS VIP////////////////////////////////////