/*===================================================================================================================================
|                                        Survive the Apocalypse - Cria
por: JPedro (Mantenha os Cr√©ditos)                         |
|                                                  Versao: 0.0 - Ultimo Update: 00/00/0000                                          |
|    _____                      _               _    _              ___                             _                               |
|   /  ___|                    (_)             | |  | |            / _ \                           | |                              |
|   \ `--.  _   _  _ __ __   __ _ __   __ ___  | |_ | |__    ___  / /_\ \ _ __    ___    ___  __ _ | | _   _  _ __   ___   ___      |
|    `--. \| | | || '__|\ \ / /| |\ \ / // _ \ | __|| '_ \  / _ \ |  _  || '_ \  / _ \  / __|/ _` || || | | || '_ \ / __| / _ \     \
|   /\__/ /| |_| || |    \ V / | | \ V /|  __/ | |_ | | | ||  __/ | | | || |_) || (_) || (__| (_| || || |_| || |_) |\__ \|  __/     |
|   \____/  \__,_||_|     \_/  |_|  \_/  \___|  \__||_| |_| \___| \_| |_/| .__/  \___/  \___|\__,_||_| \__, || .__/ |___/ \___|     |
|                                                                        | |                            __/ || |                    |
|                                                                        |_|                           |___/ |_|                    |
| Index dos attached object: 0 = Mochilas, 1 = Colete, 2 = Capacete, 3 = Particula do Sangue    964 = airdrop                                    |
===================================================================================================================================*/

// # Includes #

#include <a_samp>
#include <streamer>
#include <foreach>
#include <sscanf2>
#include <zcmd>
#include <DOF2>
#include <progress2>
#include <progress>

// # Defines #



#undef MAX_PLAYERS
#define MAX_PLAYERS (30)
#define MAX_PAREDE 300
#define MAX_CAIXA 300
#define forno 2144

#define MODENAME "gamemodetext Survive 1.5.0"
#define HOSTNAME "hostname NextDay - Survival | @Ecxon.com.br"
#define LANGUAGE "language PT-BR"
#define RCON     "rcon_password 123"
#define WEBURL   "weburl nextdaysurvival.rf.gd/"

// # Cores #

#define COR_CINZA 0xBABABAFF
#define COR_VERMELHO 0xDE6847FF
#define COR_AMARELO 0xEDC72DFF
#define COL_GREEN          "{37DB45}"
#define azul 0x46A3FFFF
#define PlayerNoLugar(%1,%2,%3,%4,%5)   IsPlayerInRangeOfPoint(%1,%2,%3,%4,%5)

#define ContaSalva "/Dayz/Contas/%s.ini"
new arquivo[100];
new Float:vida32[MAX_PLAYERS];
new Float:colete32[MAX_PLAYERS];
new Arvores[6];
new bool:natora[MAX_PLAYERS];
new ator1;
new idparedebomb[MAX_PLAYERS];
new objetoc4[MAX_PLAYERS];
new idcaixap[MAX_PLAYERS];
new bool:msglog[MAX_PLAYERS];


// # Dialogs #
#define D_Sexo             (2)
#define D_Inventario       (3)
#define D_UsarDropar       (4)
#define D_PegarItem        (5)
#define DIALOG_TENT_VIEW 17
#define DIALOG_TENT_VIEW_S 18
#define DIALOG_TENT_VIEW_S2 19
#define MAX_ITEMS 64

// # Enumeradores e Variaveis #

enum Player_Data
{
	pSenha[100],
	bool:pConectado,
	bool:pRegistrado,
	pIdioma,
    pAdmin,
    pAviso,
    bool:pMute,
    bool:pBlockPM,
    
    pChat,
    pBackpack,
    pSlots,

	pFome,
	pSede,
	pRadiation,
	pReputation,

	pExp,
	pLevel,

	pRespawn,
	pSangrando,
	pQuebrado,
	pTemGPS,
	pTemColete,
	pTemCapacete,
	pCoin,
	pkill,
	pDeath,
	Float:pPosX,
	Float:pPosY,
	Float:pPosZ,
	pBanido,
	pSkin,
	PTemperatura,
	pMadeira,
	pTentLink,
	
};

enum ParedeInfo
{
    ID,
   	Dono[128],
    Existe,
    ObjectJ,
    Float: PosX,
    Float: PosY,
    Float: PosZ,
    Float: RX,
    Float: RY,
    Float: RZ,
	metallife,
}
new Parede[MAX_PAREDE][ParedeInfo];

enum CaixaInfo
{
    ID,
   	Dono[128],
    Existe,
    ObjectC,
    Float: PosX,
    Float: PosY,
    Float: PosZ,
    Float: RX,
    Float: RY,
    Float: RZ,
	bool:caberta,
	Item1[64],
	Item2[64],
	Item3[64],
	Item4[64],
	Item5[64],
	Item6[64],
	Item7[64],
	Item8[64],
}
new Caixa[MAX_CAIXA][CaixaInfo];

new pInfo[MAX_PLAYERS][Player_Data];

enum Vehicle_Data
{
	vCombustivel,
	bool:vTemMotor,
	bool:vMotor,
};

new vInfo[MAX_VEHICLES][Vehicle_Data];

new engine, lights, alarm, doors, bonnet, boot, objective;
new gps;

// # Arrays #

new GunName[47][20] = 
{
	"Fist","Brass Knuckles","Golf Club","Nightstick","Knife","Basebal Bat","Shovel","Pool Cue","Katana","Chainsaw","Double-ended Dildo","Dildo","Vibrator",
	"Silver Vibrator","Flowers","Cane","Grenade","Tear Gas","Molotv Cocktail","?","?","?","9mm","Silenced 9mm","Desert Eagle","Shotgun","Sawnoff-Shotgun",
	"Combat Shotgun","Micro-SMG","MP5","Ak-47","M4","Tec9","Country Rifle","Sniper Rifle","RPG","HS-RPG","Flame-Thrower","Minigun","Satchel Charge","Detonator",
	"Spray Can","Fire Extinguisher","Camera","Night Goggles","Thermal Goggles","Parachute"
};

new Float:Respawns[][] =
{
	{-775.4976,948.9992,2.9075}, 
    {-651.7646,1323.0013,1.7699}, 
    {-1388.4598,2113.0090,42.1866},
    {-1868.6117,2148.7368,2.2704}, 
    {-2328.5283,2527.1621,4.7852}, 
    {-2888.9463,109.2686,4.5482},
    {-2322.1150,-2795.7566,10.7334}, 
    {543.0943,-1868.9418,4.1466}, 
    {2904.9805,-2011.8224,2.3552}, 
    {1945.0385,-270.4832,2.6262},
    {2293.6926,529.0938,1.7944}, 
    {-785.5703,671.7933,9.7264}, 
    {194.9760,146.6970,2.4229}, 
    {-87.2342,-549.2239,3.3717}, 
    {546.1076,2887.4233,5.2486}
};

