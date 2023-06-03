

//INCLUDES
#include <a_samp>
#include <zcmd>
#include <foreach>

//VARIAVEIS
new Mina1[MAX_PLAYERS];
new Float: pX[MAX_PLAYERS], Float: pY[MAX_PLAYERS], Float: pZ[MAX_PLAYERS];
new Passounamina;
new Mina[MAX_PLAYERS];

main()
{

}

public OnGameModeInit()
{
	return 1;
}
public OnGameModeExit()
{
	return 1;
}
public OnPlayerConnect(playerid)
{
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}
public OnPlayerSpawn(playerid)
{
	return 1;
}	    
public OnPlayerPickUpPickup(playerid, pickupid)
{
	//QUANDO O JOGADOR PASSAR EM CIMA DA "MINA"
	if(pickupid == Passounamina)
	{
	    SendClientMessage(playerid, 0x00FF0000, "Voce pisou na mina e ela explodiu!");
		for(new p = 0; p < 1; p++)
		{
		    foreach(new i: Player)
		    {
				if(IsPlayerConnected(playerid))
				{
		 			CreateExplosion(pX[p], pY[p], pZ[p], 10, 10);
					DestroyObject(Mina1[p]);
					Passounamina = DestroyPickup(0);
					Mina[p] = 0;
				}
			}
		}
	}
	return 1;
}
CMD:mina(playerid)
{
	if(Mina[playerid] == 1) return SendClientMessage(playerid, -1, "{FF0000}Voce ja implantou uma mina!");
	GetPlayerPos(playerid, pX[playerid], pY[playerid], pZ[playerid]);
	GetXYInFrontOfPlayer(playerid, pX[playerid], pY[playerid], 0.5);
	Mina1[playerid] = CreateObject(1654, pX[playerid], pY[playerid], pZ[playerid] - 0.8,270,0,0);
	SendClientMessage(playerid, -1, "{FF0000}Voce implantou uma mina! Em 5 segundos ela sera ativa saia dai!");
	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 5.0, 0, 0, 0, 0, 0);
	SetTimerEx("Depois", 5000, 0, "d", playerid);
	Mina[playerid] = 1;
	return 1;
}

forward Depois(playerid);
public Depois(playerid)
{
    Passounamina = CreatePickup(0, 1, pX[playerid], pY[playerid], pZ[playerid]);
	return 1;
}
stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
    new Float:a;
    GetPlayerPos(playerid, x, y, a);
    GetPlayerFacingAngle(playerid, a);
    if(GetPlayerVehicleID(playerid))
	{
        GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
    }
    x += (distance * floatsin(-a, degrees));
    y += (distance * floatcos(-a, degrees));
}
