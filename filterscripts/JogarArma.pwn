#include <a_samp>

#define MAX_ARMAS 100 // El máximo de armas que pueden haber en el suelo.
#define COLOR_VIOLETA 0xC2A2DAAA
#define azul 0x46A3FFFF
// -----------------------------------------------------------------------------
new Float:ObjCoords[MAX_ARMAS][3];
new Object[MAX_ARMAS];
new ObjectID[MAX_ARMAS][2];
new BigEar[MAX_PLAYERS];
// -----------------------------------------------------------------------------
new GunNames[48][] = { // Armas
	"nada",
	"um soco ingles",
	"um taco de golfe",
	"um cassetete",
	"uma Faca Ak-47",
	"um Baseball Bat",
	"uma pa",
	"um taco de sinuca",
	"uuma Katana",
	"uma motosserra",
	"um vibrador",
	"um dildo branco curto",
	"um dildo branco longo",
	"um dildo",
	"um buque de flores",
	"uma bengala",
	"uma Granada",
	"uma granada de fumaça",
	"um Molotov",
	"caçador de mísseis ou hidra",
	"fogo de hidra",
	"uma hélice",
	"uma Glock 19",
	"uma Pistola M9 SD",
	"uma Pistola .50",
	"uma Shotgun",
	"uma Sawed-off IZH-43",
	"uma Pump Shotgun",
	"uma CZ61 Skorpion",
	"uma MP5-K",
	"uma AKS-74U",
	"uma AR-15",
	"uma PDW",
	"um Rifle de caca",
	"uma Sniper",
	"um lançador de foguetes",
	"um lançador de mísseis procura calor",
	"um lança-chamas",
	"uma minigun",
	"uma carga explosiva",
	"um detonador de carga explosiva",
	"um aerosol de gas pimienta",
	"um extintor de fogo",
	"uma camera fotográfica",
	"oculos de visão noturna",
	"oculos termico",
	"um para-quedas",
	"pistola falsa"
};

new GunObjects[47][0] = { // Objetos
	{0},// Ninguna.
	{331},// Puño americano.
	{333},// Palo de golf.
	{334},// Porra policial.
	{335},// Navaja.
	{336},// Bate de béisbol.
	{337},// Pala.
	{338},// Palo de pool.
	{339},// Katana.
	{341},// Motosierra.
	{321},// Consolador violeta.
	{322},// Consolador corto blanco.
	{323},// Consolador largo blanco.
	{324},// Consolador vibrador.
	{325},// Ramo de flores.
	{326},// Bastón.
	{342},// Granada.
	{343},// Grabada de gas lacrimógeno.
	{344},// Cóctel Molotov.
	{0},
	{0},
	{0},
	{346},// 9mm.
	{347},// 9mm con silenciador.
	{348},// Desert eagle.
	{349},// Escopeta normal.
	{350},// Escopeta recortada.
	{351},// Escopeta de combate.
	{352},// UZI
	{353},// MP5
	{355},// AK47
	{356},// M4
	{372},// Tec-9
	{357},// Rifle de caza.
	{358},// Rifle de francotirador (sniper)
	{359},// Lanzaconhetes.
	{360},// Lanzacohetes busca-calor.
	{361},// Lanzallamas.
	{362},// Minigun.
	{363},// Detonador.
	{364},// Botón de detonador.
	{365},// Aerosol de gas pimienta.
	{366},// Extinguidor de fuego.
	{367},// Cámara fotográfica.
	{368},// Gafas de visión nocturna.
	{368},// Gafas de visión infrarroja.
	{371}// Paracaídas.
};
// -----------------------------------------------------------------------------

forward Pegar(playerid);
public Pegar(playerid)
{
		new f = MAX_ARMAS+1;
		for(new a = 0; a < sizeof(ObjCoords); a++)
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, ObjCoords[a][0], ObjCoords[a][1], ObjCoords[a][2]))
			{
				f = a;
				break;
			}
		}
		if(f > MAX_ARMAS) return SendClientMessage(playerid, 0x33AA3300, "{FF0000}Erro: {ffffff}Voce nao esta proximo a uma arma!");
		else
		{
		    new gunname[25];
		    new string[100];

			ObjCoords[f][0] = 0.0;
			ObjCoords[f][1] = 0.0;
			ObjCoords[f][2] = 0.0;

			DestroyObject(Object[f]);
			GivePlayerWeapon(playerid, ObjectID[f][0], ObjectID[f][1]);
			GetWeaponNameEx(ObjectID[f][0], gunname, sizeof(gunname));
			format(string, sizeof(string), "[INFO] Voce pegou %s no chao.", gunname);
			SendClientMessage(playerid, azul, string);
		}
		return 1;
}