// # Forwards #

forward AtualizarFome();
forward AtualizarSede();
forward AtualizarGasolina();
forward Sangrar(playerid);

// # Macros #

#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define HOLDING(%0) ((newkeys & (%0)) == (%0))

// # Modulos #

#include "modulos/admin.inc"
#include "modulos/comandos.inc"
#include "modulos/textdraws.inc"
#include "modulos/items.inc"
#include "modulos/inventario.inc"
#include "modulos/loot.inc"
#include "modulos/mapas-veiculos.inc"
#include "modulos/mapas.inc"

stock pName2(PN)
{
    new PX[MAX_PLAYER_NAME];
    GetPlayerName(PN, PX, sizeof(PX));
    return PX;
}
main()
{
	print("\n----------------------------------");
	print(" Survive the Apocalypse - Iniciado!");
	print("----------------------------------\n");
}


forward ACSave(playerid);
public ACSave(playerid)
{
	GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
	pInfo[playerid][pLevel] = GetPlayerScore(playerid);
	pInfo[playerid][pSkin] = GetPlayerSkin(playerid);
	vida32[playerid] = GetPlayerHealth(playerid);
	colete32[playerid] = GetPlayerArmour(playerid);
	format(arquivo, sizeof(arquivo), ContaSalva, pName2(playerid));
	if(!DOF2_FileExists(arquivo))
	{
	    DOF2_CreateFile(arquivo);
     	DOF2_SetInt(arquivo, "Senha", pInfo[playerid][pSenha]);
     	DOF2_SetInt(arquivo, "Coin", pInfo[playerid][pCoin]);
   	 	DOF2_SetInt(arquivo, "Score", pInfo[playerid][pLevel]);
   	 	DOF2_SetInt(arquivo, "Mochila", pInfo[playerid][pBackpack]);
     	DOF2_SetInt(arquivo, "OColete", pInfo[playerid][pTemColete]);
     	DOF2_SetInt(arquivo, "Capacete", pInfo[playerid][pTemCapacete]);
     	DOF2_SetInt(arquivo, "Kills", pInfo[playerid][pkill]);
     	DOF2_SetInt(arquivo, "Death", pInfo[playerid][pDeath]);
     	DOF2_SetInt(arquivo, "Fome", pInfo[playerid][pFome]);
     	DOF2_SetInt(arquivo, "Sede", pInfo[playerid][pSede]);
     	DOF2_SetInt(arquivo, "Admin", pInfo[playerid][pAdmin]);
     	DOF2_SetInt(arquivo, "Skin", pInfo[playerid][pSkin]);
     	DOF2_SetInt(arquivo, "GPS", pInfo[playerid][pTemGPS]);
     	DOF2_SetInt(arquivo, "Banido", pInfo[playerid][pBanido]);
     	DOF2_SetFloat(arquivo, "vida", vida32[playerid]);
     	DOF2_SetFloat(arquivo, "colete", colete32[playerid]);
     	DOF2_SetFloat(arquivo, "SpawnX", pInfo[playerid][pPosX]);
     	DOF2_SetFloat(arquivo, "SpawnY", pInfo[playerid][pPosY]);
     	DOF2_SetFloat(arquivo, "SpawnZ", pInfo[playerid][pPosZ]);
     	DOF2_SetInt(arquivo, "Madeira", pInfo[playerid][pMadeira]);
     	DOF2_SaveFile();
	}
	else
	{
     	DOF2_SetInt(arquivo, "Senha", pInfo[playerid][pSenha]);
     	DOF2_SetInt(arquivo, "Coin", pInfo[playerid][pCoin]);
   	 	DOF2_SetInt(arquivo, "Score", pInfo[playerid][pLevel]);
   	 	DOF2_SetInt(arquivo, "Mochila", pInfo[playerid][pBackpack]);
     	DOF2_SetInt(arquivo, "OColete", pInfo[playerid][pTemColete]);
     	DOF2_SetInt(arquivo, "Capacete", pInfo[playerid][pTemCapacete]);
     	DOF2_SetInt(arquivo, "Kills", pInfo[playerid][pkill]);
     	DOF2_SetInt(arquivo, "Death", pInfo[playerid][pDeath]);
     	DOF2_SetInt(arquivo, "Fome", pInfo[playerid][pFome]);
     	DOF2_SetInt(arquivo, "Sede", pInfo[playerid][pSede]);
     	DOF2_SetInt(arquivo, "Admin", pInfo[playerid][pAdmin]);
     	DOF2_SetInt(arquivo, "Skin", pInfo[playerid][pSkin]);
     	DOF2_SetInt(arquivo, "GPS", pInfo[playerid][pTemGPS]);
     	DOF2_SetInt(arquivo, "Banido", pInfo[playerid][pBanido]);
     	DOF2_SetFloat(arquivo, "vida", vida32[playerid]);
     	DOF2_SetFloat(arquivo, "colete", colete32[playerid]);
     	DOF2_SetFloat(arquivo, "SpawnX", pInfo[playerid][pPosX]);
     	DOF2_SetFloat(arquivo, "SpawnY", pInfo[playerid][pPosY]);
     	DOF2_SetFloat(arquivo, "SpawnZ", pInfo[playerid][pPosZ]);
     	DOF2_SetInt(arquivo, "Madeira", pInfo[playerid][pMadeira]);
     	DOF2_SaveFile();
     	print( "Conta de algum jogador salva");
	}
	return 1;
}

