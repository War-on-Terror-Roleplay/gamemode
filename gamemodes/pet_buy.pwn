CMD:comprarpet(playerid,params[])
{
    if(!PlayerInfo[playerid][pLogado]) return SendClientMessage(playerid,COLOR_LIGHTRED, "ERRO:{FFFFFF} Você não está logado!");

	if(PlayerInfo[playerid][pDoador] <= 2)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você não possui premium ouro ativo.");

	{
	   	if (IsPlayerInRangeOfPoint(playerid, 5, 1096.8484,-1528.9009,22.7434))
			Dialog_Show(playerid, Dialog_PETSHOP, DIALOG_STYLE_TABLIST_HEADERS, "PETSHOP", "Produto\tPreço\nDOGUINHO 01\tUS$3870\nDOGUINHO 02\tUS$3870\nDOGUINHO 03\tUS$3870\n \
            \nDOGUINHO 04\tUS$3870\nDOGUINHO 05\tUS$3870\nDOGUINHO 06\tUS$3870\nDOGUINHO 07\tUS$3870\nCamelo\tUS$8000", "Selecionar", "Voltar");
		else {
  			SetPlayerCheckpoint(playerid, 1096.8484,-1528.9009,22.7434, 5.0);
			cp_target[playerid] = 1;
			SendClientMessage(playerid, COLOR_LIGHTRED, "Você não está no petshop.");
			return 1;
		}
	}
    return 1;
}

Dialog:Dialog_PETSHOP(playerid, response, listitem, inputtext[])
{
	if(!response) return 1;
	else
	{
		switch(listitem)
		{
		    case 0:
		    {
		        if(PlayerInfo[playerid][pGrana] >= 3870)
				{
					PlayerInfo[playerid][pPecasMecanicas][0]++;
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Você comprou um DOG X por US$3870.");
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Use /petmenu.");
					PlayerInfo[playerid][pGrana] = PlayerInfo[playerid][pGrana]-3870;
                    PetData[targetid][petModelID] = 20069;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem dinheiro o suficiente.");
			}
		    case 1:
		    {
		        if(PlayerInfo[playerid][pGrana] >= 3870)
				{
					PlayerInfo[playerid][pPecasMecanicas][0]++;
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Você comprou um DOG X por US$3870.");
                    SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Use /petmenu.");
					PlayerInfo[playerid][pGrana] = PlayerInfo[playerid][pGrana]-3870;
                    PetData[targetid][petModelID] = 20070;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem dinheiro o suficiente.");
			}
		    case 2:
		    {
		        if(PlayerInfo[playerid][pGrana] >= 3870)
				{
					PlayerInfo[playerid][pPecasMecanicas][0]++;
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Você comprou um DOG X por US$3870.");
                    SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Use /petmenu.");
					PlayerInfo[playerid][pGrana] = PlayerInfo[playerid][pGrana]-3870;
                    PetData[targetid][petModelID] = 20071;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem dinheiro o suficiente.");
			}
		    case 3:
		    {
		        if(PlayerInfo[playerid][pGrana] >= 3870)
				{
					PlayerInfo[playerid][pPecasMecanicas][0]++;
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Você comprou um DOG X por US$3870.");
                    SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Use /petmenu.");
					PlayerInfo[playerid][pGrana] = PlayerInfo[playerid][pGrana]-3870;
                    PetData[targetid][petModelID] = 20072;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem dinheiro o suficiente.");
			}
		    case 4:
		    {
		        if(PlayerInfo[playerid][pGrana] >= 3870)
				{
					PlayerInfo[playerid][pPecasMecanicas][0]++;
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Você comprou um DOG X por US$3870.");
                    SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Use /petmenu.");
					PlayerInfo[playerid][pGrana] = PlayerInfo[playerid][pGrana]-3870;
                    PetData[targetid][petModelID] = 20073;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem dinheiro o suficiente.");
			}
		    case 5:
		    {
		        if(PlayerInfo[playerid][pGrana] >= 3870)
				{
					PlayerInfo[playerid][pPecasMecanicas][0]++;
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Você comprou um DOG X por US$3870.");
                    SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Use /petmenu.");
					PlayerInfo[playerid][pGrana] = PlayerInfo[playerid][pGrana]-3870;
                    PetData[targetid][petModelID] = 20074;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem dinheiro o suficiente.");
			}
		    case 6:
		    {
		        if(PlayerInfo[playerid][pGrana] >= 3870)
				{
					PlayerInfo[playerid][pPecasMecanicas][0]++;
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Você comprou um DOG X por US$3870.");
                    SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Use /petmenu.");
					PlayerInfo[playerid][pGrana] = PlayerInfo[playerid][pGrana]-3870;
                    PetData[targetid][petModelID] = 20075;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem dinheiro o suficiente.");
			}
		    case 7:
		    {
		        if(PlayerInfo[playerid][pGrana] >= 3870)
				{
					PlayerInfo[playerid][pPecasMecanicas][0]++;
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Você comprou um DOG X por US$3870.");
                    SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Use /petmenu.");
					PlayerInfo[playerid][pGrana] = PlayerInfo[playerid][pGrana]-3870;
                    PetData[targetid][petModelID] = 20076;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem dinheiro o suficiente.");
			}
		    case 8:
		    {
		        if(PlayerInfo[playerid][pGrana] >= 8000)
				{
					PlayerInfo[playerid][pPecasMecanicas][0]++;
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Você comprou um camelo por US$8000.");
                    SendClientMessage(playerid, COLOR_LIGHTGREEN, "[PETSHOP] Use /petmenu.");
					PlayerInfo[playerid][pGrana] = PlayerInfo[playerid][pGrana]-8000;
                    PetData[targetid][petModelID] = 20077;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem dinheiro o suficiente.");
			}
		}
	}
	return 1;
}