forward Jogar(playerid);
public Jogar(playerid)
{
		new gunID = GetPlayerWeapon(playerid);
		new gunAmmo = GetPlayerAmmo(playerid);
		new string[100];
		if(gunID != 0 && gunAmmo != 0)
		{
			new f = MAX_ARMAS+1;
			for(new a = 0; a < sizeof(ObjCoords); a++)
			{
				if(ObjCoords[a][0] == 0.0)
				{
					f = a;
					break;
				}
			}
			if(f > MAX_ARMAS) return SendClientMessage(playerid, 0x33AA3300, "{FF0000}Erro: {ffffff}Foi atingido o maximo de armas no chao no server! tente novamente em breve."); // Éste mensaje aparece si se superó el límite [MAX_ARMAS]
		    new gunname[25];
			GetWeaponNameEx(gunID, gunname, sizeof(gunname));
			RemovePlayerWeapon(playerid, gunID);
			format(string, sizeof(string), "[INFO] Voce soltou %s no chao.", gunname);
			SendClientMessage(playerid, azul, string);
			ObjectID[f][0] = gunID;
			ObjectID[f][1] = gunAmmo;
	        GetPlayerPos(playerid, ObjCoords[f][0], ObjCoords[f][1], ObjCoords[f][2]);
	        Object[f] = CreateObject(GunObjects[gunID][0],ObjCoords[f][0],ObjCoords[f][1],ObjCoords[f][2]-1,93.7,120.0,120.0);
			return 1;
		}
		return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new gunID = GetPlayerWeapon(playerid);
	new gunAmmo = GetPlayerAmmo(playerid);
	if(gunID != 0 && gunAmmo != 0)
	{
		new f = MAX_ARMAS+1;
		for(new a = 0; a < sizeof(ObjCoords); a++)
		{
			if(ObjCoords[a][0] == 0.0)
			{
				f = a;
				break;
			}
		}
  		ObjectID[f][0] = gunID;
		ObjectID[f][1] = gunAmmo;
 		GetPlayerPos(playerid, ObjCoords[f][0], ObjCoords[f][1], ObjCoords[f][2]);
 		Object[f] = CreateObject(GunObjects[gunID][0],ObjCoords[f][0],ObjCoords[f][1],ObjCoords[f][2]-1,93.7,120.0,120.0);
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new idx;
	cmd = strtok(cmdtext, idx);
	if(strcmp(cmd, "/dropararma", true) == 0)
	{
		SetTimerEx("Jogar", 800, false, "i", playerid);
		return 1;
	}
	if(strcmp(cmd, "/pegararma", true) == 0)
	{
        SetTimerEx("Pegar", 800, false, "i", playerid);
        return 1;
	}
	return 0;
}
// -----------------------------------------------------------------------------
forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)))
			{
				if(!BigEar[i])
				{
         			GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
				else
				{
					SendClientMessage(i, col1, string);
				}
			}
		}
	}//not connected
	return 1;
}

stock GetWeaponNameEx(id, name[], len) return format(name,len, "%s", GunNames[id]);

stock RemovePlayerWeapon(playerid, weaponid);
public RemovePlayerWeapon(playerid, weaponid)
{
	new plyWeapons[12] = 0;
	new plyAmmo[12] = 0;
	for(new sslot = 0; sslot != 12; sslot++)
	{
		new wep, ammo;
		GetPlayerWeaponData(playerid, sslot, wep, ammo);
		if(wep != weaponid && ammo != 0) GetPlayerWeaponData(playerid, sslot, plyWeapons[sslot], plyAmmo[sslot]);
	}
	ResetPlayerWeapons(playerid);
	for(new sslot = 0; sslot != 12; sslot++)
	{
	    if(plyAmmo[sslot] != 0) GivePlayerWeapon(playerid, plyWeapons[sslot], plyAmmo[sslot]);
	}
	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}
	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

stock PlayerName(playerid)
{
    new Nombre[24];
    GetPlayerName(playerid,Nombre,24);
    new N[24];
    strmid(N,Nombre,0,strlen(Nombre),24);
    for(new i = 0; i < MAX_PLAYER_NAME; i++)
    {
        if (N[i] == '_') N[i] = ' ';
    }
    return N;
}