forward ACCarrega(playerid);
public ACCarrega(playerid)
{
	format(arquivo, sizeof(arquivo), ContaSalva, pName2(playerid));
	if(!DOF2_FileExists(arquivo))
	{
	    DOF2_CreateFile(arquivo);
     	DOF2_SetInt(arquivo, "Senha", pInfo[playerid][pSenha]);
     	DOF2_SetInt(arquivo, "Coin", pInfo[playerid][pCoin]);
   	 	DOF2_SetInt(arquivo, "Score", pInfo[playerid][pLevel]);
   	 	DOF2_SetInt(arquivo, "Mochila", pInfo[playerid][pBackpack]);
     	DOF2_SetInt(arquivo, "OColete", pInfo[playerid][pTemColete]);
     	DOF2_SetInt(arquivo, "Capacete", pInfo[playerid][pTemCapacete]);
     	DOF2_SetInt(arquivo, "Kills", pInfo[playerid][pkill]);
     	DOF2_SetInt(arquivo, "Death", pInfo[playerid][pDeath]);
     	DOF2_SetInt(arquivo, "Fome", pInfo[playerid][pFome]);
     	DOF2_SetInt(arquivo, "Sede", pInfo[playerid][pSede]);
     	DOF2_SetInt(arquivo, "Admin", pInfo[playerid][pAdmin]);
     	DOF2_SetInt(arquivo, "Skin", pInfo[playerid][pSkin]);
     	DOF2_SetInt(arquivo, "GPS", pInfo[playerid][pTemGPS]);
     	DOF2_SetInt(arquivo, "Banido", pInfo[playerid][pBanido]);
     	DOF2_SetFloat(arquivo, "vida", vida32[playerid]);
     	DOF2_SetFloat(arquivo, "colete", colete32[playerid]);
     	DOF2_SetFloat(arquivo, "SpawnX", pInfo[playerid][pPosX]);
     	DOF2_SetFloat(arquivo, "SpawnY", pInfo[playerid][pPosY]);
     	DOF2_SetFloat(arquivo, "SpawnZ", pInfo[playerid][pPosZ]);
     	DOF2_SetInt(arquivo, "Madeira", pInfo[playerid][pMadeira]);
	}
	else
	{
	    pInfo[playerid][pSenha] = DOF2_GetInt(arquivo, "Senha");
	    pInfo[playerid][pCoin] = DOF2_GetInt(arquivo, "Coin");
	    pInfo[playerid][pLevel] = DOF2_GetInt(arquivo, "Score");
	    pInfo[playerid][pBackpack] = DOF2_GetInt(arquivo, "Mochila");
	    pInfo[playerid][pTemColete] = DOF2_GetInt(arquivo, "OColete");
	    pInfo[playerid][pTemCapacete] = DOF2_GetInt(arquivo, "Capacete");
	    pInfo[playerid][pkill] = DOF2_GetInt(arquivo, "Kills");
	    pInfo[playerid][pDeath] = DOF2_GetInt(arquivo, "Death");
	    pInfo[playerid][pFome] = DOF2_GetInt(arquivo, "Fome");
	    pInfo[playerid][pSede] = DOF2_GetInt(arquivo, "Sede");
	    pInfo[playerid][pAdmin] = DOF2_GetInt(arquivo, "Admin");
	    pInfo[playerid][pSkin] = DOF2_GetInt(arquivo, "Skin");
	    pInfo[playerid][pTemGPS] = DOF2_GetInt(arquivo, "GPS");
	    pInfo[playerid][pBanido] = DOF2_GetInt(arquivo, "Banido");
	    vida32[playerid] = DOF2_GetFloat(arquivo, "vida");
        colete32[playerid] = DOF2_GetFloat(arquivo, "colete");
        pInfo[playerid][pPosX] = DOF2_GetFloat(arquivo, "SpawnX");
        pInfo[playerid][pPosY] = DOF2_GetFloat(arquivo, "SpawnY");
        pInfo[playerid][pPosZ] = DOF2_GetFloat(arquivo, "SpawnZ");
        pInfo[playerid][pMadeira] = DOF2_GetInt(arquivo, "Madeira");
	 }
}


public OnGameModeInit()
{
	for(new i = 0; i < MAX_PAREDE; i ++)
	{
    	CarregarParede(i);
	}
	for(new i = 0; i < MAX_CAIXA; i ++)
	{
		CarregarCaixa(i);
	}
    SendRconCommand(MODENAME), SendRconCommand(HOSTNAME), SendRconCommand(LANGUAGE), SendRconCommand(RCON), SendRconCommand(WEBURL);
	DisableInteriorEnterExits(), EnableStuntBonusForAll(false), UsePlayerPedAnims(), ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	SetNameTagDrawDistance(5.0), ManualVehicleEngineAndLights();

    SpawnLoots();
	CarregarVeiculos();
	CarregarMapa();

    SetTimer("AtualizarFome", 120000, true);
	SetTimer("AtualizarSede", 60000, true);
	SetTimer("AtualizarGasolina", 60000, true);
	SetTimer("ciclo", 3600000, false);

	Arvores[0] = CreateObject(655, -1445.602661, -1884.705932, 35.008392, 0.000000, 0.000000, 0.000000, 300.00);
	Arvores[1] = CreateObject(655, -1392.926025, -1998.389770, 1.831115, 0.000000, 0.000000, 0.000000, 300.00);
	Arvores[2] = CreateObject(655, -1373.279907, -2090.253906, 22.786346, 0.000000, 0.000000, 0.000000, 300.00);
	Arvores[3] = CreateObject(655, -1318.969848, -2074.424804, 22.565423, 0.000000, 0.000000, 0.000000, 300.00);
	Arvores[4] = CreateObject(655, -1262.460449, -2186.888183, 27.902259, 0.000000, 0.000000, 0.000000, 300.00);
	Arvores[5] = CreateObject(655, -1345.709228, -2234.226806, 30.076278, 0.000000, 0.000000, 0.000000, 300.00);
	Create3DTextLabel("* ÔøΩrvore * \n {A9A9A9} Pegue Madeiras",azul, -1445.602661, -1884.705932, 35.008392, 20, 0);
	ator1 = CreateActor(67, 261.4818,2895.9587,10.2384, 90.0926);
	ApplyActorAnimation(ator1, "RIOT","RIOT_CHANT",4.0,1,1,1,1,0);
	gps = GangZoneCreate(-3334.758544, -3039.903808, 3049.241455, 3184.096191); // Gangzone do tamanho do mapa pra esconder o mapa do jogador
	return 1;
}

public OnGameModeExit()
{
	for(new i; i < MAX_PAREDE; i++)
	{
		if(Parede[i][Existe]) SalvarParede(i);
	}
	for(new i; i < MAX_CAIXA; i++)
	{
		if(Caixa[i][Existe]) SalvarCaixa(i);
	}
    DOF2_Exit();
	return 1;
}

CMD:random(playerid)
{
	new strd[60];
	for(new i; i < 20; i ++)
	{
    	new rand = minrand(0, 9);
    	format(strd, sizeof(strd), "%d", rand);
    	SendClientMessage(playerid, -1, strd);
	}
    return 1;
}

CMD:teleto(playerid, params[])
{
	new Float:x, Float:y, Float:z;
	if(sscanf(params, "fff", x,y,z)) return SendClientMessage(playerid, -1, "use: /fechar [id da porta]");
	SetPlayerPos(playerid, x,y,z);
	return 1;
}

