// # Definicoes #

#define MAX_DROPS (5000) // Maximo de items spawandos + items dropados pelos jogadores!
#define MAX_ITEM_NAME (24)

// # Enumeradores #

enum Item_Data
{
	Item_ID,
	Item_Obj,
	Item_Name[MAX_ITEM_NAME],
	Float:Item_RotX,
	Float:Item_RotY,
	Float:Item_RotZ,
};

enum Drop_Data
{
	DropItemID,
	DropObj,
	Text3D:DropLabel,
	Float:dPosX,
	Float:dPosY,
	Float:dPosZ,
};

new DropInfo[MAX_DROPS][Drop_Data];

// # Arrays #

/* Agradecimento ao Marttins por procurar os objetos */
new ItemInfo[][Item_Data] =
{
	/* id, objeto, nome, rotacao x, rotacao y, rotacao z */
	/* ============ [ CIVILS ] ============ */
	{0,   3026,       "Mochila normal",    -88.399, 0.0, 0.0 },
	{1,   1310,       "Mochila de caca",   -90.299, 0.0, 0.0 },
	{2,   19559,      "Mochila grande",     -91.799, 0.0, 0.0 },
	{3,   2683,  "Garrafa vazia",    0.0, 0.0, 0.0     },
	/* ========== [ Items Medicos ] ========== */
	{4,   11738,      "Medkit",        0.0, 0.0, 0.0     },
	{5,   11748,      "Curativo",            0.0, 0.0, 0.0     },
	{6,   2752,       "Morfina",  0.0, 0.0, 0.0     },
	{7,   2709,       "Analgesico",         0.0, 0.0, 0.0     },
	{8,   1580,       "Bolsa de sangue",          0.0, 0.0, 0.0     },
	/* ============= [ Bebidas ] ============= */
	{9,    19570,     "Leite fresco",         0.0, 0.0, 0.0     },
	{10,   2683,      "Garrafa com agua",      0.0, 0.0, 0.0     },
	{11,   1546,      "Fanta",         0.0, 0.0, 0.0     },
	{12,   19823,     "Whisky",      0.0, 0.0, 0.0     },
	{13,   19563,     "Suco de laranja",       0.0, 0.0, 0.0     },
	{14,   19564,     "Suco de maca",        0.0, 0.0, 0.0     },
	{15,   19835,     "Cafe",             0.0, 0.0, 0.0     },
	/* ============= [ Comidas ] ============= */
	{16,   19847,     "Presunto",            0.0, 0.0, 0.0     },
	{17,   19883,     "Fatia de pao",        0.0, 0.0, 0.0     },
	{18,   2768,      "Hamburguer",             0.0, 0.0, 0.0     },
	{19,   19561,     "Cereal",         0.0, 0.0, 0.0     },
	{20,   19580,     "Pizza",              0.0, 0.0, 0.0     },
	{21,   2769,      "Taco",               0.0, 0.0, 0.0     },
	{22,   19567,     "Sorvete",          0.0, 0.0, 0.0     },
	{23,   2858,      "Comida chinesa",       0.0, 0.0, 0.0     },
	{24,   19574,     "Laranja",             0.0, 0.0, 0.0     },
	{25,   19575,     "Maca",              0.0, 0.0, 0.0     },
	{26,   19576,     "Maca verde",        0.0, 0.0, 0.0     },
	{27,   19577,     "Tomate",             0.0, 0.0, 0.0     },
	{28,   19578,     "Banana",             0.0, 0.0, 0.0     },
	/* ============= [ Armas ] ============= */
	{29,   348,       "Pistola .50",         90.0, 0.0, 0.0    },
	{30,   346,       "Glock 19",           90.0, 0.0, 0.0    },
	{31,   347,       "M9 SD",              90.0, 0.0, 0.0    },
	{32,   353,       "MP5-K",         90.0, 0.0, 0.0    },
	{33,   352,       "PDW",      90.0, 0.0, 0.0    },
	{34,   372,       "CZ61 Skorpion",              90.0, 0.0, 0.0    },
	{35,   350,       "Sawed-off IZH-43",            90.0, 0.0, 0.0    },
	{36,   349,       "Shotgun",     90.0, 0.0, 0.0    },
	/* ============= [ Armas Brancas ] ============= */
	{37,   336,       "Baseball Bat",       90.0, 0.0, 0.0    },
	{38,   339,       "Katana",              90.0, 0.0, 0.0    },
	{39,   335,       "Faca Ak-47",       90.0, 0.0, 0.0    },
	{40,   337,       "pa",             90.0, 0.0, 0.0    },
	/* ============= [ Granadas ] ============= */
	{41,   342,       "Granada",       0.0, 0.0, 0.0     },
	/* ============= [ Munições ] ============= */
	{42,   18644,      "Chave de fenda",       90.0, 0.0, 0.0     },
	{43,   18635 ,      "Martelo",       90.0, 0.0, 0.0     },
	{44,   341,      "Motoserra",           0.0, 0.0, 0.0     },
	{45,   1212,      "Dinheiro",        0.0, 0.0, 0.0     },
	{46,   18873,      "Celular",        0.0, 0.0, 0.0     },
	/* ============= [ Variados ] ============= */
	{47,   18875,     "GPS",                0.0, 0.0, 0.0     },
	{48,   2386,      "Roupa",           0.0, 0.0, 0.0     },
	{49,   2006,      "Motor",             0.0, 0.0, 0.0     },
	{50,   19921,     "Toolbox",            0.0, 0.0, 0.0     },
	{51,   2967,      "Radio",       0.0, 0.0, 0.0     },
	{52,   19515,     "Colete",        90.0, 0.0, 0.0    },
	{53,   19472,     "Mascara de gas",           0.0, 0.0, 0.0     },
	{54,   19514,     "Capacete",             0.0, 0.0, 0.0     },
	{55,   1650,      "Galao de combustivel",      90.0, 0.0, 0.0    },
	{56,   19998,  "isqueiro", 90.0, 0.0, 0.0 },
	{57,   344,     "Molotov", 0.0, 0.0, 0.0 },
	{58,   11747,     "Pano", 0.0, 0.0, 0.0},

	/* ============= [ Vazios ] ============= */
	{59,   1650,      "Galao vazio",    90.0, 0.0, 0.0    },
	{60,   1550,      "Mochila drybag",    0.0, -94.899, 0.0 },
	{61,   1576,      "TNT", 0.0, 0.0, 0.0 },
	{62,   351,       "Pump Shotgun",   90.0, 0.0, 0.0    },
	{63,   355,       "AKS-74U",       90.0, 0.0, 0.0    },
	{64,   356,       "AR-15",      90.0, 0.0, 0.0    },
	{65,   355,       "AKS-74U",                90.0, 0.0, 0.0    },
	{66,   356,       "AR-15",              90.0, 0.0, 0.0    },
    {67,   1654,      "TNT Cronometrada", 0.0, 0.0, 0.0 },
    {68,   19632,     "Fogueira", 0.0, 0.0, 0.0 },
    {69,   2976, 	  "Frasco Radioativo", 0.0, 0.0, 0.0}

};
// # Forwards #

