#include    <a_samp>
#include 	<zcmd>
#include    <mapandreas>
 
new bool:MissilCriado[MAX_PLAYERS];
new Missil[3][MAX_PLAYERS];
new MissilCaindo[3][MAX_PLAYERS];
new Float:AlvoX[MAX_PLAYERS], Float:AlvoY[MAX_PLAYERS], Float:AlvoZ[MAX_PLAYERS];
 
public OnFilterScriptInit()
{
    MapAndreas_Init(MAP_ANDREAS_MODE_MINIMAL);
	return 1;
}
 
 
CMD:criarmorteiro(playerid, params[])
{
	if(!PlayerInfo[playerid][pLogado]) return SendClientMessage(playerid,COLOR_LIGHTRED, "ERRO:{FFFFFF} Você não está logado!");
    if(PlayerInfo[playerid][pMorteiro] <= 0) return SCM(playerid, COLOR_LIGHTRED, "ERRO:{FFFFFF} Você precisa de 1 colete bomba para explodir.");
    if(PlayerInfo[playerid][pArrombarDNV_C] != 0)
    {
        new stringfogos[128];
        format(stringfogos, sizeof(stringfogos),"Aguarde %d segundos antes de lançar um morteiro novamente.", PlayerInfo[playerid][pArrombarDNV_C]);
        SendClientMessage(playerid,COLOR_LIGHTRED, stringfogos);
        return 1;
    }

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if(MissilCriado[playerid] == true)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO:{FFFFFF} Você já tem um morteiro armado, dispare-o primeiro.");
		return 1;
	}
	else
	{
		PlayerInfo[playerid][pMorteiro]--;
		PlayerInfo[playerid][pArrombarDNV_C] = 2400;
        /*Missil[0][playerid] = CreateObject(-2201,x,y,z+3,0.0000000,0.0000000,44.9950000);
		Missil[1][playerid] = CreateObject(-2201,x,y,z+8,0.0000000,0.0000000,44.9950000);*/
		Missil[2][playerid] = CreateObject(-2201,x,y,z);
		SetPlayerPos(playerid, x, y, z);
		MissilCriado[playerid] = true;
		SendClientMessage(playerid, COLOR_WHITE, "INFO: Morteiro armado.");
	}
 	return 1;
}
 
CMD:disparar(playerid, params[])
{
	if(!PlayerInfo[playerid][pLogado]) return SendClientMessage(playerid,COLOR_LIGHTRED, "ERRO:{FFFFFF} Você não está logado!");
	if(MissilCriado[playerid] == false)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO:{FFFFFF} Você não tem um morteiro armado.");
		return 1;
	}
	if(AlvoX[playerid] == 0 && AlvoY[playerid] == 0 && AlvoZ[playerid] == 0)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO:{FFFFFF} Você não escolheu um Alvo!");
		return 1;
	}
	else
	{
	    new Float:x, Float:y, Float:z;
	    GetObjectPos(Missil[0][playerid], x, y, z);
	    CreateExplosion(x, y, z, 1, 1);
	    MoveObject(Missil[0][playerid], x, y, z+700, 90, 0, 0, 0);
	    MoveObject(Missil[1][playerid], x, y, z+705, 90, 0, 0, 0);
	    MoveObject(Missil[2][playerid], x, y, z+710, 90, 0, 0, 0);
	    SetTimerEx("QuedaMissil", 5000, false, "i", playerid);
	}
	return 1;
}
 
CMD:ajudamissil(playerid, params[])
{
	SendClientMessage(playerid, COLOR_LIGHTGREEN, "_____________________________Ajuda Morteiro_____________________________");
	SendClientMessage(playerid, COLOR_WHITE, "** AJUDA ** /criarmorteiro - Cria um Morteiro.");
	SendClientMessage(playerid, COLOR_WHITE, "** AJUDA ** /disparar - Lança um Morteiro.");
	SendClientMessage(playerid, COLOR_WHITE, "** AJUDA ** Marque no Mapa o lugar onde o morteiro deve cair.");
	return 1;
}
 
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    if(MissilCriado[playerid] == true)
    {
    AlvoX[playerid] = fX;
    AlvoY[playerid] = fY;
    MapAndreas_FindAverageZ(fX, fY, AlvoZ[playerid]);
    SendClientMessage(playerid, COLOR_CINZA, "INFO: Alvo marcado!");
    SendClientMessage(playerid, COLOR_CINZA, "USE: /disparar para Lançar o morteiro!");
    }
	return 1;
}
 
forward QuedaMissil(playerid);
public QuedaMissil(playerid)
{
	DestroyObject(Missil[0][playerid]);
	DestroyObject(Missil[1][playerid]);
	DestroyObject(Missil[2][playerid]);
	MissilCaindo[0][playerid] = CreateObject(1636, AlvoX[playerid], AlvoY[playerid], AlvoZ[playerid]+100, 0, 180, 0);
	MissilCaindo[1][playerid] = CreateObject(1636, AlvoX[playerid], AlvoY[playerid], AlvoZ[playerid]+105, 0, 180, 0);
	MissilCaindo[2][playerid] = CreateObject(1636, AlvoX[playerid], AlvoY[playerid], AlvoZ[playerid]+110, 0, 180, 0);
	MoveObject(MissilCaindo[0][playerid], AlvoX[playerid], AlvoY[playerid], AlvoZ[playerid], 50, 0, 180, 0);
	MoveObject(MissilCaindo[1][playerid], AlvoX[playerid], AlvoY[playerid], AlvoZ[playerid]+5, 50, 0, 180, 0);
	MoveObject(MissilCaindo[2][playerid], AlvoX[playerid], AlvoY[playerid], AlvoZ[playerid]+10, 50, 0, 180, 0);
	SetTimerEx("MissilExplode", 1700, false, "i", playerid);
	return 1;
}
 
forward MissilExplode(playerid);
public MissilExplode(playerid)
{
	CreateExplosion(AlvoX[playerid], AlvoY[playerid], AlvoZ[playerid], 2, 10);
	CreateExplosion(AlvoX[playerid]+3, AlvoY[playerid], AlvoZ[playerid], 2, 10);
	CreateExplosion(AlvoX[playerid]+3, AlvoY[playerid]+3, AlvoZ[playerid], 2, 10);
	CreateExplosion(AlvoX[playerid], AlvoY[playerid]+3, AlvoZ[playerid], 2, 10);
	CreateExplosion(AlvoX[playerid]-3, AlvoY[playerid]+3, AlvoZ[playerid], 2, 10);
	CreateExplosion(AlvoX[playerid]-3, AlvoY[playerid], AlvoZ[playerid], 2, 10);
	CreateExplosion(AlvoX[playerid]-3, AlvoY[playerid]-3, AlvoZ[playerid], 2, 10);
	CreateExplosion(AlvoX[playerid], AlvoY[playerid]-3, AlvoZ[playerid], 2, 10);
	CreateExplosion(AlvoX[playerid]+3, AlvoY[playerid]-3, AlvoZ[playerid], 2, 10);
	DestroyObject(MissilCaindo[0][playerid]);
	DestroyObject(MissilCaindo[1][playerid]);
	DestroyObject(MissilCaindo[2][playerid]);
	Missil[0][playerid] = 0;
	Missil[0][playerid] = 0;
	Missil[0][playerid] = 0;
	MissilCaindo[0][playerid] = 0;
	MissilCaindo[1][playerid] = 0;
	MissilCaindo[2][playerid] = 0;
	MissilCriado[playerid] = false;
	AlvoX[playerid] = 0;
	AlvoY[playerid] = 0;
	AlvoZ[playerid] = 0;
	return 1;
}