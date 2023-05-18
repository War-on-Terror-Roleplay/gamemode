/* =======================================

Sistema de Inventario criado por Joe_Staff e Editado por JPedro

> http://forum.sa-mp.com/showthread.php?t=130436 <

========================================== */

// # Definicoes #

#define MAX_ITEM_STACK (99)
#define MAX_INV_ITEMS (99)

// # Variaveis #

new gItemList[(MAX_INV_ITEMS+1)*(MAX_ITEM_NAME+3)];
new gItemSelected[MAX_PLAYERS][MAX_ITEM_NAME];
//new gItemSelected2[MAX_PLAYERS][MAX_ITEM_NAME];

// # Forwards #

forward INV_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);

// # stocks e callbacks #

stock _GetItemNamePVar(playerid,item)
{
	new tmp[32];
	new tmp2[MAX_ITEM_NAME];
	format(tmp,32,"PITEMNAME%d",item);
	GetPVarString(playerid,tmp,tmp2,MAX_ITEM_NAME);
	return tmp2;
}

stock _SetItemNamePVar(playerid,item,ItemName[])
{
	new tmp[MAX_ITEM_NAME];
	format(tmp,MAX_ITEM_NAME,"PITEMNAME%d",item);
	SetPVarString(playerid,tmp,ItemName);
}

stock _GetItemAmountPVar(playerid,item)
{
	new tmp[16];
	format(tmp,16,"PITEMAMOUNT%d",item);
	return GetPVarInt(playerid,tmp);
}

stock _SetItemAmountPVar(playerid,item,Amount)
{
	new tmp[16];
	format(tmp,16,"PITEMAMOUNT%d",item);
	SetPVarInt(playerid,tmp,Amount);
}

stock AddItem(playerid,ItemName[],Amount)
{
	new slot=-1;
	pInfo[playerid][pSlots] += Amount;
	for(new item;item<MAX_INV_ITEMS;item++)
	{
		if(!_GetItemAmountPVar(playerid,item))
		{
			if(slot==-1)slot=item;
			continue;
		}
		if(!strcmp(_GetItemNamePVar(playerid,item),ItemName,true))
		{
			_SetItemAmountPVar(playerid,item,_GetItemAmountPVar(playerid,item)+Amount);
			if(_GetItemAmountPVar(playerid,item)<=0)_SetItemAmountPVar(playerid,item,0);
			if(_GetItemAmountPVar(playerid,item)>MAX_ITEM_STACK)
			{
				_SetItemAmountPVar(playerid,item,MAX_ITEM_STACK);
				return 2;
			}
			return 1;
		}
	}
	if(slot>-1)
	{
		_SetItemNamePVar(playerid,slot,ItemName);
		_SetItemAmountPVar(playerid,slot,Amount);
		if(_GetItemAmountPVar(playerid,slot)>MAX_ITEM_STACK)
		{
			_SetItemAmountPVar(playerid,slot,MAX_ITEM_STACK);
			return 2;
		}
		return 1;
	}
	return 0;
}

stock RemoveItem(playerid,ItemName[],Amount)
{
	pInfo[playerid][pSlots] -= Amount;
	for(new item;item<MAX_INV_ITEMS;item++)
	{
		if(!_GetItemAmountPVar(playerid,item))continue;
		if(!strcmp(_GetItemNamePVar(playerid,item),ItemName,true))
		{
			_SetItemAmountPVar(playerid,item,_GetItemAmountPVar(playerid,item)-Amount);
			if(_GetItemAmountPVar(playerid,item)<=0)_SetItemAmountPVar(playerid,item,0);
			if(_GetItemAmountPVar(playerid,item)>MAX_ITEM_STACK)
			{
				_SetItemAmountPVar(playerid,item,MAX_ITEM_STACK);
				return 2;
			}
			return 1;
		}
	}
	return 0;
}

stock PlayerHasItem(playerid,ItemName[])
{
	for(new item;item<MAX_INV_ITEMS;item++)
	{
		if(!_GetItemAmountPVar(playerid,item))continue;
		if(!strcmp(_GetItemNamePVar(playerid,item),ItemName,false))return _GetItemAmountPVar(playerid,item);
	}
	return 0;
}

stock GetPlayerItemInfo(playerid,&idx,ItemName[],len=sizeof(ItemName),&Amount)
{
	if(idx>=MAX_INV_ITEMS)return 0;
	format(ItemName,len,_GetItemNamePVar(playerid,idx));
	Amount=_GetItemAmountPVar(playerid,idx);
	idx++;
	return 1;
}