forward Item_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
forward Item_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);

forward OnPlayerPickupItemFromDrop(playerid);
forward OnPlayerUseItem(playerid, ItemName[]);
forward OnPlayerDropItem(playerid, ItemName[]);

// # Callbacks #

public OnPlayerUseItem(playerid,ItemName[])
{
	/* ============ [ Mochilas ] ============ */
	if(!strcmp(ItemName,"Mochila normal",true))
	{
        if(pInfo[playerid][pBackpack] > 10) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce ja possui uma mochila maior.");
        if(pInfo[playerid][pBackpack] == 10) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voca ja esta com mochila.");
        ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~Equipando....",1000,3);
        pInfo[playerid][pBackpack] = 10;
        SetPlayerObject(playerid);
        RemoveItem(playerid, ItemName, 1);
        return 0;
	}

	if(!strcmp(ItemName,"Mochila de caca",true))
	{
        if(pInfo[playerid][pBackpack] > 16) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce ja possui uma mochila maior.");
        if(pInfo[playerid][pBackpack] == 16) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voca ja esta com mochila.");
        ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~Equipando....",1000,3);
        pInfo[playerid][pBackpack] = 16;
        SetPlayerObject(playerid);
        RemoveItem(playerid, ItemName, 1);
        return 0;
	}

	if(!strcmp(ItemName,"Mochila grande",true))
	{
        if(pInfo[playerid][pBackpack] > 24) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce ja possui uma mochila maior.");
        if(pInfo[playerid][pBackpack] == 24) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voca ja esta com mochila.");
        ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~Equipando....",1000,3);
        pInfo[playerid][pBackpack] = 24;
        SetPlayerObject(playerid);
        RemoveItem(playerid, ItemName, 1);
        return 0;
	}

	if(!strcmp(ItemName,"Mochila drybag",true))
	{
        if(pInfo[playerid][pBackpack] > 32) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce ja possui uma mochila maior.");
        if(pInfo[playerid][pBackpack] == 32) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voca ja esta com mochila.");
        ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~Equipando....",1000,3);
        pInfo[playerid][pBackpack] = 32;
        SetPlayerObject(playerid);
        RemoveItem(playerid, ItemName, 1);
        return 0;
	}

    /* ========== [ Items Medicos ] ========== */
    if(!strcmp(ItemName,"Medkit",true))
	{ 
        SetTimerEx( "delyanaimacao", 1000, false, "i", playerid);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~r~~h~Curando....",1000,3);
        timerdacura[playerid] = SetTimerEx( "Curandocura", 1000, true, "i", playerid);
		RemoveItem(playerid, ItemName, 1);
	}

    if(!strcmp(ItemName,"Curativo",true))
	{
        SetTimerEx( "delyanaimacao", 1000, false, "i", playerid);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~r~~h~Curando....",1000,3);
        timerdacura[playerid] = SetTimerEx( "Curandocura", 1000, true, "i", playerid);
		RemoveItem(playerid, ItemName, 1);
	}
	if(!strcmp(ItemName,"Molotov",true))
	{
		GivePlayerWeapon(playerid, 18, 1);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Morfina",true))
	{
        SetTimerEx( "delyanaimacao", 1000, false, "i", playerid);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~r~~h~Curando....",1000,3);
        timerdacura[playerid] = SetTimerEx( "Curandocura", 1000, true, "i", playerid);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Analgesico",true))
	{
		SetPlayerDrunkLevel(playerid, 0);
        ApplyAnimation(playerid,"VENDING","VEND_Drink_P",4.1,0,0,0,1,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~r~~h~Curando....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Bolsa de sangue",true))
	{
        SetTimerEx( "delyanaimacao", 1000, false, "i", playerid);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~r~~h~Curando....",1000,3);
        timerdacura[playerid] = SetTimerEx( "Curandocura", 1000, true, "i", playerid);
		RemoveItem(playerid, ItemName, 1);
	}  

	/* ============= [ Bebidas ] ============= */
	if(!strcmp(ItemName,"Leite fresco",true))
	{
        if(pInfo[playerid][pSede] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com sede");
        pInfo[playerid][pSede] += 8;
		ApplyAnimation(playerid,"VENDING","VEND_Drink_P",4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~b~~h~Bebendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Garrafa com agua",true))
	{
        if(pInfo[playerid][pSede] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com sede");
        pInfo[playerid][pSede] += 20;
		ApplyAnimation(playerid,"VENDING","VEND_Drink_P",4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~b~~h~Bebendo....",1000,3);
        AddItem(playerid, "Garrafa vazia", 1);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Fanta",true))
	{
        if(pInfo[playerid][pSede] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com sede");
        pInfo[playerid][pSede] += 10;
		ApplyAnimation(playerid,"VENDING","VEND_Drink_P",4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~b~~h~Bebendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Whisky",true))
	{
        if(pInfo[playerid][pSede] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com sede");
        pInfo[playerid][pSede] += 4;
		ApplyAnimation(playerid,"PED","WALK_DRUNK",4.1,1,1,1,1,1,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~b~~h~bebendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Suco de laranja",true))
	{
        if(pInfo[playerid][pSede] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com sede");
        pInfo[playerid][pSede] += 12;
		ApplyAnimation(playerid,"VENDING","VEND_Drink_P",4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~b~~h~Bebendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Suco de maca",true))
	{
        if(pInfo[playerid][pSede] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com sede");
        pInfo[playerid][pSede] += 16;
		ApplyAnimation(playerid,"VENDING","VEND_Drink_P",4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~b~~h~Bebendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Cafe",true))
	{
        if(pInfo[playerid][pSede] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com sede");
        pInfo[playerid][pSede] += 8;
		ApplyAnimation(playerid,"VENDING","VEND_Drink_P",4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~b~~h~Bebendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	/* ============= [ Comidas ] ============= */
	if(!strcmp(ItemName,"Presunto",true))
	{
        if(pInfo[playerid][pFome] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com fome.");
        pInfo[playerid][pFome] += 15;
		ApplyAnimation(playerid,"FOOD","EAT_Burger", 4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~Comendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Fatia de pao",true))
	{
        if(pInfo[playerid][pFome] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com fome.");
        pInfo[playerid][pFome] += 7;
		ApplyAnimation(playerid,"FOOD","EAT_Burger", 4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~Comendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Hamburguer",true))
	{
        if(pInfo[playerid][pFome] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com fome.");
        pInfo[playerid][pFome] += 15;
		ApplyAnimation(playerid,"FOOD","EAT_Burger", 4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~Comendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Cereal",true))
	{
        if(pInfo[playerid][pFome] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com fome.");
        pInfo[playerid][pFome] += 10;
		ApplyAnimation(playerid,"FOOD","EAT_Burger", 4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~Comendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Pizza",true))
	{
        if(pInfo[playerid][pFome] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com fome.");
        pInfo[playerid][pFome] += 20;
		ApplyAnimation(playerid,"FOOD","EAT_Burger", 4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~Comendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Taco",true))
	{
        if(pInfo[playerid][pFome] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com fome.");
        pInfo[playerid][pFome] += 12;
		ApplyAnimation(playerid,"FOOD","EAT_Burger", 4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~Comendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Sorvete",true))
	{
        if(pInfo[playerid][pFome] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com fome.");
        pInfo[playerid][pFome] += 6;
		ApplyAnimation(playerid,"FOOD","EAT_Burger", 4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~Comendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Comida chinesa",true))
	{
        if(pInfo[playerid][pFome] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com fome.");
        pInfo[playerid][pFome] += 8;
		ApplyAnimation(playerid,"FOOD","EAT_Burger", 4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~Comendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Laranja",true))
	{
        if(pInfo[playerid][pFome] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com fome.");
        pInfo[playerid][pFome] += 6;
		ApplyAnimation(playerid,"FOOD","EAT_Burger", 4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~Comendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Maca",true))
	{
        if(pInfo[playerid][pFome] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com fome.");
        pInfo[playerid][pFome] += 4;
		ApplyAnimation(playerid,"FOOD","EAT_Burger", 4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~Comendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Maca verde",true))
	{
        if(pInfo[playerid][pFome] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com fome.");
        pInfo[playerid][pFome] += 4;
		ApplyAnimation(playerid,"FOOD","EAT_Burger", 4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~Comendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Tomate",true))
	{
        if(pInfo[playerid][pFome] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com fome.");
        pInfo[playerid][pFome] += 5;
		ApplyAnimation(playerid,"FOOD","EAT_Burger", 4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~Comendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Banana",true))
	{
        if(pInfo[playerid][pFome] >= 100) return SendClientMessage(playerid, COR_CINZA, "[INFO]: Voce nao esta com fome.");
        pInfo[playerid][pFome] += 5;
		ApplyAnimation(playerid,"FOOD","EAT_Burger", 4.0,0,0,0,0,0,1);
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~Comendo....",1000,3);
		RemoveItem(playerid, ItemName, 1);
	}

	/* ============= [ Armas ] ============= */
	if(!strcmp(ItemName,"Pistola .50",true))
	{
		new rand = minrand(5, 15);
		GivePlayerWeapon(playerid, 24, rand);
		RemoveItem(playerid, ItemName, 1);
	} 

	if(!strcmp(ItemName,"Glock 19",true))
	{
		new rand = minrand(16, 30);
		GivePlayerWeapon(playerid, 22, rand);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"M9 SD",true))
	{
		new rand = minrand(16, 30);
		GivePlayerWeapon(playerid, 23, rand);
		RemoveItem(playerid, ItemName, 1);
	}    

	if(!strcmp(ItemName,"AR-15",true))
	{
		new rand = minrand(25, 57);
		GivePlayerWeapon(playerid, 31, rand);
		RemoveItem(playerid, ItemName, 1);
	}        

	if(!strcmp(ItemName,"AKS-74U",true))
	{
		new rand = minrand(25, 57);
		GivePlayerWeapon(playerid, 30, rand);
		RemoveItem(playerid, ItemName, 1);
	}        

	if(!strcmp(ItemName,"AR-15",true))
	{
		new rand = minrand(25, 57);
		GivePlayerWeapon(playerid, 31, rand);
		RemoveItem(playerid, ItemName, 1);
	}        

	if(!strcmp(ItemName,"AKS-74U",true))
	{
		new rand = minrand(25, 57);
		GivePlayerWeapon(playerid, 30, rand);
		RemoveItem(playerid, ItemName, 1);
	}        

	if(!strcmp(ItemName,"Shotgun",true))
	{
		new rand = minrand(5, 18);
		GivePlayerWeapon(playerid, 25, rand);
		RemoveItem(playerid, ItemName, 1);
	}        

	if(!strcmp(ItemName,"Sawed-off IZH-43",true))
	{
		new rand = minrand(5, 18);
		GivePlayerWeapon(playerid, 26, rand);
		RemoveItem(playerid, ItemName, 1);
	}        

	if(!strcmp(ItemName,"Pump Shotgun",true))
	{
		new rand = minrand(5, 18);
		GivePlayerWeapon(playerid, 27, rand);
		RemoveItem(playerid, ItemName, 1);
	}        

	if(!strcmp(ItemName,"CZ61 Skorpion",true))
	{
		new rand = minrand(30, 68);
		GivePlayerWeapon(playerid, 32, rand);
		RemoveItem(playerid, ItemName, 1);
	}        

	if(!strcmp(ItemName,"PDW",true))
	{
		new rand = minrand(30, 68);
		GivePlayerWeapon(playerid, 28, rand);
		RemoveItem(playerid, ItemName, 1);
	}        

	if(!strcmp(ItemName,"MP5-K",true))
	{
		new rand = minrand(30, 68);
		GivePlayerWeapon(playerid, 29, rand);
		RemoveItem(playerid, ItemName, 1);
	}

	/* ============= [ Armas Brancas ] ============= */     
	if(!strcmp(ItemName,"Baseball Bat",true))
	{
	    GivePlayerWeapon(playerid, 5, 1);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Katana",true))
	{
	    GivePlayerWeapon(playerid, 8, 1);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Faca AK-47",true))
	{
	    GivePlayerWeapon(playerid, 4, 1);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Pa",true))
	{
	    GivePlayerWeapon(playerid, 6, 1);
		RemoveItem(playerid, ItemName, 1);
	}

	/* ============= [ Granadas ] ============= */
	if(!strcmp(ItemName,"Granada",true))
	{
	    GivePlayerWeapon(playerid, 16, 1);
		RemoveItem(playerid, ItemName, 1);
	}

	/* ============= [ Munições ] ============= */
	if(!strcmp(ItemName,"Chave de fenda",true))
	{
		SendClientMessage(playerid, COR_AMARELO, "[Dica]: Use para crafts.");
	}
	if(!strcmp(ItemName,"Martelo",true))
	{
		SendClientMessage(playerid, COR_AMARELO, "[Dica]: Use para crafts.");
	}
	if(!strcmp(ItemName,"Motoserra",true))
	{
		SendClientMessage(playerid, COR_AMARELO, "[Dica]: Use para coletar madeira apertando N.");
	}

	if(!strcmp(ItemName,"Dinheiro",true))
	{
	    new str[60];
	    new rand = minrand(50, 150);
	    format(str, sizeof(str), "Voce ganhou %d coins.", rand);
        SendClientMessage(playerid, COR_AMARELO, str);
        pInfo[playerid][pCoin] +=rand;
        RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Celular",true))
	{
		SendClientMessage(playerid, COR_AMARELO, "[Dica] Utilize o  celular para crafts.");
	}

	/* ============= [ Variados ] ============= */
	if(!strcmp(ItemName,"GPS",true))
	{
	    SendClientMessage(playerid, COR_AMARELO, "[ERRO] Sistema desativado, item sem funcionalidade.");
	}

	if(!strcmp(ItemName,"Roupa",true))
	{
		new rand = minrand(50, 159);
		SetPlayerSkin(playerid, rand);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Motor",true))
	{
		SendClientMessage(playerid, COR_AMARELO, "[Dica]: Use /motor dentro de um veiculo para colocar o motor.");
	}

	if(!strcmp(ItemName,"Toolbox",true))
	{
		SendClientMessage(playerid, COR_AMARELO, "[Dica]: Use /reparo dentro de um veiculo para reparar.");
	}

	if(!strcmp(ItemName,"Radio",true))
	{
	    SendClientMessage(playerid, COR_AMARELO, "[System]: Radio ligado.");
	    pInfo[playerid][pTemRADIO] = 1;
  		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Colete",true))
	{
	    pInfo[playerid][pTemColete] = 1;
	    SetPlayerArmour(playerid, 100);
	    SetPlayerAttachedObject(playerid, 9, 19515, 1, 0.072999, 0.032000, 0.000000, 0.000000, 0.000000, 0.000000, 1.027999, 1.188000, 1.062999);
		RemoveItem(playerid, ItemName, 1);
	}

	if(!strcmp(ItemName,"Mascara de gas",true))
	{
		if(pInfo[playerid][pTemMask] == 1) return SendClientMessage(playerid, -1, "Voce ja possui uma mascara");
		pInfo[playerid][pTemMask] = 1;
		SetPlayerAttachedObject(playerid, 7, 19472, 2, 0.013000, 0.111999, 0.001000, 106.399971, 82.700004, -12.100005, 1.000000, 1.000000, 1.000000);   
	}	

	if(!strcmp(ItemName,"Capacete",true))
	{
	    pInfo[playerid][pTemCapacete] = 1;
	    SetPlayerAttachedObject(playerid, 8, 19200, 2, 0.119999, 0.014999, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
		RemoveItem(playerid, ItemName, 1);
	}	

	if(!strcmp(ItemName,"Galao de combustivel",true))
	{
		SendClientMessage(playerid, COR_AMARELO, "[Dica]: Use /galao dentro de um veiculo para colocar combustivel");
	}

	/* ============= [ Vazios ] ============= */
	if(!strcmp(ItemName,"Garrafa vazia",true))
	{
	    SendClientMessage(playerid, COR_AMARELO, "[Dica]: Voce pode usar para encher com agua");
	}

	if(!strcmp(ItemName,"Galao vazio",true))
	{
		SendClientMessage(playerid, COR_AMARELO, "[Dica]: Voce nao pode usar este item, coloque combustivel para abastecer veiculo");
	}	
	
	if(!strcmp(ItemName,"TNT Cronometrada",true))
	{
    	new id = GetPlayerRangeParede(playerid);
    	idparedebomb[playerid] = GetPlayerRangeParede(playerid);
    	TogglePlayerControllable(playerid, 0);
    	if(id == -1) return SendClientMessage(playerid, -1, "{E80000}[ERRO] Voce nao esta perto de uma porta.");
    	ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0);
    	ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0);
		GameTextForPlayer(playerid, "~w~Plantando ~g~bomba...", 2500, 4);
		SetTimerEx( "Platandobomba", 5000, false, "i",playerid);
		RemoveItem(playerid, ItemName, 1);
	}
	if(!strcmp(ItemName,"Fogueira",true))
	{
		if(fogueiraplayer[playerid] == 1) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce ja colocou uma fogueira no chao.");
		GetPlayerPos(playerid, fogueirapos[playerid][0], fogueirapos[playerid][1], fogueirapos[playerid][2]);
		objfogueira[playerid] = CreateObject(19632, fogueirapos[playerid][0], fogueirapos[playerid][1], fogueirapos[playerid][2]-1, 0, 0, 0, 300);
		SendClientMessage(playerid, COR_AMARELO, "Voce colocou uma fogueira no chao | fique proximo para nao ficar com frio.");
		fogueiraplayer[playerid] = 1;
		RemoveItem(playerid, ItemName, 1);
	}
	return 1; // Retornar verdadeiro = Voltar o Inventario apos usar o Item, Retornar falso = Fechar Inventario apos usar o item
}

public OnPlayerDropItem(playerid, ItemName[])
{
	new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);

    SetPlayerPos(playerid, X+0.1, Y, Z), SetCameraBehindPlayer(playerid); // Fix no bug do item nao aparecer no chao quando dropado, teleportando o jogador +1 faz o objeto aparecer

    GetXYInFrontOfPlayer(playerid, X, Y, 1.0);

    /* ============ [ Mochilas ] ============ */
    if(!strcmp(ItemName,"Mochila normal",true))
    {
    	RemoveItem(playerid, ItemName, 1);
    	CreateDrop(0, X, Y, Z);
    }
    if(!strcmp(ItemName,"Pano",true))
    {
    	RemoveItem(playerid, ItemName, 1);
    	CreateDrop(58, X, Y, Z);
    }
    if(!strcmp(ItemName,"Molotov",true))
    {
    	RemoveItem(playerid, ItemName, 1);
    	CreateDrop(57, X, Y, Z);
    }

    if(!strcmp(ItemName,"Mochila de caca",true))
    {
    	RemoveItem(playerid, ItemName, 1);
    	CreateDrop(1, X, Y, Z);
    }

    if(!strcmp(ItemName,"Mochila grande",true))
    {
    	RemoveItem(playerid, ItemName, 1);
    	CreateDrop(2, X, Y, Z);
    }

    if(!strcmp(ItemName,"Mochila drybag",true))
    {
    	RemoveItem(playerid, ItemName, 1);
    	CreateDrop(60, X, Y, Z);
    } 

    /* ========== [ Items Medicos ] ========== */
    if(!strcmp(ItemName,"Medkit",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(4, X, Y, Z);
	}

    if(!strcmp(ItemName,"Curativo",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(5, X, Y, Z);
	}

	if(!strcmp(ItemName,"Morfina",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(6, X, Y, Z);
	}

	if(!strcmp(ItemName,"Analgesico",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(7, X, Y, Z);
	}

	if(!strcmp(ItemName,"Bolsa de sangue",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(8, X, Y, Z);
	}  

	/* ============= [ Bebidas ] ============= */
	if(!strcmp(ItemName,"Leite fresco",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(9, X, Y, Z);
	}

	if(!strcmp(ItemName,"Garrafa com agua",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(10, X, Y, Z);
	}

	if(!strcmp(ItemName,"Fanta",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(11, X, Y, Z);
	}

	if(!strcmp(ItemName,"Whisky",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(12, X, Y, Z);
	}

	if(!strcmp(ItemName,"Suco de laranja",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(13, X, Y, Z);
	}

	if(!strcmp(ItemName,"Suco de maca",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(14, X, Y, Z);
	}

	if(!strcmp(ItemName,"Cafe",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(15, X, Y, Z);
	}

	/* ============= [ Comidas ] ============= */
	if(!strcmp(ItemName,"Presunto",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(16, X, Y, Z);
	}

	if(!strcmp(ItemName,"Fatia de pao",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(17, X, Y, Z);
	}

	if(!strcmp(ItemName,"Hamburguer",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(18, X, Y, Z);
	}

	if(!strcmp(ItemName,"Cereal",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(19, X, Y, Z);
	}

	if(!strcmp(ItemName,"Pizza",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(20, X, Y, Z);
	}

	if(!strcmp(ItemName,"Taco",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(21, X, Y, Z);
	}

	if(!strcmp(ItemName,"Sorvete",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(22, X, Y, Z);
	}

	if(!strcmp(ItemName,"Comida chinesa",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(23, X, Y, Z);
	}

	if(!strcmp(ItemName,"Laranja",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(24, X, Y, Z);
	}

	if(!strcmp(ItemName,"Maca",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(25, X, Y, Z);
	}

	if(!strcmp(ItemName,"Maca verde",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(26, X, Y, Z);
	}

	if(!strcmp(ItemName,"Tomate",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(27, X, Y, Z);
	} 

	if(!strcmp(ItemName,"Banana",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(28, X, Y, Z);
	}  

	/* ============= [ Armas ] ============= */
	if(!strcmp(ItemName,"Pistola .50",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(29, X, Y, Z);
	} 

	if(!strcmp(ItemName,"Glock 19",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(30, X, Y, Z);
	}

	if(!strcmp(ItemName,"M9 SD",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(31, X, Y, Z);
	}

	if(!strcmp(ItemName,"AR-15",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(64, X, Y, Z);
	}        

	if(!strcmp(ItemName,"AKS-74U",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(63, X, Y, Z);
	}        

	if(!strcmp(ItemName,"Shotgun",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(36, X, Y, Z);
	}        

	if(!strcmp(ItemName,"Sawed-off IZH-43",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(35, X, Y, Z);
	}        

	if(!strcmp(ItemName,"Pump Shotgun",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(62, X, Y, Z);
	}        

	if(!strcmp(ItemName,"CZ61 Skorpion",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(34, X, Y, Z);
	}        

	if(!strcmp(ItemName,"PDW",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(33, X, Y, Z);
	}        

	if(!strcmp(ItemName,"MP5-K",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(32, X, Y, Z);
	}

	/* ============= [ Armas Brancas ] ============= */     
	if(!strcmp(ItemName,"Baseball Bat",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(37, X, Y, Z);
	}

	if(!strcmp(ItemName,"Katana",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(38, X, Y, Z);
	}

	if(!strcmp(ItemName,"Faca AK-47",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(39, X, Y, Z);
	}

	if(!strcmp(ItemName,"Pa",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(40, X, Y, Z);
	}

	/* ============= [ Granadas ] ============= */
	if(!strcmp(ItemName,"Granada",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(41, X, Y, Z);
	}

	/* ============= [ Munições ] ============= */
	if(!strcmp(ItemName,"Celular",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(46, X, Y, Z);
	}

	/* ============= [ Variados ] ============= */
	if(!strcmp(ItemName,"Roupa",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(48, X, Y, Z);
	}

	if(!strcmp(ItemName,"Motor",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(49, X, Y, Z);
	}

	if(!strcmp(ItemName,"Toolbox",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(50, X, Y, Z);
	}

	if(!strcmp(ItemName,"Radio",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(51, X, Y, Z);
	}

	if(!strcmp(ItemName,"Colete",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(52, X, Y, Z);
	}

	if(!strcmp(ItemName,"Mascara de gas",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(53, X, Y, Z);
	}	

	if(!strcmp(ItemName,"Capacete",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(54, X, Y, Z);
	}	

	if(!strcmp(ItemName,"Galao vazio",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(59, X, Y, Z);
	}

	/* ============= [ Vazios ] ============= */
	if(!strcmp(ItemName,"Garrafa vazia",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(3, X, Y, Z);
	}

	if(!strcmp(ItemName,"isqueiro",true))
	{
		RemoveItem(playerid, ItemName, 1);
		CreateDrop(56, X, Y, Z);
	}
	if(!strcmp(ItemName,"TNT", true))
	{
	    RemoveItem(playerid, ItemName, 1);
	    CreateDrop(61, X, Y, Z);
	}
	if(!strcmp(ItemName,"Galao de combustivel", true))
	{
	    RemoveItem(playerid, ItemName, 1);
	    CreateDrop(55, X, Y, Z);
	}
	if(!strcmp(ItemName,"TNT Cronometrada", true))
	{
	    RemoveItem(playerid, ItemName, 1);
	    CreateDrop(67, X, Y, Z);
	}
	if(!strcmp(ItemName,"Chave de fenda", true))
	{
	    RemoveItem(playerid, ItemName, 1);
	    CreateDrop(42, X, Y, Z);
	}
	if(!strcmp(ItemName,"Martelo", true))
	{
	    RemoveItem(playerid, ItemName, 1);
	    CreateDrop(43, X, Y, Z);
	}
	if(!strcmp(ItemName,"Motoserra", true))
	{
	    RemoveItem(playerid, ItemName, 1);
	    CreateDrop(44, X, Y, Z);
	}
	if(!strcmp(ItemName,"Dinheiro", true))
	{
	    RemoveItem(playerid, ItemName, 1);
	    CreateDrop(45, X, Y, Z);
	}
	if(!strcmp(ItemName,"Fogueira", true))
	{
	    RemoveItem(playerid, ItemName, 1);
	    CreateDrop(68, X, Y, Z);
	}
	return 1;
}

stock ForceDrop(playerid)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);

    for(new i; i < 99; i++)
    {
    	if(PlayerHasItem(playerid, ItemInfo[i][Item_Name]))
    	{
    		CreateDrop(ItemInfo[i][Item_ID], X+random(3), Y+random(5), Z);
    	}
    }
	return 1;
}

public OnPlayerPickupItemFromDrop(playerid)
{
	for(new i; i < MAX_DROPS; i++) 
	{
		if(IsPlayerInRangeOfPoint(playerid, 1.5, DropInfo[i][dPosX], DropInfo[i][dPosY], DropInfo[i][dPosZ]))
		{
			new str[80],
			    itemid = DropInfo[i][DropItemID];

            format(str, sizeof(str), "~w~(~y~%s~w~)~n~ Adicionado ao inventario", ItemInfo[itemid][Item_Name]);
			GameTextForPlayer(playerid,str,2500,4);
		    AddItem(playerid, ItemInfo[itemid][Item_Name], 1);
		    DestroyDrop(i);
			return 1;
		}
	}
	return 1;
}

public Item_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		if(PRESSED(KEY_SECONDARY_ATTACK))
		{
			for(new i; i < MAX_DROPS; i++) 
			{
				if(IsPlayerInRangeOfPoint(playerid, 1.5, DropInfo[i][dPosX], DropInfo[i][dPosY], DropInfo[i][dPosZ]))
				{
					if(GetPlayerState(playerid) != SPECIAL_ACTION_DUCK) return SendClientMessage(playerid, COR_CINZA, Translate(pInfo[playerid][pIdioma], "[LOOT]: Você precisa estar agaixado para pegar este item.", "[LOOT]: You need to be crouched to pick up this item."));

					new str[80], 
					    itemid = DropInfo[i][DropItemID];

					format(str, sizeof(str), "{FFFFFF}# {27E6E6}%s {FFFFFF}#", ItemInfo[itemid][Item_Name]);
					
					ShowPlayerDialog(playerid, D_PegarItem, DIALOG_STYLE_MSGBOX, str, "{FFFFFF}Voce deseja pegar este item?", "Pegar", "Fechar");
				}
			}
		}
		if(PRESSED(KEY_YES))
		{
		    if(curandosegundos[playerid] > 0) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce esta se curando");
		    if(caido[playerid] == true) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce esta caido");
		    PodeArma[playerid] = 1;
	 		ShowInventory(playerid);
	 		ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.1,0,0,0,1,0,1);
	 		switch(pInfo[playerid][pBackpack])
	 		{
	 		    case 5: SetPlayerAttachedObject(playerid, 0, 363, 5, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
	 		    case 10: SetPlayerAttachedObject(playerid, 0, 3026, 5, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
				case 16: SetPlayerAttachedObject(playerid, 0, 1310, 5, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
				case 24: SetPlayerAttachedObject(playerid, 0, 19559, 5, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
				case 32: SetPlayerAttachedObject(playerid, 0, 1550, 5, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
				default: RemovePlayerAttachedObject(playerid, 0);
			}
		}
	}
	return 1;
}

public Item_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case D_PegarItem:
		{
			if(response) 
			{
				// Se os slots usados for igual aos slots totais manda a msg
				if(pInfo[playerid][pSlots] == pInfo[playerid][pBackpack]) return GameTextForPlayer(playerid,"~r~Mochila cheia",1000,4);
				OnPlayerPickupItemFromDrop(playerid);
			}
		}
	}
	return 1;
}

stock DestroyDrop(dropid)
{
	DropInfo[dropid][dPosX] = 0.0;
	DropInfo[dropid][dPosY] = 0.0; 
	DropInfo[dropid][dPosZ] = 0.0;

	DropInfo[dropid][DropItemID] = -1;

	DestroyDynamicObject(DropInfo[dropid][DropObj]);
	DestroyDynamic3DTextLabel(DropInfo[dropid][DropLabel]);
	return 1;
}

stock CreateDrop(itemid, Float:X, Float:Y, Float:Z)
{
    if(itemid != -1)
    {
    	for(new i; i < MAX_DROPS; i++) 
    	{
    		if(DropInfo[i][dPosX] == 0.0 && DropInfo[i][dPosY] == 0.0 && DropInfo[i][dPosZ] == 0.0)
    		{
    			new str[100];

    			DropInfo[i][dPosX] = X, DropInfo[i][dPosY] = Y, DropInfo[i][dPosZ] = Z-0.92;

    			DropInfo[i][DropItemID] = itemid;

    			format(str, sizeof(str), "{FFFFFF}[{27E6E6}%s{FFFFFF}]\nAperte [{27E6E6}F{FFFFFF}] {FFFFFF}para pegar.", ItemInfo[itemid][Item_Name]);
    			DropInfo[i][DropLabel] = CreateDynamic3DTextLabel(str, -1, DropInfo[i][dPosX], DropInfo[i][dPosY], DropInfo[i][dPosZ], 1.5);
    			DropInfo[i][DropObj] = CreateDynamicObject(ItemInfo[itemid][Item_Obj], DropInfo[i][dPosX], DropInfo[i][dPosY], DropInfo[i][dPosZ], ItemInfo[itemid][Item_RotX], ItemInfo[itemid][Item_RotY], ItemInfo[itemid][Item_RotZ]);
    			return 1;
    		}
    	}
    }
	return 0;
}
