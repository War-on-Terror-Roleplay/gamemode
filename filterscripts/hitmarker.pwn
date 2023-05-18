// SA:MP Hitmarker v1


#include <a_samp>

new bool:isCreated[MAX_PLAYERS];
new bool:isShown[MAX_PLAYERS];
new bool:isAiming[MAX_PLAYERS];

new PlayerText:LeftUpper;
new PlayerText:RightUpper;
new PlayerText:RightLower;
new PlayerText:LeftLower;

new PlayerText:SniperLeftUpper;
new PlayerText:SniperRightUpper;
new PlayerText:SniperLeftLower;
new PlayerText:SniperRightLower;

forward DisappearTimer(playerid);

#define PRESSED(%0) \
   (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))




public OnPlayerDisconnect(playerid, reason)
{
	isShown[playerid] = false;
	isCreated[playerid] = false;
	isAiming[playerid] = false;
	PlayerTextDrawDestroy(playerid, LeftUpper);
	PlayerTextDrawDestroy(playerid, LeftLower);
	PlayerTextDrawDestroy(playerid, RightUpper);
	PlayerTextDrawDestroy(playerid, RightLower);

	PlayerTextDrawDestroy(playerid, SniperLeftUpper);
	PlayerTextDrawDestroy(playerid, SniperLeftLower);
	PlayerTextDrawDestroy(playerid, SniperRightUpper);
	PlayerTextDrawDestroy(playerid, SniperRightLower);
	return 1;
}

public OnFilterScriptExit()
{
	for(new playerid = 0; playerid < GetMaxPlayers()+1; playerid++)
	{
		isShown[playerid] = false;
		isCreated[playerid] = false;
		isAiming[playerid] = false;
		PlayerTextDrawDestroy(playerid, LeftUpper);
		PlayerTextDrawDestroy(playerid, LeftLower);
		PlayerTextDrawDestroy(playerid, RightUpper);
		PlayerTextDrawDestroy(playerid, RightLower);

		PlayerTextDrawDestroy(playerid, SniperLeftUpper);
		PlayerTextDrawDestroy(playerid, SniperLeftLower);
		PlayerTextDrawDestroy(playerid, SniperRightUpper);
		PlayerTextDrawDestroy(playerid, SniperRightLower);
	}

	return 1;
}