stock ResetPlayerInventory(playerid)
{
	pInfo[playerid][pSlots] = 0;
	for(new item;item<MAX_INV_ITEMS;item++)_SetItemAmountPVar(playerid,item,0);
}

stock ShowInventory(playerid)
{
	gItemList="";
	new inv[128];
	for(new item;item<MAX_INV_ITEMS;item++)
	{
		if(!strlen(_GetItemNamePVar(playerid,item))||!_GetItemAmountPVar(playerid,item))continue;
		format(gItemList,sizeof(gItemList),"%s\n%d\t\t%s",gItemList,_GetItemAmountPVar(playerid,item),_GetItemNamePVar(playerid,item));
	}
	format(inv, sizeof(inv), "{FFFFFF}# {3F7BBF}%s {FFFFFF}- [ %i / {E33232}%i{FFFFFF} ] #", GetPlayerBackpackName(playerid), pInfo[playerid][pSlots], pInfo[playerid][pBackpack]);
	format(gItemList,sizeof(gItemList),"%s",gItemList);
	ShowPlayerDialog(playerid,D_Inventario,DIALOG_STYLE_LIST,inv,gItemList,"Use","Close");
}

stock SaveInventory(playerid)
{
	gItemList="";
	new filename[48];
	GetPlayerName(playerid,filename,24);
	format(filename,48,"Inventory/%s.inv",filename);
	new File:file=fopen(filename,io_write);
	for(new item;item<MAX_INV_ITEMS;item++)
	{
		if(!strlen(_GetItemNamePVar(playerid,item))||!_GetItemAmountPVar(playerid,item))continue;
		format(gItemList,sizeof(gItemList),"%s%s\n%d\n",gItemList,_GetItemNamePVar(playerid,item),_GetItemAmountPVar(playerid,item));
	}
	fwrite(file,gItemList);
	fclose(file);
	GetPlayerName(playerid,filename,24);
}

stock LoadInventory(playerid)
{
	new tstring[48];
	new tstring2[12];
	GetPlayerName(playerid,tstring,48);
	format(tstring,48,"Inventory/%s.inv",tstring);
	if(!fexist(tstring))return 0;
	new File:file=fopen(tstring,io_read);
	fread(file,tstring);
	while(tstring[0])
	{
		format(tstring,strlen(tstring),"%s",tstring);
		fread(file,tstring2);
		AddItem(playerid,tstring,strval(tstring2));
		fread(file,tstring);
	}
	fclose(file);
	GetPlayerName(playerid,tstring,24);
	return 1;
}