CMD:serra(playerid)
{
	GivePlayerWeapon(playerid, 9);
}

public OnPlayerConnect(playerid)
{
	CarregarPlayerText(playerid);
	SelectTextDraw(playerid, 0xFF4040AA);
	PlayerPlaySound(playerid, 1097, 0.0, 0.0, 10.0);
	for(new i = 0; i < 11; i++) { TextDrawShowForPlayer(playerid, PublicTD6[i]); }
	SetPlayerCameraPos(playerid, -2494.6897,1508.4241,242.3019);
	SetPlayerCameraLookAt(playerid, -2571.0085,1640.4097,202.2260);
	//for(new i = 0; i < 12; i++) { PlayerTextDrawShow(playerid, PlayerTD3[playerid][i]); }
 	for(new i; i < MAX_PLAYERS; i ++)
  	{
  		if(IsPlayerConnected(i))
    	{
			ShowProgressBarForPlayer(i, barsede);
			ShowProgressBarForPlayer(i, barfome);
     	}
     }
	TogglePlayerSpectating(playerid, true);
	for(new i; i < MAX_PLAYER_ATTACHED_OBJECTS; i++) RemovePlayerAttachedObject(playerid, i); // Remove os objetos
	new string[50];
	format(string,sizeof(string), "{FFFF00}%s {C0C0C0}Entrou no servidor.", pName2(playerid));
	SendClientMessageToAll(-1,string);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(pInfo[playerid][pConectado] == true)
	{
		ACSave(playerid);
	}
	for(new Player_Data:i; i < Player_Data; i++) pInfo[playerid][i] = 0;  // Resta os Dados
	pInfo[playerid][pConectado] = false;
	return 1;
}
public OnPlayerRequestClass(playerid,classid)
{
    return 0;
}

public OnPlayerRequestSpawn(playerid)
{
    return 1;
}

