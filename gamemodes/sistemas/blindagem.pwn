CMD:ajudablindagem(playerid, params[])
{
    if(!PlayerInfo[playerid][pLogado]) return SendClientMessage(playerid,COLOR_LIGHTRED, "ERRO:{FFFFFF} Você não está logado!");
	SendClientMessage(playerid, COLOR_LIGHTGREEN, "____________________Ajuda Blindagem____________________");
	SendClientMessage(playerid, COLOR_WHITE, "/blindar /blindagem");
	return 1;
}
 
CMD:blindar(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid))return SendClientMessage(playerid, COLOR_LIGHTRED, "Para você comprar uma blindagem , você precisa estar em um carro.");
    if(blindadinho[playerid] == 1)return SendClientMessage(playerid, COLOR_LIGHTRED, "Você já está blindado.");
	new idcarro = GetPlayerVehicleID(playerid);
    blindadinho[playerid] = 1;
	blindziiQz[GetPlayerVehicleID(playerid)] = 100;
	RepairVehicle(GetPlayerVehicleID(playerid));
	ziiQzblind(idcarro, playerid);
	SendClientMessage(playerid, COLOR_LIGHTRED, "Você blindou o veículo.");
  	return 1;
}
forward ziiQzblind(vehicleid, playerid);
public ziiQzblind(vehicleid, playerid)
{
	for(new car = 1; car <= NUMERO_CARROS; car++)
	{
	    if(blindziiQz[car] > 0)
		{
			new Float:health;
    		GetVehicleHealth(car, health);
        	if(health < 999)
			{
	    		blindziiQz[car] -= 5;
	    		RepairVehicle(car);
	    		return 0;
			}
    	}
	}
	return 1;
}
 
forward comprarblinddenovo(playerid);
public comprarblinddenovo(playerid)
{
 	SendClientMessage(playerid, COLOR_LIGHTRED, "Você já pode comprar uma blindagem novamente.");
  	blindadinho[playerid] = 0;
  	return 1;
}