public INV_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case D_Inventario:
		{
		    if(!response)
		    {
		        RemovePlayerAttachedObject(playerid, 0);
		        ClearAnimations(playerid, 1);
		        SetPlayerObject(playerid);
			}
			if(response)
			{
				new item[MAX_ITEM_NAME];
				format(gItemList,MAX_ITEM_NAME,inputtext[strfind(inputtext,"\t")+2]);
				format(item, sizeof(item), "%s", gItemList);
				gItemSelected[playerid] = item;
				ShowPlayerDialog(playerid, D_UsarDropar, DIALOG_STYLE_LIST, "# Item Menu #", "Usar\nDropar", "Selecionar", "Voltar");
			}
		}
		case D_UsarDropar:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: // Quando o Jogador Usa o Item a funcao de usar e chamada
					{
					    RemovePlayerAttachedObject(playerid, 0);
					    ClearAnimations(playerid, 1);
					    SetPlayerObject(playerid);
						CallLocalFunction("OnPlayerUseItem","is",playerid, gItemSelected[playerid]);
					}
					case 1: // Quando o Jogador Dropa o Item
					{
					    RemovePlayerAttachedObject(playerid, 0);
					    ClearAnimations(playerid, 1);
					    SetPlayerObject(playerid);
						CallLocalFunction("OnPlayerDropItem","is",playerid, gItemSelected[playerid]);
					}
				}
			}
			else ShowInventory(playerid);
		}
		case DIALOG_TENT_VIEW:
		{
			if(response)
			{
			    pInfo[playerid][pTentLink] = listitem;
				ShowPlayerDialog(playerid,DIALOG_TENT_VIEW_S,DIALOG_STYLE_MSGBOX,"Caixa"COL_GREEN" (8 SLOTS)","Por favor escolha uma opcao","Add Item","Pegar Item");
			}
		}
		case DIALOG_TENT_VIEW_S:
		{
			if(response)
			{
			    ShowInventoryTent(playerid);
			}
			if(!response)
			{
			    new str[64], strv[64];
				if(pInfo[playerid][pTentLink] == 0)
				{
					AddSlotToInventoryWorld(playerid,Caixa[idcaixap[playerid]][Item1],1);
					format(str,sizeof(str),"Voce pegou o item '%s' do slot 1",Caixa[idcaixap[playerid]][Item1]);
					SendClientMessage(playerid,-1,str);
					format(strv,sizeof(strv),"<Slot Vazio>");
					Caixa[idcaixap[playerid]][Item1] = strv;
				}
				if(pInfo[playerid][pTentLink] == 1)
				{
					AddSlotToInventoryWorld(playerid,Caixa[idcaixap[playerid]][Item2],1);
					format(str,sizeof(str)," Voce pegou o item '%s' do slot 2",Caixa[idcaixap[playerid]][Item2]);
					SendClientMessage(playerid,-1,str);
					format(strv,sizeof(strv),"<Slot Vazio>");
					Caixa[idcaixap[playerid]][Item2] = strv;
				}
				if(pInfo[playerid][pTentLink] == 2)
				{
					AddSlotToInventoryWorld(playerid,Caixa[idcaixap[playerid]][Item3],1);
					format(str,sizeof(str)," Voce pegou o item '%s' do slot 3",Caixa[idcaixap[playerid]][Item3]);
					SendClientMessage(playerid,-1,str);
					format(strv,sizeof(strv),"<Slot Vazio>");
					Caixa[idcaixap[playerid]][Item3] = strv;
				}
				if(pInfo[playerid][pTentLink] == 3)
				{
					AddSlotToInventoryWorld(playerid,Caixa[idcaixap[playerid]][Item4],1);
					format(str,sizeof(str)," Voce pegou o item '%s' do slot 4",Caixa[idcaixap[playerid]][Item4]);
					SendClientMessage(playerid,-1,str);
					format(strv,sizeof(strv),"<Slot Vazio>");
					Caixa[idcaixap[playerid]][Item4] = strv;
				}
				if(pInfo[playerid][pTentLink] == 4)
				{
					AddSlotToInventoryWorld(playerid,Caixa[idcaixap[playerid]][Item5],1);
					format(str,sizeof(str)," Voce pegou o item '%s' do slot 5",Caixa[idcaixap[playerid]][Item5]);
					SendClientMessage(playerid,-1,str);
					format(strv,sizeof(strv),"<Slot Vazio>");
					Caixa[idcaixap[playerid]][Item5] = strv;
				}
				if(pInfo[playerid][pTentLink] == 5)
				{
					AddSlotToInventoryWorld(playerid,Caixa[idcaixap[playerid]][Item6],1);
					format(str,sizeof(str)," Voce pegou o item '%s' do slot 6",Caixa[idcaixap[playerid]][Item6]);
					SendClientMessage(playerid,-1,str);
					format(strv,sizeof(strv),"<Slot Vazio>");
					Caixa[idcaixap[playerid]][Item6] = strv;
				}
				if(pInfo[playerid][pTentLink] == 6)
				{
					AddSlotToInventoryWorld(playerid,Caixa[idcaixap[playerid]][Item7],1);
					format(str,sizeof(str)," Voce pegou o item '%s' do slot 7",Caixa[idcaixap[playerid]][Item7]);
					SendClientMessage(playerid,-1,str);
					format(strv,sizeof(strv),"<Slot Vazio>");
					Caixa[idcaixap[playerid]][Item7] = strv;
				}
				if(pInfo[playerid][pTentLink] == 7)
				{
					AddSlotToInventoryWorld(playerid,Caixa[idcaixap[playerid]][Item8],1);
					format(str,sizeof(str)," Voce pegou o item '%s' do slot 8",Caixa[idcaixap[playerid]][Item8]);
					SendClientMessage(playerid,-1,str);
					format(strv,sizeof(strv),"<Slot Vazio>");
					Caixa[idcaixap[playerid]][Item8] = strv;
				}
			}
		}
		case DIALOG_TENT_VIEW_S2:
		{
			if(response)
			{
			    new str[64],str2[128];
				if(pInfo[playerid][pTentLink] == 0)
				{
				    format(gItemList,MAX_ITEM_NAME,inputtext[strfind(inputtext,"\t")+2]);
					RemoveSlotToInventory(playerid,gItemList,1);
					format(str,sizeof(str),"%s",gItemList);
					Caixa[idcaixap[playerid]][Item1] = str;
					format(str2,sizeof(str2)," Voce adicionou o item '%s' ao slot 1!",inputtext);
					SendClientMessage(playerid,-1,str2);
				}
				if(pInfo[playerid][pTentLink] == 1)
				{
				    format(gItemList,MAX_ITEM_NAME,inputtext[strfind(inputtext,"\t")+2]);
					RemoveSlotToInventory(playerid,gItemList,1);
					format(str,sizeof(str),"%s",gItemList);
					Caixa[idcaixap[playerid]][Item2] = str;
					format(str2,sizeof(str2),"  Voce adicionou o item '%s' ao slot 2!",inputtext);
					SendClientMessage(playerid,-1,str2);
				}
				if(pInfo[playerid][pTentLink] == 2)
				{
				    format(gItemList,MAX_ITEM_NAME,inputtext[strfind(inputtext,"\t")+2]);
					RemoveSlotToInventory(playerid,gItemList,1);
					format(str,sizeof(str),"%s",gItemList);
					Caixa[idcaixap[playerid]][Item3] = str;
					format(str2,sizeof(str2),"  Voce adicionou o item '%s' ao slot 3!",inputtext);
					SendClientMessage(playerid,-1,str2);
				}
				if(pInfo[playerid][pTentLink] == 3)
				{
				    format(gItemList,MAX_ITEM_NAME,inputtext[strfind(inputtext,"\t")+2]);
					RemoveSlotToInventory(playerid,gItemList,1);
					format(str,sizeof(str),"%s",gItemList);
					Caixa[idcaixap[playerid]][Item4] = str;
					format(str2,sizeof(str2),"  Voce adicionou o item '%s' ao slot 4!",inputtext);
					SendClientMessage(playerid,-1,str2);
				}
				if(pInfo[playerid][pTentLink] == 4)
				{
				    format(gItemList,MAX_ITEM_NAME,inputtext[strfind(inputtext,"\t")+2]);
					RemoveSlotToInventory(playerid,gItemList,1);
					format(str,sizeof(str),"%s",gItemList);
					Caixa[idcaixap[playerid]][Item5] = str;
					format(str2,sizeof(str2),"  Voce adicionou o item '%s' ao slot 5!",inputtext);
					SendClientMessage(playerid,-1,str2);
				}
				if(pInfo[playerid][pTentLink] == 5)
				{
				    format(gItemList,MAX_ITEM_NAME,inputtext[strfind(inputtext,"\t")+2]);
					RemoveSlotToInventory(playerid,gItemList,1);
					format(str,sizeof(str),"%s",gItemList);
					Caixa[idcaixap[playerid]][Item6] = str;
					format(str2,sizeof(str2),"  Voce adicionou o item '%s' ao slot 6!",inputtext);
					SendClientMessage(playerid,-1,str2);
				}
				if(pInfo[playerid][pTentLink] == 6)
				{
				    format(gItemList,MAX_ITEM_NAME,inputtext[strfind(inputtext,"\t")+2]);
					RemoveSlotToInventory(playerid,gItemList,1);
					format(str,sizeof(str),"%s",gItemList);
					Caixa[idcaixap[playerid]][Item7] = str;
					format(str2,sizeof(str2),"  Voce adicionou o item '%s' ao slot 7!",inputtext);
					SendClientMessage(playerid,-1,str2);
				}
				if(pInfo[playerid][pTentLink] == 7)
				{
				    format(gItemList,MAX_ITEM_NAME,inputtext[strfind(inputtext,"\t")+2]);
					RemoveSlotToInventory(playerid,gItemList,1);
					format(str,sizeof(str),"%s",gItemList);
					Caixa[idcaixap[playerid]][Item8] = str;
					format(str2,sizeof(str2),"  Voce adicionou o item '%s' ao slot 8!",inputtext);
					SendClientMessage(playerid,-1,str2);
				}
			}
		}
	}
	return 1;
}

stock GetPlayerBackpackName(playerid)
{
	new backpack[24];
	switch(pInfo[playerid][pBackpack])
	{
		case 5: backpack = "Mochila pequena";
		case 10: backpack = "Mochila normal";
		case 16: backpack = "Mochila de caca";
		case 24: backpack = "Mochila grande";
		case 32: backpack = "Mochila drybag";
		default: backpack = "Player Inventory";
	}
	return backpack;
}