public OnPlayerSpawn(playerid)
{	
	if(pInfo[playerid][pRespawn] == 2)
	{
		new rnd = random(sizeof(Respawns));
		SetPlayerPos(playerid, Respawns[rnd][0], Respawns[rnd][1], Respawns[rnd][2]);
		SetPlayerInterior(playerid, 0), SetPlayerVirtualWorld(playerid, 0);
		ResetarPlayer(playerid);
		TogglePlayerSpectating(playerid, false);
        ShowPlayerDialog(playerid, 30, DIALOG_STYLE_LIST, "Escolha seu sexo", "{FFFF00}Masculino\n{0000FF}Feminino", "Selecionar",#);
	}
  
    for(new i = 0; i < 6; i++) { PlayerTextDrawShow(playerid, PlayerTD1[playerid][i]); }

  	if(pInfo[playerid][pTemGPS] == 1)
	{
		GangZoneHideForPlayer(playerid, gps);
		TextDrawShowForPlayer(playerid, PublicTD2[3]);
		TextDrawShowForPlayer(playerid, PublicTD2[1]);
		TextDrawShowForPlayer(playerid, PublicTD2[0]);
	}
	else 
	{
        TextDrawShowForPlayer(playerid, PublicTD2[1]);
        TextDrawShowForPlayer(playerid, PublicTD2[2]);
        TextDrawShowForPlayer(playerid, PublicTD2[0]);
		GangZoneShowForPlayer(playerid, gps, 0x000000FF);
	}

    SetPlayerObject(playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(pInfo[playerid][pConectado] == true && IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	{
 		pInfo[playerid][pDeath] ++;
		ForceDrop(playerid);
	}
	pInfo[killerid][pkill] ++;
	SetPlayerScore(killerid, GetPlayerScore(killerid)+1);
	if(pInfo[playerid][pTemCapacete] == 1)
	{
	    RemovePlayerAttachedObject(playerid, 8);
        pInfo[playerid][pTemCapacete] = 0;
	}
	SetTimerEx( "spawnando", 1000, false, "i", playerid);
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	new animlib[32], animname[32];
	GetAnimationName(GetPlayerAnimationIndex(playerid), animlib, 32, animname, 32);

	if(pInfo[playerid][pQuebrado] == 0) // Checa se o jogador nao estiver com a perna quebrada
	{
		if(amount > 15 && strcmp("FALL_FALL", animname, true) == 0) // Quando cai de uma certa altura
		{
			if(pInfo[playerid][pQuebrado] == 0)
			{
				pInfo[playerid][pQuebrado] = 1;
				GameTextForPlayer(playerid, "~w~Perna Quebrada!", 1500, 3);
				PlayerTextDrawShow(playerid, BrokenL[playerid]);
			}
		}
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(pInfo[playerid][pConectado] == false) return SendClientMessage(playerid, -1, "VOCE NAO PODE ENVIAR MENSAGENS");
    new message[128];
    format(message, sizeof(message), "[Local] %s: %s", pName2(playerid), text);
    ProxDetector(30.0, playerid, message, -1);
    return 0;
}

public OnPlayerUpdate(playerid)
{
	if(!IsPlayerNPC(playerid) && IsPlayerConnected(playerid))
	{
		if(pInfo[playerid][pConectado] == true)
		{
			new str[200];
   			SetProgressBarValue(barfome, pInfo[playerid][pFome]);
		    UpdateProgressBar(barfome,playerid);

   			format(str, sizeof(str), "%.0i%", pInfo[playerid][pFome]);
			PlayerTextDrawSetString(playerid, PlayerTD1[playerid][1], str);

   			SetProgressBarValue(barsede, pInfo[playerid][pSede]);
		    UpdateProgressBar(barsede,playerid);

   			format(str, sizeof(str), "%.0i%", pInfo[playerid][pSede]);
			PlayerTextDrawSetString(playerid, PlayerTD1[playerid][3], str);

			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				format(str, sizeof(str), "Gas: ~r~%i~n~~w~Motor: %s", vInfo[vehicleid][vCombustivel], vInfo[vehicleid][vTemMotor] ? ("~g~Sim") : ("~r~Nao"));
				PlayerTextDrawSetString(playerid, VEH_HUD[playerid][3], str);
				if(vInfo[vehicleid][vCombustivel] <= 0)
				{
					SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective);
				}
				if(vInfo[vehicleid][vTemMotor] == false)
				{
					SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective);
				}
			}
		}

	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == 131072 && GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
		if(PlayerNoLugar(playerid, 2.0, -1445.602661, -1884.705932, 35.008392))
		{
            if(GetPlayerWeapon(playerid) == 9)
            {
                if(natora[playerid] == false)
                {
                	GameTextForPlayer(playerid, "~w~Coletando ~g~Madeira", 1000, 4);
                	ApplyAnimation(playerid, "CHAINSAW", "CSAW_2", 4.1, 1, 0, 0, 1, 0, 0);
					SetTimerEx( "pegandomadeira", 5000, false, "i", playerid);
					natora[playerid] = true;
				}
				else return SendClientMessage(playerid, azul, "{CE0000}[ERRO] Voce ja esta coletando madeira");
			}
			else return SendClientMessage(playerid, azul, "{CE0000}[ERRO] Voce nao possui uma serra eletrica");
		}
	}
	if(pInfo[playerid][pConectado] == true && IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	{
		Item_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 0)
	{
	    if(!strval(inputtext)) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_PASSWORD, "Registrando a sua conta", "Digite uma senha para criar sua conta, ( SOMENTE NUMEROS )", "Registrar", "sair");
	    if(!response) return Kick(playerid);
	    if(response)
	    {
	        pInfo[playerid][pSenha] = strval(inputtext);
	        SendClientMessage(playerid,-1,"{FFFF00}[>] {46A3FF}Conta criada com sucesso!");
	        print( "Conta de alguem foi criada com sucesso!");
	        for(new i = 0; i < 12; i++) { PlayerTextDrawHide(playerid, PlayerTD3[playerid][i]); }
	        ResetarPlayer(playerid);
	        PlayerPlaySound(playerid, 1098, 0.0, 0.0, 10.0);
            pInfo[playerid][pRespawn] = 2;
            pInfo[playerid][pConectado] = true;
	        SetSpawnInfo(playerid, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	        SpawnPlayer(playerid);
            ACSave(playerid);
		}
	}
	if(dialogid == 1)
	{
	    if(!strval(inputtext)) return ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "Voce ja possui uma conta", "Voce ja possui uma conta, digite sua para poder logar", "Logar", "sair");
	    if(!response) return Kick(playerid);
	    if(response)
	    {
            pInfo[playerid][pSenha] = DOF2_GetInt(arquivo, "Senha");
            if(strval(inputtext) == pInfo[playerid][pSenha])
            {
	        	ACCarrega(playerid);
	        	pInfo[playerid][pRespawn] = 0;
	        	SendClientMessage(playerid,-1,"{FFFF00}[>] {46A3FF}Logado com sucesso!");
				print("Conta de alguem logada com sucesso!");
				PlayerPlaySound(playerid, 1098, 0.0, 0.0, 10.0);
				for(new i = 0; i < 12; i++) { PlayerTextDrawHide(playerid, PlayerTD3[playerid][i]); }
				SetSpawnInfo(playerid, 0, 90, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ], 0, 0, 0, 0, 0, 0, 0);
				SpawnPlayer(playerid);
				TogglePlayerSpectating(playerid, false);
				SetTimerEx( "carregandodados", 2000, false, "i", playerid);
				pInfo[playerid][pConectado] = true;
			}
			else return ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "Voce ja possui uma conta", "Voce ja possui uma conta, digite sua para poder logar", "Logar", "sair");
		}
	 }
	if(dialogid == 30)
	{
		if(!response) return ShowPlayerDialog(playerid, 30, DIALOG_STYLE_LIST, "Escolha seu sexo", "{FFFF00}Masculino\n{0000FF}Feminino", "Selecionar",#);
		if(response)
		{
		    if(listitem == 0)
		    {
		        SendClientMessage(playerid, azul, "Voce escolheu uma skin masculina");
		        SetPlayerSkin(playerid, 97);
			}
			if(listitem == 1)
			{
		        SendClientMessage(playerid, azul, "Voce escolheu uma skin feminina");
		        SetPlayerSkin(playerid, 90);
			}
		}
	}
    if(dialogid == 67)
    {
        if(response) //Ao Clickar no primeiro bot„o
        {
            if(listitem == 0) //Ao clickar no primeiro item
            {
				ShowPlayerDialog(playerid, 68, DIALOG_STYLE_LIST, "Defesas", "Parede de Madeira", "Ver Craft", "Fechar");
            }
            if(listitem == 1) //Ao clickar no segundo item
            {
				//FunÁ„o se o player clickar no segundo item
            }
            if(listitem == 2) //Ao clickar no terceiro item
            {
                //FunÁ„o se o player clickar no terceiro item
            }
        }
    }
    if(dialogid == 68)
    {
        if(response) //Ao Clickar no primeiro bot„o
        {
            if(listitem == 0) //Ao clickar no primeiro item
            {
				ShowPlayerDialog(playerid, 69, DIALOG_STYLE_MSGBOX, "Parede de Madeira", "{4AC13E}Madeiras:{FFFFFF} 75", "Fechar", #);
            }
            if(listitem == 1) //Ao clickar no segundo item
            {
				//FunÁ„o se o player clickar no segundo item
            }
            if(listitem == 2) //Ao clickar no terceiro item
            {
                //FunÁ„o se o player clickar no terceiro item
            }
        }
    }
	Item_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[0]);
	INV_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[0]);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	vInfo[vehicleid][vCombustivel] = random(20);
	vInfo[vehicleid][vTemMotor] = false;
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(pInfo[playerid][pConectado] == true && IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			
			new vehicleid = GetPlayerVehicleID(playerid);
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

			if(IsABike(vehicleid)) { SetVehicleParamsEx(vehicleid, 1, lights, alarm, doors, bonnet, boot, objective); } // Liga a bicicleta pois ela nao tem motor
			else
			{
				if(vInfo[vehicleid][vTemMotor] == true && vInfo[vehicleid][vMotor] == false) SendClientMessage(playerid, COR_AMARELO, Translate(pInfo[playerid][pIdioma], "[INFO]: Digite: '/engine' ou aperte 'CAPSLOCK' para ligar o motor.", 
				"[INFO]: Type: '/engine or press 'CAPSLOCK' to start vehicle engine."));

				if(vInfo[vehicleid][vCombustivel] == 0) SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective);
				if(vInfo[vehicleid][vTemMotor] == false) SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective);

				for(new i; i < sizeof(VEH_HUD); i++) PlayerTextDrawShow(playerid, VEH_HUD[playerid][i]);
			}
		}
		else for(new i; i < sizeof(VEH_HUD); i++) PlayerTextDrawHide(playerid, VEH_HUD[playerid][i]);
	}
	return 1;
}

public AtualizarGasolina()
{
	foreach(Player, i)
	{
		if(pInfo[i][pConectado] == true && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
			new vehicleid = GetPlayerVehicleID(i);
			if(GetPlayerState(i) == PLAYER_STATE_DRIVER && !IsABike(vehicleid))
			{
				if(vInfo[vehicleid][vCombustivel] > 0) vInfo[vehicleid][vCombustivel]--;
				if(vInfo[vehicleid][vCombustivel] == 0)
				{
					GameTextForPlayer(i, "~r~Empty Fuel", 2000, 3);
					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective);
				}
			}
		}
	}
	return 1;
}

