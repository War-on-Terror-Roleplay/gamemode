	else if(IsPlayerInRangeOfPoint(playerid, 5, 2532.0464,-1916.4795,13.5480))
	{
        if(PlayerInfo[playerid][pDoador] <= 2)
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO: Você não possui premium ouro ativo.");
        {
	        Dialog_Show(playerid, DIALOGPETSHOP, DIALOG_STYLE_TABLIST_HEADERS, "JOALHERIA", "Produto\tPreço\nRelógios", "Selecionar", "Cancelar");
        }
    }

Dialog:DIALOGPETSHOP(playerid, response, listitem, inputtext[])
{
	if(!response) return 1;
	else
	{
		switch(listitem)
		{
		    case 0:
		    {
		        if(PlayerInfo[playerid][pGrana] >= 1200)
				{
		 		    PlayerPlaySound(playerid,1054, 0.0, 0.0, 0.0);
		 		    ApplyAnimation(playerid,"DEALER","shop_pay",3.0,0,0,0,0,0,1);

					PlayerInfo[playerid][pGrana] = PlayerInfo[playerid][pGrana]-1200;
					PetData[playerid][petModelID] == ;
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "Você não tem dinheiro o suficiente.");
			}
		}
	}
	return 1;
}