public OnPlayerSpawn(playerid)
{
	InitTextDraws(playerid);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((PRESSED(KEY_HANDBRAKE)) && (GetPlayerWeapon(playerid) == WEAPON_SNIPER))
	{
	    isAiming[playerid] = true;
	}
	else if((RELEASED(KEY_HANDBRAKE)) && (GetPlayerWeapon(playerid) == WEAPON_SNIPER))
	{
		isAiming[playerid] = false;
	}

	
	

	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{

	ShowHitMarker(playerid);
	PlayerPlaySound(playerid, 1135, 0.0, 0.0, 0.0);

	return 1;
}

stock ShowHitMarker(playerid)
{
	if(isShown[playerid] == false)
	{
 		isShown[playerid] = true;
		SetTimerEx("DisappearTimer", 2500, 0, "d", playerid);

	    if((isAiming[playerid] == true) && (GetPlayerWeapon(playerid) == WEAPON_SNIPER))
	    {
	   		PlayerTextDrawShow(playerid, SniperLeftUpper);
			PlayerTextDrawShow(playerid, SniperLeftLower);
			PlayerTextDrawShow(playerid, SniperRightUpper);
			PlayerTextDrawShow(playerid, SniperRightLower);
	 	}
	 	else
		{
			PlayerTextDrawShow(playerid, LeftUpper);
			PlayerTextDrawShow(playerid, LeftLower);
			PlayerTextDrawShow(playerid, RightUpper);
			PlayerTextDrawShow(playerid, RightLower);
		}
	}

}

public DisappearTimer(playerid)
{
	isShown[playerid] = false;
	PlayerTextDrawHide(playerid, LeftUpper);
	PlayerTextDrawHide(playerid, LeftLower);
	PlayerTextDrawHide(playerid, RightUpper);
	PlayerTextDrawHide(playerid, RightLower);
	
	PlayerTextDrawHide(playerid, SniperLeftUpper);
	PlayerTextDrawHide(playerid, SniperLeftLower);
	PlayerTextDrawHide(playerid, SniperRightUpper);
	PlayerTextDrawHide(playerid, SniperRightLower);
}


stock InitTextDraws(playerid)
{
	if(isCreated[playerid] == false)
	{
		isCreated[playerid] = true;
		LeftUpper = CreatePlayerTextDraw(playerid,332.000000, 182.000000, "/");
		PlayerTextDrawBackgroundColor(playerid,LeftUpper, 255);
		PlayerTextDrawFont(playerid,LeftUpper, 2);
		PlayerTextDrawLetterSize(playerid,LeftUpper, 0.270000, 0.699999);
		PlayerTextDrawColor(playerid,LeftUpper, -1);
		PlayerTextDrawSetOutline(playerid,LeftUpper, 1);
		PlayerTextDrawSetProportional(playerid,LeftUpper, 1);
		PlayerTextDrawSetSelectable(playerid,LeftUpper, 0);

		RightUpper = CreatePlayerTextDraw(playerid, 342.000000, 182.000000, "\\");
		PlayerTextDrawBackgroundColor(playerid,RightUpper, 255);
		PlayerTextDrawFont(playerid,RightUpper, 2);
		PlayerTextDrawLetterSize(playerid,RightUpper, 0.270000, 0.699999);
		PlayerTextDrawColor(playerid,RightUpper, -1);
		PlayerTextDrawSetOutline(playerid,RightUpper, 1);
		PlayerTextDrawSetProportional(playerid,RightUpper, 1);
		PlayerTextDrawSetSelectable(playerid,RightUpper, 0);

		RightLower = CreatePlayerTextDraw(playerid,342.000000, 171.000000, "/");
		PlayerTextDrawBackgroundColor(playerid,RightLower, 255);
		PlayerTextDrawFont(playerid,RightLower, 2);
		PlayerTextDrawLetterSize(playerid,RightLower, 0.270000, 0.699999);
		PlayerTextDrawColor(playerid,RightLower, -1);
		PlayerTextDrawSetOutline(playerid,RightLower, 1);
		PlayerTextDrawSetProportional(playerid,RightLower, 1);
		PlayerTextDrawSetSelectable(playerid,RightLower, 0);

		LeftLower = CreatePlayerTextDraw(playerid,332.000000, 171.000000, "\\");
		PlayerTextDrawBackgroundColor(playerid,LeftLower, 255);
		PlayerTextDrawFont(playerid,LeftLower, 2);
		PlayerTextDrawLetterSize(playerid,LeftLower, 0.270000, 0.699999);
		PlayerTextDrawColor(playerid,LeftLower, -1);
		PlayerTextDrawSetOutline(playerid,LeftLower, 1);
		PlayerTextDrawSetProportional(playerid,LeftLower, 1);
		PlayerTextDrawSetSelectable(playerid,LeftLower, 0);
		
		
		SniperLeftUpper = CreatePlayerTextDraw(playerid,313.000000, 226.000000, "/");
		PlayerTextDrawBackgroundColor(playerid,SniperLeftUpper, 255);
		PlayerTextDrawFont(playerid,SniperLeftUpper, 2);
		PlayerTextDrawLetterSize(playerid,SniperLeftUpper, 0.270000, 0.699999);
		PlayerTextDrawColor(playerid,SniperLeftUpper, -1);
		PlayerTextDrawSetOutline(playerid,SniperLeftUpper, 1);
		PlayerTextDrawSetProportional(playerid,SniperLeftUpper, 1);
		PlayerTextDrawSetSelectable(playerid,SniperLeftUpper, 0);

		SniperRightUpper = CreatePlayerTextDraw(playerid,323.000000, 226.000000, "\\");
		PlayerTextDrawBackgroundColor(playerid,SniperRightUpper, 255);
		PlayerTextDrawFont(playerid,SniperRightUpper, 2);
		PlayerTextDrawLetterSize(playerid,SniperRightUpper, 0.270000, 0.699999);
		PlayerTextDrawColor(playerid,SniperRightUpper, -1);
		PlayerTextDrawSetOutline(playerid,SniperRightUpper, 1);
		PlayerTextDrawSetProportional(playerid,SniperRightUpper, 1);
		PlayerTextDrawSetSelectable(playerid,SniperRightUpper, 0);

		SniperLeftLower = CreatePlayerTextDraw(playerid,313.000000, 215.000000, "\\" );
		PlayerTextDrawBackgroundColor(playerid,SniperLeftLower, 255);
		PlayerTextDrawFont(playerid,SniperLeftLower, 2);
		PlayerTextDrawLetterSize(playerid,SniperLeftLower, 0.270000, 0.699999);
		PlayerTextDrawColor(playerid,SniperLeftLower, -1);
		PlayerTextDrawSetOutline(playerid,SniperLeftLower, 1);
		PlayerTextDrawSetProportional(playerid,SniperLeftLower, 1);
		PlayerTextDrawSetSelectable(playerid,SniperLeftLower, 0);

		SniperRightLower = CreatePlayerTextDraw(playerid,323.000000, 215.000000, "/");
		PlayerTextDrawBackgroundColor(playerid,SniperRightLower, 255);
		PlayerTextDrawFont(playerid,SniperRightLower, 2);
		PlayerTextDrawLetterSize(playerid,SniperRightLower, 0.270000, 0.699999);
		PlayerTextDrawColor(playerid,SniperRightLower, -1);
		PlayerTextDrawSetOutline(playerid,SniperRightLower, 1);
		PlayerTextDrawSetProportional(playerid,SniperRightLower, 1);
		PlayerTextDrawSetSelectable(playerid,SniperRightLower, 0);

		PlayerTextDrawHide(playerid, LeftUpper);
		PlayerTextDrawHide(playerid, LeftLower);
		PlayerTextDrawHide(playerid, RightUpper);
		PlayerTextDrawHide(playerid, RightLower);
	}
	
}