public AtualizarFome()
{
	foreach(Player, i)
	{
		if(pInfo[i][pConectado] == true && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
			if(pInfo[i][pFome] > 0) pInfo[i][pFome]--;
			if(pInfo[i][pFome] == 5) SendClientMessage(i, COR_AMARELO, Translate(pInfo[i][pIdioma], "[FOME]: Voce esta ficando com fome, coma alguma coisa ou comecara a perder vida.", 
			"[HUNGER]: You're getting hungry, eat something or will begin to lose health."));
			if(pInfo[i][pFome] == 0)
			{
				new Float:health;
				GetPlayerHealth(i, health), SetPlayerHealth(i, health-10);
				SetPlayerDrunkLevel(i, 4500);
			}
		}
	}
	return 1;
}

public AtualizarSede()
{
	foreach(Player, i)
	{
		if(pInfo[i][pConectado] == true && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
			if(pInfo[i][pSede] > 0) pInfo[i][pSede]--;
			if(pInfo[i][pSede] == 5) SendClientMessage(i, COR_AMARELO, "[Sede]: Voce esta ficando com Sede, beba alguma coisa ou comecara a perder vida.");
			if(pInfo[i][pSede] == 0)
			{
				new Float:health;
				GetPlayerHealth(i, health), SetPlayerHealth(i, health-10);
				SetPlayerDrunkLevel(i, 4500);
			}
		}
	}
	return 1;
}

public Sangrar(playerid)
{
	new Float:health;
	GetPlayerHealth(playerid, health);
	if(health > 0.0)
	{
		if(pInfo[playerid][pSangrando] == 1)
		{
			SetPlayerHealth(playerid, health-5);
			SetPlayerDrunkLevel(playerid, 4500);
			SetPlayerAttachedObject(playerid, 3, 18668, 1, 0.000000, 0.000000, -1.837002, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000, 0, 0);
		}
	}
	return 1;
}

stock ResetarPlayer(playerid)
{
	ResetPlayerInventory(playerid);
	ResetPlayerWeapons(playerid);
    
    pInfo[playerid][pChat] = 0;
    pInfo[playerid][pQuebrado] = 0;
    pInfo[playerid][pSangrando] = 0;
	pInfo[playerid][pBackpack] = 5;
	pInfo[playerid][pFome] = 50;
	pInfo[playerid][pSede] = 50;
	pInfo[playerid][pRadiation] = 0;

	AddItem(playerid, "Garrafa com agua", 1);
	AddItem(playerid, "Curativo", 1);
	return 1;
}

stock SetPlayerObject(playerid)
{
	// # Mochilas #
	switch(pInfo[playerid][pBackpack])
    {
        case 5: SetPlayerAttachedObject(playerid, 0, 363, 1, 0.265998, -0.145998, 0.232999, 11.199977, 88.300025, -10.800001, 1.213999, 1.000000, 1.079999, 0xFF6C4C00);
        case 10: SetPlayerAttachedObject(playerid, 0, 3026, 1, -0.110999, -0.086999, 0.002999, 0.000000, 0.000000, 0.000000, 0.996999, 1.053998, 1.064001 );
        case 16: SetPlayerAttachedObject(playerid, 0, 1310, 1, -0.027999, -0.150999, 0.000000, 3.000000, 90.000000, 1.000000, 0.832000, 0.909000, 0.838000 );
        case 24: SetPlayerAttachedObject(playerid, 0, 19559, 1, 0.081000, -0.063000, 0.000000, 0.000000, 88.899955, 0.000000, 1.000000, 1.259000, 1.000000 );
        case 32: SetPlayerAttachedObject( playerid, 0, 1550, 1, 0.107000, -0.270999, 0.006999, 0.000000, 85.000000, 0.000000, 0.968999, 1.000000, 0.973999 );
        default: RemovePlayerAttachedObject(playerid, 0);
    }
	return 1;
}

stock Translate(language, text_PT[], text_EN[]) 
{ 
    new string[256]; 
     
    if(language == 1) format(string, sizeof(string), text_PT); 
    else if(language == 2) format(string, sizeof(string), text_EN); 
         
    return string; 
}

stock RemovePlayerWeapon(playerid, weaponid)
{
    new
        plyWeapons[ 12 ], plyAmmo[ 12 ];

    for( new slot = 0; slot != 12; slot ++ )
    {
        new
            weap, ammo;
            
        GetPlayerWeaponData( playerid, slot, weap, ammo );
        if( weap != weaponid )
        {
            GetPlayerWeaponData( playerid, slot, plyWeapons[ slot ], plyAmmo[ slot ] );
        }
    }
    ResetPlayerWeapons( playerid );
    for( new slot = 0; slot != 12; slot ++ )
    {
        GivePlayerWeapon( playerid, plyWeapons[ slot ], plyAmmo[ slot ] );
    }
} 

stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
    new Float:a;
    GetPlayerPos(playerid, x, y, a);
    GetPlayerFacingAngle(playerid, a);
    if (GetPlayerVehicleID(playerid)) {
        GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
    }
    x += (distance * floatsin(-a, degrees));
    y += (distance * floatcos(-a, degrees));
}

stock IsABike(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 481, 509, 510: return 1;
        default: return 0;
    }
    return 0;
}
 
stock PegarNome(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	return name;
}

forward carregandodados(playerid);
public carregandodados(playerid)
{
	SetPlayerScore(playerid, pInfo[playerid][pLevel]);
	SetPlayerHealth(playerid, vida32[playerid]);
	SetPlayerArmour(playerid, colete32[playerid]);
	SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
	pInfo[playerid][pRespawn] = 2;
	SendClientMessage(playerid, -1, "{FFFF00}[>] {5BADFF}Dados sincronizados com sucesso!");
    if(pInfo[playerid][pTemColete] == 1)
    {
        SetPlayerAttachedObject(playerid, 9, 19515, 1, 0.072999, 0.032000, 0.000000, 0.000000, 0.000000, 0.000000, 1.027999, 1.188000, 1.062999);
	}
	if(pInfo[playerid][pTemCapacete] == 1)
	{
	    SetPlayerAttachedObject(playerid, 8, 19200, 2, 0.119999, 0.014999, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
	}
}

stock CarregarParede(id)
{
	new file[64];
	new str[60];
    format(file, 64, "Data/Paredes/%d.ini", id);
    if(DOF2_FileExists(file))
    {
    
        DOF2_GetString(file,"Dono", Parede[id][Dono]);
		Parede[id][PosX] = DOF2_GetFloat(file, "PosX" );
		Parede[id][PosY] = DOF2_GetFloat(file, "PosY" );
		Parede[id][PosZ] = DOF2_GetFloat(file, "PosZ" );
		Parede[id][RX] = DOF2_GetFloat(file, "RX" );
		Parede[id][RY] = DOF2_GetFloat(file, "RY" );
		Parede[id][RZ] = DOF2_GetFloat(file, "RZ" );
		Parede[id][metallife] = DOF2_GetInt(file, "Metal" );
		Parede[id][ObjectJ] = CreateObject(19360, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], Parede[id][RX], Parede[id][RY], Parede[id][RZ]+90);
  		format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Parede[id][metallife]);
  		Create3DTextLabel(str, 0xFFFF00FF, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 10.0, 0, 0);
		Parede[id][Existe] = 1;
	}
	return 1;
}


