ALTCOMMAND:vestircolete->Vestirbomba;
CMD:vestircolete(playerid, params[])
{
    if(!PlayerInfo[playerid][pLogado]) return SendClientMessage(playerid,COLOR_LIGHTRED, "ERRO:{FFFFFF} Voc� n�o est� logado!");
	if(PlayerInfo[playerid][pLevel] < 2) return SCM(playerid, COLOR_LIGHTRED, "Voc� precisa de TC 2 ou mais para utilizar este comando!");
    if(PlayerInfo[playerid][pMorto] > 0) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO:{FFFFFF} Voc� n�o pode usar este comando enquanto estiver morto!");
    if(OutrasInfos[playerid][oAlgemado] != 0) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO:{FFFFFF} Voc� n�o pode utilizar este comando enquanto estiver algemado.");
    if(OutrasInfos[playerid][oAmarrado] != 0) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO:{FFFFFF} Voc� n�o pode utilizar este comando enquanto estiver amarrado.");
	if(IsPlayerInWater(playerid)) return SendClientMessage(playerid, COLOR_LIGHTRED, "Voc� n�o pode utilizar este comando enquanto estiver na �gua!");
	if(TomouTazer[playerid] > 0) return SendClientMessage(playerid, COLOR_LIGHTRED, "Voc� n�o pode utilizar este comando enquanto estiver sob efeito do tazer!");
    if(!IsPlayerInAnyVehicle(playerid) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO:{FFFFFF} Voc� precisa estar fora do ve�culo."));
    if(PlayerInfo[playerid][pTNT] < 3) return SCM(playerid, COLOR_LIGHTRED, "ERRO:{FFFFFF} Voc� precisa de 3 TNT para formar o colete.");
    SendClientMessage(playerid, COLOR_LIGHTRED, "INFO:{FFFFFF} Vestindo o colete, aguarde.");
    SetTimerEx("VestindoColeteBomba", 10000, false, "d", playerid);

	return 1;
}

forward VestindoColeteBomba(playerid);
public VestindoColeteBomba(playerid)
{
	SendClientMessage(playerid, COLOR_LIGHTRED, "INFO:{FFFFFF} Voc� vestiu o colete.");
    PlayerInfo[playerid][pTNT] = PlayerInfo[playerid][pTNT]-= 3;

    return 1;
}
ALTCOMMAND:homembomba->hb;
CMD:homembomba(playerid, params[])
{
    if(!PlayerInfo[playerid][pLogado]) return SendClientMessage(playerid,COLOR_LIGHTRED, "ERRO:{FFFFFF} Voc� n�o est� logado!");
	if(PlayerInfo[playerid][pLevel] < 2) return SCM(playerid, COLOR_LIGHTRED, "Voc� precisa de TC 2 ou mais para utilizar este comando!");
    if(PlayerInfo[playerid][pMorto] > 0) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO:{FFFFFF} Voc� n�o pode usar este comando enquanto estiver morto!");
    if(OutrasInfos[playerid][oAlgemado] != 0) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO:{FFFFFF} Voc� n�o pode utilizar este comando enquanto estiver algemado.");
    if(OutrasInfos[playerid][oAmarrado] != 0) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO:{FFFFFF} Voc� n�o pode utilizar este comando enquanto estiver amarrado.");
	if(IsPlayerInWater(playerid)) return SendClientMessage(playerid, COLOR_LIGHTRED, "Voc� n�o pode utilizar este comando enquanto estiver na �gua!");
	if(TomouTazer[playerid] > 0) return SendClientMessage(playerid, COLOR_LIGHTRED, "Voc� n�o pode utilizar este comando enquanto estiver sob efeito do tazer!");
	if(PlayerInfo[playerid][pArrombarDNV_C] != 0)
	{
		new stringfogos[128];
		format(stringfogos, sizeof(stringfogos),"Aguarde %d segundos antes de explodir novamente.", PlayerInfo[playerid][pArrombarDNV_C]);
		SendClientMessage(playerid,COLOR_LIGHTRED, stringfogos);
		return 1;
	}
    if(!IsPlayerInAnyVehicle(playerid) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO:{FFFFFF} Voc� precisa estar fora do ve�culo."));
    if(PlayerInfo[playerid][pColeteBomba] < 1) return SCM(playerid, COLOR_LIGHTRED, "ERRO:{FFFFFF} Voc� precisa de 1 colete bomba para explodir.");

    SendClientMessage(playerid, COLOR_LIGHTRED, "INFO:{FFFFFF} Aguarde 3 segundos para explodir.");
    SetTimerEx("HomemBombaExplodindo", 3000, false, "d", playerid);

	return 1;
}

forward HomemBombaExplodindo(playerid);
public HomemBombaExplodindo(playerid)
{
    PlayerInfo[playerid][pArrombarDNV_C] = 1200;
    
    new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

    CreateExplosion(x, y, z, 10, 20.0);
	SendClientMessage(playerid, COLOR_LIGHTRED, "INFO:{FFFFFF} Voc� Explodiu");
    PlayerInfo[playerid][pColeteBomba]--;

    return 1;
}