/*CMD:creditos(playerid, params[])
{
	ShowPlayerDialog(playerid, 99, DIALOG_STYLE_MSGBOX, "{FFFF00}Creditos", "{51A8FF}Scripters: {FFFFFF}JoaoGhost | heyboy\n{51A8FF}Mappers: {FFFFFF}JoaoGhost | Chockyto\n{FFFF00}Discord: {FFFFFF}https://discord.gg/MkPsAQ4", "Fechar", #);
	return 1;
}*/
CMD:editarparede(playerid, params[])
{
    new id;
    if(sscanf(params, "d", id)) return SendClientMessage(playerid, COR_AMARELO, "[Dica] Use /editarparede [ID DA PAREDE]");
    if(strcmp(Parede[id][Dono], pName(playerid))) return SendClientMessage(playerid, -1, "{E80000}[ERRO] Esta parede nao e sua!");
 	ideditorp[playerid] = id;
	ShowPlayerDialog(playerid, 310, DIALOG_STYLE_LIST, "Editor Teste 1.1.0", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
	return 1;
}
CMD:editarporta(playerid, params[])
{
    new id;
    if(sscanf(params, "d", id)) return SendClientMessage(playerid, COR_AMARELO, "[Dica] Use /editarporta [ID DA PORTA]");
    if(strcmp(Porta[id][Dono], pName(playerid))) return SendClientMessage(playerid, -1, "{E80000}[ERRO] Esta porta nao e sua!");
	ideditorp[playerid] = id;
	ShowPlayerDialog(playerid, 310, DIALOG_STYLE_LIST, "Editor Teste 1.1.0", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
	return 1;
}
CMD:engine(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: voce nao esta dirigindo um veiculo.");
	if(!IsABike(vehicleid))
	{
		if(vInfo[vehicleid][vCombustivel] == 0)
		return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Sem combustivel.");
		if(vInfo[vehicleid][vTemMotor] == false)
		return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Este veiculo nao tem motor.");

		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

		if(vInfo[vehicleid][vMotor] == false)
		{
			vInfo[vehicleid][vMotor] = true;
			GameTextForPlayer(playerid, "~w~MOTOR: ~g~ ON!", 1000, 3);
			SetVehicleParamsEx(vehicleid, 1, lights, alarm, doors, bonnet, boot, objective);
		}
		else if(vInfo[vehicleid][vMotor] == true)
		{
			vInfo[vehicleid][vMotor] = false;
			GameTextForPlayer(playerid, "~w~MOTOR: ~r~ OFF!", 1000, 3);
			SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective);
		}
	}
	return 1;
}
CMD:blockpm(playerid, params[])
{
	if(pInfo[playerid][pBlockPM] == true)
	{
		pInfo[playerid][pBlockPM] = false;
		GameTextForPlayer(playerid, "~w~Mensagem Privada: ~g~Ativado!", 5000, 3);
	}
	else if(pInfo[playerid][pBlockPM] == false)
	{
		pInfo[playerid][pBlockPM] = true;
		GameTextForPlayer(playerid, "~w~Mensagem Privada: ~r~Desativado!", 5000, 3);
	}
	return 1;
}
CMD:pm(playerid, params[])
{
	new str[128], msg[72];
	if(sscanf(params, "is[72]", params[0], msg)) return SendClientMessage(playerid, COR_CINZA, "Use: /pm  [player] [mensagem]");
	if(params[0] == playerid) return SendClientMessage(playerid, COR_VERMELHO, "[ERROR]: Voce nao pode usar este comando em voce mesmo.");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, COR_VERMELHO, "[ERROR]: Jogador nao encontrado.");
	if(pInfo[params[0]][pBlockPM] == true) return SendClientMessage(playerid, COR_VERMELHO, "[ERROR]: Este jogador desativou mensagens privadas.");
	if(strlen(msg) > 70) return SendClientMessage(playerid, COR_VERMELHO, "[ERROR]: Limite de mensagem ï¿½ 70 characteres.");

    format(str, sizeof(str), "[>] Enviou para: %s(%i): %s", PegarNome(params[0]), params[0], msg);
    SendClientMessage(playerid, 0xD4C342FF, str);
    format(str, sizeof(str), "[<] Recebeu de: %s(%i): %s", PegarNome(playerid), playerid, msg);
    SendClientMessage(params[0], 0xF2D811FF, str);
	return 1;
}
CMD:g(playerid, params[])
{
    if(msglog[playerid] == true) return SendClientMessage(playerid, -1, "Aguarde 5s para enviar outra mensagem");
    if(cadeiaadm[playerid] == 1) return SendClientMessage(playerid, -1, "voce esta preso!");
    new Str[200], Name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, Name, sizeof Name);
	if(pInfo[playerid][pVip] == 1)
	{
 		format(Str, sizeof Str, "{408080}[Chat Global]{FFFF00}|VIP| {C0C0C0}%s (id:%d): {FFFFFF}%s", Name, playerid, params);
    	SendClientMessageToAll(-1, Str);
 		SetTimerEx( "delaymsg", 5000, false, "i", playerid);
		msglog[playerid] = true;
		return true;
	}
    format(Str, sizeof Str, "{408080}[Chat Global] {C0C0C0}%s (id:%d): {FFFFFF}%s", Name, playerid, params);
    SendClientMessageToAll(-1, Str);
	SetTimerEx( "delaymsg", 5000, false, "i", playerid);
	msglog[playerid] = true;
    return true;
}
CMD:crafts(playerid)
{
    ShowPlayerDialog(playerid, 67, DIALOG_STYLE_LIST, "Crafts", "{76CA6C}Defesas\n{76CA6C}Maquinas\n{76CA6C}Itens\n{76CA6C}Bancadas", "Selecionar", "Fechar");
	return 1;
}
CMD:criarparede(playerid, params[])
{
	if(pInfo[playerid][pMadeira] < 45) return SendClientMessage(playerid, -1, "[!] Voce nao possui madeiras suficientes");
	if(permitidoparede == false) return SendClientMessage(playerid, COR_VERMELHO, "[AntiBug] Aguarde alguns segundos, alguem ja esta construindo uma parede");
	pInfo[playerid][pMadeira] -=45;
	new id = -1;
	new str[60];
	for(new i; i < MAX_PAREDE; i++)
	{
		if(!Parede[i][Existe])
		{
			id = i;
			break;
		}
	}
	new Float:X, Float:Y, Float:Z, Float: A;
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, A);

    format(Parede[id][Dono], 24,"%s",pName2(playerid));
	Parede[id][Existe] = 1;
	Parede[id][PosX] = X+2;
	Parede[id][PosY] = Y;
	Parede[id][PosZ] = Z+0.5;
	Parede[id][RZ] = A+90;
	Parede[id][metallife] = 5;
	Parede[id][upgrade] = 1;
	SetPlayerPos(playerid, X+0.1, Y, Z);
	Parede[id][ObjectJ] = CreateDynamicObject(19360, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], Parede[id][RX], Parede[id][RY], Parede[id][RZ]);
	SendClientMessage(playerid, azul, "Parede construida com sucesso, use /editarparede [id] para editar");
	format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Parede[id][metallife]);
	Parede[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 10.0, 0, 0);
	SalvarParede(id);
	permitidoparede = false;
	SetTimer("parededelaY", 30000, false);
	ideditorp[playerid] = id;
	ShowPlayerDialog(playerid, 310, DIALOG_STYLE_LIST, "Editor Teste 1.1.1", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");

	return 1;
}
CMD:criarporta(playerid, params[])
{
	if(pInfo[playerid][pMadeira] < 30) return SendClientMessage(playerid, -1, "[!] Voce nao possui madeiras suficientes");
	if(!PlayerHasItem(playerid, "Martelo")) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao possui um martelo");
	if(permitidoparede == false) return SendClientMessage(playerid, COR_VERMELHO, "[AntiBug] Aguarde alguns segundos, alguem ja esta construindo");
	pInfo[playerid][pMadeira] -=30;
	new id = -1;
	new str[60];
	for(new i; i < MAX_PORTA; i++)
	{
		if(!Porta[i][Existe])
		{
			id = i;
			break;
		}
	}
	new Float:X, Float:Y, Float:Z, Float: A;
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, A);

    format(Porta[id][Dono], 24,"%s",pName2(playerid));
	Porta[id][Existe] = 1;
	Porta[id][PosX] = X+1;
	Porta[id][PosY] = Y;
	Porta[id][PosZ] = Z-0.5;
	Porta[id][RZ] = A+90;
	Porta[id][metallife] = 5;
	Porta[id][upgrade] = 1;
	SetPlayerPos(playerid, X+0.1, Y, Z);
	Porta[id][ObjectP] = CreateDynamicObject(1497, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], Porta[id][RX], Porta[id][RY], Porta[id][RZ]);
	SendClientMessage(playerid, azul, "Porta construida com sucesso, use /editarporta [id] para editar");
	format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Porta[id][metallife]);
	Porta[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], 10.0, 0, 0);
	SalvarParede(id);
	permitidoparede = false;
	SetTimer("parededelaY", 30000, false);
	idporta[playerid] = id;
	return 1;
}
CMD:criarcraft(playerid, params[])
{
	if(pInfo[playerid][pMadeira] < 30) return SendClientMessage(playerid, -1, "[!] Voce nao possui madeiras suficientes");
    if(!PlayerHasItem(playerid, "Martelo")) return SendClientMessage(playerid, -1, "[!] Voce nao possui um martelo");
    pInfo[playerid][pMadeira] -=30;
	new id = -1;
	new str[60];
	for(new i; i < MAX_CRAFT; i++)
	{
		if(!Craft[i][Existe])
		{
			id = i;
			break;
		}
	}
	new Float:X, Float:Y, Float:Z, Float: A;
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, A);

    format(Craft[id][Dono], 24,"%s",pName2(playerid));
	Craft[id][Existe] = 1;
	Craft[id][PosX] = X;
	Craft[id][PosY] = Y;
	Craft[id][PosZ] = Z;
	Craft[id][RZ] = A;
	Craft[id][ObjectT] = CreateDynamicObject(936, Craft[id][PosX], Craft[id][PosY], Craft[id][PosZ]-0.5, Craft[id][RX], Craft[id][RY], Craft[id][RZ]+90);
	SetPlayerPos(playerid, X+1, Y, Z);
	SendClientMessage(playerid, azul, "Mesa de trabalho construida com sucesso");
	format(str, 60, "ID:{0080C0} %d",id);
	Craft[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Craft[id][PosX], Craft[id][PosY], Craft[id][PosZ], 10.0, 0, 0);
	SalvarCraft(id);
	return 1;
}
/*CMD:criargrupo(playerid)
{
	grupoid++;
	grupoplayer[playerid] = grupoid;
	SendClientMessage(playerid, -1, "Grupo criado! use /convidar");
	return 1;
}*/
CMD:convidar(playerid, params[])
{
	new id;
	new str[50];
	new id2 = grupoplayer[playerid];
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "[ERRO] Use: /convidar [ID]");
	if(grupoplayer[id] > 0) return SendClientMessage(playerid,COR_VERMELHO, "[ERRO] Voce nao esta em nenhum grupo");
	SendClientMessage(playerid, COR_AMARELO, "[INFO] Voce convidou este jogador com sucesso!");
	format(str, sizeof(str), "Voce entrou no grupo de %s", pName2(playerid));
	SendClientMessage(id, -1, str);
	grupoplayer[id] = id2;
	return 1;
}
CMD:sairgrupo(playerid)
{
	if(grupoplayer[playerid] <= 0) return SendClientMessage(playerid,COR_VERMELHO, "[ERRO] Voce nao esta em nenhum grupo");
	grupoplayer[playerid] = 0;
	SendClientMessage(playerid, -1, "[INFO] Voce saiu do grupo");
	return 1;
}
CMD:cmds(playerid)
{
	ShowPlayerDialog(playerid, 564, DIALOG_STYLE_MSGBOX, "Comandos", "COMANDOS DO SERVIDOR\n/criargrupo - Para criar um grupo\n/Convidar - Para convidar alguem ao seu grupo\n/sairgrupo - Para sair de algum grupo\n/pm - Manda uma Msg privada ï¿½ alguï¿½m\n/blockpm - bloqueia mensagens privadas\n/galao - enche o tanque de um veiculo\n/motor - coloca motor em um veiculo\n/engine - Liga/Desliga um veiculo\n/Crafts - Exibe a lista de crafts\n/g - fala no chat global\n/modsoff - sincroniza os objetos no corpo\n/c chat do grupo\n/caixa abre uma caixa proxima\n/criarcraft - Cria uma mesa de trabalho\n/craft - Exibe os crafts da mesa de trabalho\n/duvida - manda uma duvida a staff\n/abrir - abre uma parede\n/fechar - fecha uma parede\n/Rea - reanima um jogador\n/criarcaixa - cria uma caixa\n/criarparede - cria uma parede\n/editarparede - edita uma parede\n/ceditor - fecha o editor\nY = Inventario\nF = Pega Loot\nN = Pega Madeira\n", "Fechar", #);
	return 1;
}
CMD:removerfogueira(playerid)
{
	fogueiraplayer[playerid] = 0;
	DestroyObject(objfogueira[playerid]);
	SendClientMessage(playerid, -1, "Fogueira Removida");
	return 1;
}
CMD:forcelogin(playerid)
{
	if(pInfo[playerid][pConectado] == true) return SendClientMessage(playerid, -1, "Voce ja esta logado");
	antibug(playerid);
    new query[61], DBResult:Result;
	//new Dialog[120];
    format(query, sizeof(query), "SELECT * FROM `contas` WHERE `nome`='%s'", DB_Escape(GetName(playerid)));
    Result = db_query(Connect, query);

    if(db_num_rows(Result) == 0)
    {
        	//N?o tem uma conta..
    	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_PASSWORD, "Registrando a sua conta", "Digite uma senha para criar uma conta ( UTILIZE APENAS NUMEROS )", "Registrar", "sair");
	}
    else
    {
        	//Tem uma conta..
        ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "Voce ja possui uma conta", "Voce ja possui uma conta, digite sua para poder logar", "Logar", "sair");
    }
    db_free_result(Result);
    return 1;
}
CMD:modsoff(playerid)
{
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
CMD:c(playerid, params[])
{
	new text[128];
	new str[128];
	//new player = grupoplayer[playerid];
	new name[30];
	GetPlayerName(playerid, name, sizeof(name));
	if(sscanf(params, "s[128]", text)) return SendClientMessage(playerid, -1, "Use: /c [Texto]");
	if(grupoplayer[playerid] == 0) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta em um grupo");
	if(pInfo[playerid][pConectado] == true)
	{
		foreach(new i : Player)
		{
		    if(pInfo[i][pConectado] == true && IsPlayerConnected(i))
		    {
	    		if(grupoplayer[i] == grupoplayer[playerid])
	    		{
					format(str, 128, "{00FF00}[GRUPO]{C0C0C0}%s: {FFFFFF}%s", name, text);
					SendClientMessage(i, -1, str);
				}
			}
		}
	}
	else return 0;
	return true;
}
CMD:duvida(playerid, params[])
{
    new msg[128];
    new str[128];
	if(sscanf(params, "s[72]", msg)) return SendClientMessage(playerid, COR_CINZA, "Use: /a [msg]");
	if(strlen(msg) > 70) return SendClientMessage(playerid, COR_VERMELHO, "[ERROR]: O limite de mensagens e de 70 caracteres.");
	format(str, sizeof(str), "{40BF50}Duvida: {FFFFFF}%s (ID:%d): {C0C0C0}%s", pName2(playerid), playerid, msg);
	MensageAdmin(0xFF80C0FF, str);
	return true;
}
CMD:report(playerid, params[])
{
    new msg[72];
    new str[300];
    new id;
	if(sscanf(params, "ds[72]", id, msg)) return SendClientMessage(playerid, COR_CINZA, "Use: /report [id] [motivo]");
	if(strlen(msg) > 70) return SendClientMessage(playerid, COR_VERMELHO, "[ERROR]: O limite de mensagens e de 70 caracteres.");
	format(str, sizeof(str), "{FF2424}Denuncia: {FFFFFF}%s{FF2424} Denunciou o jogador{FFFFFF} %s{FF2424} ID:%d{FF2424}| Motivo:{FFFFFF}%s", pName2(playerid),pName2(id), id, msg);
	MensageAdmin(0xFF80C0FF, str);
	return true;
}
CMD:craft(playerid)
{
	new id = GetPlayerRangeCraft(playerid);
	if(id == -1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta proximo de uma mesa de trabalho");
	ShowPlayerDialog(playerid, 45, DIALOG_STYLE_LIST, "Mesa de Trabalho", "{3EBB47}TNT Cronometrada\n{3EBB47}Fogueira\n{3EBB47}Pano\n{3EBB47}Molotov", "Proximo", "Cancelar");
	return 1;
}

CMD:caixa(playerid, params[])
{
	new id = GetPlayerRangeCaixa(playerid);
	if(strcmp(Caixa[id][Dono], PegarNome(playerid)))
	{
	    if(Caixa[id][caberta] == false) return SendClientMessage(playerid, -1, "{E80000}[ANTICHEAT] Esta Caixa esta bloqueada, peï¿½a um admin para desbloquear.");
    	idcaixap[playerid] = id;
		new str[364];
		format(str,sizeof(str),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",
		Caixa[id][Item1],
		Caixa[id][Item2],
		Caixa[id][Item3],
		Caixa[id][Item4],
		Caixa[id][Item5],
		Caixa[id][Item6],
		Caixa[id][Item7],
		Caixa[id][Item8]);

		ShowPlayerDialog(playerid,DIALOG_TENT_VIEW,DIALOG_STYLE_LIST,"Caixa"COL_GREEN" (8 SLOTS)",str,"Selecionar","Fechar");
		return true;
	}
    idcaixap[playerid] = id;
	new str[364];
	format(str,sizeof(str),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",
	Caixa[id][Item1],
	Caixa[id][Item2],
	Caixa[id][Item3],
	Caixa[id][Item4],
	Caixa[id][Item5],
	Caixa[id][Item6],
	Caixa[id][Item7],
	Caixa[id][Item8]);

	ShowPlayerDialog(playerid,DIALOG_TENT_VIEW,DIALOG_STYLE_LIST,"Caixa"COL_GREEN" (8 SLOTS)",str,"Selecionar","Fechar");
	return 1;
}
CMD:criarcaixa(playerid, params[])
{
	if(pInfo[playerid][pMadeira] < 35) return SendClientMessage(playerid, -1, "[!] Voce nao tem madeiras suficientes");
	if(permitidocaixa == false) return SendClientMessage(playerid, COR_VERMELHO, "[AntiBug] Aguarde alguns segundos, alguem ja esta construindo uma caixa");
	pInfo[playerid][pMadeira] -=35;
	new id = -1;
	new str[60];
	new strv[64];
	for(new i; i < MAX_CAIXA; i++)
	{
		if(!Caixa[i][Existe])
		{
			id = i;
			break;
		}
	}
	new Float:X, Float:Y, Float:Z, Float: A;
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, A);

    format(Caixa[id][Dono], 24,"%s",pName2(playerid));
    format(strv,sizeof(strv),"<Slot Vazio>");
	Caixa[id][Existe] = 1;
	Caixa[id][PosX] = X;
	Caixa[id][PosY] = Y;
	Caixa[id][PosZ] = Z;
	Caixa[id][RZ] = A;
	Caixa[id][Item1] = strv;
	Caixa[id][Item2] = strv;
	Caixa[id][Item3] = strv;
	Caixa[id][Item4] = strv;
	Caixa[id][Item5] = strv;
	Caixa[id][Item6] = strv;
	Caixa[id][Item7] = strv;
	Caixa[id][Item8] = strv;
	Caixa[id][ObjectC] = CreateDynamicObject(1271, Caixa[id][PosX]+0.5, Caixa[id][PosY], Caixa[id][PosZ]-0.6, Caixa[id][RX], Caixa[id][RY], Caixa[id][RZ]);
	SendClientMessage(playerid, azul, "Caixa construida com sucesso");
	permitidocaixa = false;
	format(str, 60, "ID:{0080C0} %d",id);
	Create3DTextLabel(str, 0xFFFF00FF, Caixa[id][PosX], Caixa[id][PosY], Caixa[id][PosZ], 10.0, 0, 0);
	SalvarCaixa(id);
	SetTimer( "caixadelay", 30000, false);
	return 1;
}
CMD:reparo(playerid, params[])
{
    if(!PlayerHasItem(playerid, "Toolbox")) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao possui uma ToolBox");
	new vehicleid = GetPlayerVehicleID(playerid);
	RepairVehicle(vehicleid);
	RemoveItem(playerid, "Toolbox", 1);
	SendClientMessage(playerid, COR_AMARELO, "[ INFO ] Veiculo reparado.");
	return 1;
}
CMD:vergrupo(playerid)
{
	new str[128];
	format(str, sizeof(str), "Seu id de grupo %d", avisadofrio[playerid]);
	SendClientMessage(playerid, -1, str);
	return 1;
}
CMD:frio(playerid)
{
	avisadofrio[playerid] = 1;
	return 1;
}
CMD:abrir(playerid, params[])
{
    new id = GetPlayerRangePorta(playerid);
    if(id == -1) return SendClientMessage(playerid, COR_VERMELHO, "Voce nao esta proximo de nenhuma porta");
    if(strcmp(Porta[id][Dono], pName(playerid))) return SendClientMessage(playerid, -1, "{E80000}[ERRO] Esta porta nao e sua!");
	{
        if(strcmp(Porta[id][Dono], PegarNome(playerid)))
		idporta[playerid] = id;
		DestroyDynamicObject(Porta[id][ObjectP]);
		GameTextForPlayer(playerid, "~b~Porta aberta!", 2400, 3);
	}
	return 1;
}
CMD:madeiras(playerid)
{
	new str[60];
	format(str, sizeof(str), "{FFFF00}[>]{48A4FF}Voce possui {FFFF00}%d {48A4FF}Madeiras", pInfo[playerid][pMadeira]);
	SendClientMessage(playerid, -1, str);
	return 1;
}
CMD:fechar(playerid, params[])
{
    new id = GetPlayerRangePorta(playerid);
    if(id == -1) return SendClientMessage(playerid, COR_VERMELHO, "Voce nao esta proximo de nenhuma porta");
    if(strcmp(Porta[id][Dono], pName(playerid))) return SendClientMessage(playerid, -1, "{E80000}[ERRO] Esta porta nao e sua!");
    {
        Porta[id][ObjectP] = CreateDynamicObject(1497, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], Porta[id][RX], Porta[id][RY], Porta[id][RZ]);
        if(strcmp(Porta[id][Dono], PegarNome(playerid))){
		}
     }
    return 1;
}
/*CMD:guardar(playerid)
{
	SendClientMessage(playerid, -1, "desativado");
	return 1;
}*/
CMD:rea(playerid, params[])
{
 	new id;
 	if(jarilando[playerid] == 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce ja esta curando alguem");
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, COR_AMARELO, "Use: /rea [ID do jogador]");
	if(playerid == id) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando em voce.");
	if(caido[id] == false) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Este jogador nao esta caido");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COR_VERMELHO, "[ERROR]: Jogador nao encontrado.");
	if(GetDistanceBetweenPlayers(playerid, id) > 2) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Chegue mais perto");
	timerrilando[playerid] = SetTimerEx( "rilandoamigo", 500, true, "i", playerid);
	ApplyAnimation(playerid,"MEDIC","CPR",4.0,0,0,0,0,0);
	jarilando[playerid] = 1;
	iddorilado = id;
	return 1;
}
CMD:galao(playerid)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    if(!PlayerHasItem(playerid, "Galao de combustivel")) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao possui um galao");
	    new vehicleid = GetPlayerVehicleID(playerid);
		vInfo[vehicleid][vCombustivel] += 20;
		RemoveItem(playerid, "Galao de combustivel", 1);
		AddItem(playerid, "Galao vazio", 1);
		SendClientMessage(playerid, -1, "Voce colocou 20L de gasolina");
	}
    else return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta dentro de um veiculo");
    return 1;
}
CMD:motor(playerid)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if(!PlayerHasItem(playerid, "Motor")) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao possui um motor");
        new vehicleid = GetPlayerVehicleID(playerid);
        vInfo[vehicleid][vTemMotor] = true;
		RemoveItem(playerid, "Motor", 1);
		SendClientMessage(playerid, -1, "Voce colocou um motor neste veiculo");
	}
	else return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta dentro de um veiculo");
	return 1;
}
CMD:trade(playerid, params[])
{	
	if(!IsPlayerInRangeOfPoint(playerid, 2.0, -386.9058,-1148.4536,69.3862)) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao esta proximo do local de compras.");
	{
		ShowPlayerDialog(playerid, Suprimentos, DIALOG_STYLE_LIST, "Suprimentos", "Moto-serra     {33AA33}$120\nToolbox     {33AA33}$150\nMotor     {33AA33}$420\nColete     {33AA33}$620\nMochila de caca     {33AA33}$230\nMartelo     {33AA33}$90\nRoupa     {33AA33}$70\nFaca Ak-47     {33AA33}$350\nMP5-K     {33AA33}$1300", "Comprar", "Cancelar");
	}	
	return 1;
}
/*CMD:mudarsenha(playerid, params[]){
	new senha[60], Querya[60], str[128];
	new DBResult:Resulta;
	if(pInfo[playerid][pConectado] == false) return SendClientMessage(playerid, COR_VERMELHO, "Voce nao esta logado!");
	if(sscanf(params, "s[60]", senha)) return SendClientMessage(playerid, COR_VERMELHO, "Uso: /mudarsenha [senha]");
	format(Querya, sizeof Querya, "UPDATE `contas` SET senha = '%s'", senha);
	Resulta = db_query(Connect, Querya);
	db_free_result(Resulta);
	format(str, sizeof str, "Sua nova senha e: %s", senha);
	SendClientMessage(playerid, azul, str);
	return 1;
}*/