stock CarregarCaixa(id)
{
	new file[64];
	new str[60];
    format(file, 64, "Data/Caixas/%d.ini", id);
    if(DOF2_FileExists(file))
    {

        format(Caixa[id][Dono], 128, DOF2_GetString(file, "Dono"));
		Caixa[id][PosX] = DOF2_GetFloat(file, "PosX" );
		Caixa[id][PosY] = DOF2_GetFloat(file, "PosY" );
		Caixa[id][PosZ] = DOF2_GetFloat(file, "PosZ" );
		Caixa[id][RX] = DOF2_GetFloat(file, "RX" );
		Caixa[id][RY] = DOF2_GetFloat(file, "RY" );
		Caixa[id][RZ] = DOF2_GetFloat(file, "RZ" );
		Caixa[id][caberta] = DOF2_GetBool(file, "aberta" );
    	format(Caixa[id][Item1], MAX_ITEM_NAME, DOF2_GetString(file, "Item1"));
		format(Caixa[id][Item2], MAX_ITEM_NAME, DOF2_GetString(file, "Item2"));
		format(Caixa[id][Item3], MAX_ITEM_NAME, DOF2_GetString(file, "Item3"));
		format(Caixa[id][Item4], MAX_ITEM_NAME, DOF2_GetString(file, "Item4"));
		format(Caixa[id][Item5], MAX_ITEM_NAME, DOF2_GetString(file, "Item5"));
		format(Caixa[id][Item6], MAX_ITEM_NAME, DOF2_GetString(file, "Item6"));
		format(Caixa[id][Item7], MAX_ITEM_NAME, DOF2_GetString(file, "Item7"));
		format(Caixa[id][Item8], MAX_ITEM_NAME, DOF2_GetString(file, "Item8"));
		Caixa[id][ObjectC] = CreateObject(1271, Caixa[id][PosX], Caixa[id][PosY], Caixa[id][PosZ]-0.6, Caixa[id][RX], Caixa[id][RY], Caixa[id][RZ]);
  		format(str, 60, "ID:{0080C0} %d",id);
  		Create3DTextLabel(str, 0xFFFF00FF, Caixa[id][PosX], Caixa[id][PosY], Caixa[id][PosZ], 10.0, 0, 0);
		Caixa[id][Existe] = 1;
	}
	return 1;
}


stock GetPlayerRangeParede(playerid)
{
	new id = -1, Float: distanciaA = 2.0, Float: distanciaB;
	for(new i; i < MAX_PAREDE; i++)
	{
		if(!Parede[i][Existe]) continue;
	    distanciaB = GetPlayerDistanceFromPoint(playerid, Parede[i][PosX], Parede[i][PosY], Parede[i][PosZ]);

		if(distanciaB <= distanciaA)
		{
			distanciaA = distanciaB;
			id = i;
			break;
		}
	}
	return id;
}

stock GetPlayerRangeCaixa(playerid)
{
	new id = -1, Float: distanciaA = 2.0, Float: distanciaB;
	for(new i; i < MAX_CAIXA; i++)
	{
		if(!Caixa[i][Existe]) continue;
	    distanciaB = GetPlayerDistanceFromPoint(playerid, Caixa[i][PosX], Caixa[i][PosY], Caixa[i][PosZ]);

		if(distanciaB <= distanciaA)
		{
			distanciaA = distanciaB;
			id = i;
			break;
		}
	}
	return id;
}

CMD:fornalha(playerid)
{
    new id = GetPlayerRangeParede(playerid);
    if(id == -1) return SendClientMessage(playerid, -1, "Voce esta perto de sua Forno!");
    if(strcmp(Parede[id][Dono], pName(playerid))) return SendClientMessage(playerid, -1, "Esta Forno nÔøΩo ÔøΩ sua!");
    ShowPlayerDialog(playerid, 55, DIALOG_STYLE_LIST, "Fornalha", "Cozinhar Peru\nCozinhar seupai\nLalal\npoximos itens", "Selecionar", "Cancelar");
    return 1;
}

stock SalvarParede(id)
{
	new file[64];
  	format(file, sizeof(file), "Data/Paredes/%d.ini", id);

	DOF2_CreateFile(file);
	DOF2_SetString(file,"Dono",Parede[id][Dono]);

	DOF2_SetFloat(file, "PosX", Parede[id][PosX]);
	DOF2_SetFloat(file, "PosY", Parede[id][PosY]);
	DOF2_SetFloat(file, "PosZ", Parede[id][PosZ]);
	DOF2_SetFloat(file, "RX", Parede[id][RX]);
	DOF2_SetFloat(file, "RY", Parede[id][RY]);
	DOF2_SetFloat(file, "RZ", Parede[id][RZ]);
	DOF2_SetInt(file, "Metal", Parede[id][metallife]);
	DOF2_SaveFile();
	return 1;
}

stock SalvarCaixa(id)
{
	new file[64];
  	format(file, sizeof(file), "Data/Caixas/%d.ini", id);

	DOF2_CreateFile(file);
	DOF2_SetString(file,"Dono",Caixa[id][Dono]);

	DOF2_SetFloat(file, "PosX", Caixa[id][PosX]);
	DOF2_SetFloat(file, "PosY", Caixa[id][PosY]);
	DOF2_SetFloat(file, "PosZ", Caixa[id][PosZ]);
	DOF2_SetFloat(file, "RX", Caixa[id][RX]);
	DOF2_SetFloat(file, "RY", Caixa[id][RY]);
	DOF2_SetFloat(file, "RZ", Caixa[id][RZ]);
	DOF2_SetBool(file, "aberta", Caixa[id][caberta]);
	DOF2_SetString(file,"Item1",Caixa[id][Item1]);
	DOF2_SetString(file,"Item2",Caixa[id][Item2]);
	DOF2_SetString(file,"Item3",Caixa[id][Item3]);
	DOF2_SetString(file,"Item4",Caixa[id][Item4]);
	DOF2_SetString(file,"Item5",Caixa[id][Item5]);
	DOF2_SetString(file,"Item6",Caixa[id][Item6]);
	DOF2_SetString(file,"Item7",Caixa[id][Item7]);
	DOF2_SetString(file,"Item8",Caixa[id][Item8]);
	DOF2_SaveFile();
	return 1;
}



stock pName(playerid)
{
    new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid,name,sizeof(name));
    for(new i = 0; i < MAX_PLAYER_NAME; i++)
    {
        if(name[i] == '_') name[i] = ' ';
    }
    return name;
}

forward pegandomadeira(playerid);
public pegandomadeira(playerid)
{
	SendClientMessage(playerid, azul, "{FFFF00}[>] {0080FF}Voce coletou {FFFF00}3 {0080FF}madeiras");
	ClearAnimations(playerid);
	natora[playerid] = false;
	pInfo[playerid][pMadeira] +=3;
	return 1;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == PublicTD6[6])
	{
    	format(arquivo, sizeof(arquivo), ContaSalva, pName2(playerid));
		if(!DOF2_FileExists(arquivo))
		{
	    	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_PASSWORD, "Registrando a sua conta", "Digite uma senha para criar uma conta ( UTILIZE APENAS NUMEROS )", "Registrar", "sair");
		}
		else
		{
	    	ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "Voce ja possui uma conta", "Voce ja possui uma conta, digite sua para poder logar", "Logar", "sair");
		}
        for(new i = 0; i < 11; i++) { TextDrawHideForPlayer(playerid, PublicTD6[i]); }
        CancelSelectTextDraw(playerid);
	}
	if(clickedid == PublicTD6[8])
	{
	    ShowPlayerDialog(playerid, 99, DIALOG_STYLE_MSGBOX, "{FFFF00}Creditos", "{51A8FF}Fundador & Scripter: {FFFFFF}JoaoGhost\n{51A8FF}Mapper: {FFFFFF}JoaoGhost\n{51A8FF}Staffs: {FFFFFF}Icce | Bruno | Hazer | Pato | Walker |\n{FFFF00}https://discord.gg/DqAkjUd", "Fechar", #);
	}
	if(clickedid == PublicTD6[9])
	{
	    ShowPlayerDialog(playerid, 98, DIALOG_STYLE_MSGBOX, "{FFFF00}Discord", "{51A8FF}Discord: {FFFFFF}https://discord.gg/DqAkjUd", "Fechar", #);
	}
	return 1;
}

forward Curandocura(playerid);
public Curandocura(playerid)
{
	ClearAnimations(playerid);
	SetPlayerHealth(playerid, 100);
	GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~Curado",1000,3);
	return 1;
}

forward Curandocura2(playerid);
public Curandocura2(playerid)
{
	ClearAnimations(playerid);
	GetPlayerHealth(playerid, vida32[playerid]);
	SetPlayerHealth(playerid, vida32[playerid]+20);
	GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~Curado",1000,3);
	return 1;
}

forward Platandobomba(playerid);
public Platandobomba(playerid)
{
	new id = idparedebomb[playerid];
	ClearAnimations(playerid);
	TogglePlayerControllable(playerid, 1);
	GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~r~~h~Saia de perto!",1000,3);
	objetoc4[playerid] = CreateObject(1252, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 0, 0, 0);
	SetTimerEx( "Explodindobomba", 5000, false, "i", playerid);
	return 1;
}

forward Explodindobomba(playerid);
public Explodindobomba(playerid)
{
	new id = idparedebomb[playerid];
    CreateExplosion(Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 6, 10);
    if(Parede[id][metallife] == 0)
    {
    	DestroyObject(Parede[id][ObjectJ]);
    	DestroyObject(objetoc4[playerid]);
    	Parede[id][Existe] = 0;
    	Parede[id][PosX] = 0;
    	Parede[id][PosY] = 0;
    	Parede[id][PosZ] = 0;
    	Parede[id][RX] = 0;
    	Parede[id][RY] = 0;
    	Parede[id][RZ] = 0;
		new file[64];
		format(file, sizeof(file), "Data/Paredes/%d.ini", id);
		if(DOF2_FileExists(file))
		{
			DOF2_RemoveFile(file);
		}
	}
	else
	{
		Parede[id][metallife]--;
		DestroyObject(objetoc4[playerid]);
	}
	return 1;
}

stock minrand(min, max) //By Alex "******" Cole
{
    return random(max - min) + min;
}

stock ProxDetector(Float:radi, playerid, string[],color)
{
    new Float:x,Float:y,Float:z;
    GetPlayerPos(playerid,x,y,z);
    foreach(Player,i)
    {
        if(IsPlayerInRangeOfPoint(i,radi,x,y,z))
        {
            SendClientMessage(i,color,string);
        }
    }
}

stock ShowInventoryTent(playerid)
{
    if(!IsPlayerNPC(playerid))
    {
		gItemList="";
		for(new item;item<MAX_ITEMS;item++)
		{
			if(!strlen(_GetItemNamePVar(playerid,item))||!_GetItemAmountPVar(playerid,item))continue;
			format(gItemList,sizeof(gItemList),"%s\n%d\t\t%s",gItemList,_GetItemAmountPVar(playerid,item),_GetItemNamePVar(playerid,item));
		}
		format(gItemList,sizeof(gItemList),"%s",gItemList);
		ShowPlayerDialog(playerid,DIALOG_TENT_VIEW_S2,DIALOG_STYLE_LIST,""COL_GREEN"Caixa (8 SLOTS)",gItemList,"Add Item","Fechar");
	}
	return 1;
}

stock AddSlotToInventoryWorld(playerid,addItem[],amount)
{
    if(pInfo[playerid][pSlots] == pInfo[playerid][pBackpack]) return GameTextForPlayer(playerid,"~r~Mochila cheia",1000,4);
	AddItem(playerid,addItem,amount);
	return 1;
}

stock RemoveSlotToInventory(playerid,addItem[],amount)
{
	RemoveItem(playerid,addItem,amount);
	return 1;
}

forward spawnando(playerid);
public spawnando(playerid)
{
	SpawnPlayer(playerid);
	return 1;
}

forward delaymsg(playerid);
public delaymsg(playerid)
{
	msglog[playerid] = false;
	return 1;
}
