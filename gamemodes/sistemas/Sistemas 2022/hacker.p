CMD:hacker(playerid, params[])
{
    if(!PlayerInfo[playerid][pLogado]) return 1;
 	if(PlayerInfo[playerid][pJob] != JOB_HACK) return SCM(playerid, COLOR_LIGHTRED, "ERRO:{FFFFFF} Voc� n�o � um hacker.");
	if(complexid == -1) return SendClientMessage(playerid, COLOR_LIGHTRED, "ERRO:{FFFFFF} Voc� n�o est� em um complexo.");
	if(PlayerInfo[playerid][pArrombarDNV_C] != 0)
	{
		new stringhack[128];
		format(stringhack, sizeof(stringhack),"Aguarde %d segundos antes de hackear novamente.", PlayerInfo[playerid][pArrombarDNV_C]);
		SendClientMessage(playerid,COLOR_LIGHTRED, stringhack);
		return 1;
	}
	{
		if(PlayerInfo[playerid][pJob] != JOB_HACK)
        {
			SendClientMessage(playerid,COLOR_WHITE,"Voc� iniciou um trabalho de hacker e n�o pode usar este comando.");
			return 1;
		}
		HackerJob[playerid] = 1;
		new string[128];
    	SendClientMessage(playerid,COLOR_WHITE,"Voc� iniciou um trabalho de hacker.");
        HJLimitTimer = SetTimerEx("HJTimeLimit", 300000, 0, "d", playerid);
        HackerSetup(playerid);
        return 1;
   	}
	return 1;
}

forward HJTimeLimit(playerid);
public HJTimeLimit(playerid)
{
    
	ShowPlayerDialog(playerid,-1,0,"","","","");
	HackerJob[playerid] = 0;
	SendClientMessage(playerid,COLOR_WHITE,"O tempo de trabalho acabou e voc� n�o terminou.");
	return 1;
}
forward HackerSetup(playerid);
public HackerSetup(playerid)
{
    SetPlayerVirtualWorld(playerid, playerid+1);
    SetPlayerInterior(playerid,1);
    SetPlayerPos(playerid, 2164.7,1601.9,999.9);
	SetPlayerFacingAngle(playerid, 263.0);
	SetPlayerCameraPos(playerid, 2163.5,1601.9,1000.8);
	SetPlayerCameraLookAt(playerid, 2172.7,1601.9,999.9);
    ApplyAnimation(playerid,"INT_OFFICE","OFF_Sit_Type_Loop", 4.0, 1, 0, 0, 0, 0);
	SetTimerEx("HackerOne", 3000, 0, "d", playerid);
}
 
forward HackerOne(playerid);
public HackerOne(playerid)
{
    PlayerPlaySound( playerid, 1058, 0, 0, 0 );
    SetPlayerCameraLookAt(playerid, 2172.1,1601.7,999.9);
	ShowPlayerDialog(playerid, 1998, DIALOG_STYLE_INPUT, "root@localhost:~", "Login as: root\nO sistema est� pronto para invadir um centro importante\nDigite 'BEGAN' para lan�ar ataques", "Enviar", "Cancelar");
}
 
forward HackerTwo(playerid);
public HackerTwo(playerid)
{
    PlayerPlaySound( playerid, 1058, 0, 0, 0 );
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0);
    GameTextForPlayer(playerid,"~p~SUCESSO",1000,6);
	ShowPlayerDialog(playerid, 1999, DIALOG_STYLE_INPUT, "root@localhost:~", "Login as: root\nO sistema est� pronto para invadir um centro importante\nDigite 'KEYGEN' para lan�ar ataques", "Enviar", "Cancelar");
}
 
forward HackerThree(playerid);
public HackerThree(playerid)
{
    PlayerPlaySound( playerid, 1058, 0, 0, 0 );
    GameTextForPlayer(playerid,"~p~SUCESSO",1000,6);
	ShowPlayerDialog(playerid, 2000, DIALOG_STYLE_INPUT, "root@localhost:~", "Login as: root\nO sistema est� pronto para invadir um centro importante\nDigite 'CRACKED' para lan�ar ataques", "Enviar", "Cancelar");
}
forward HackerFour(playerid);
public HackerFour(playerid)
{
    PlayerPlaySound( playerid, 1058, 0, 0, 0 );
    GameTextForPlayer(playerid,"~p~SUCESSO",1000,6);
	ShowPlayerDialog(playerid, 2001, DIALOG_STYLE_INPUT, "root@localhost:~", "Login as: root\nO sistema est� pronto para invadir um centro importante\nDigite 'WORN' para lan�ar ataques", "Enviar", "Cancelar");
}
forward HackerFive(playerid);
public HackerFive(playerid)
{
    PlayerPlaySound( playerid, 1058, 0, 0, 0 );
    GameTextForPlayer(playerid,"~p~SUCESSO",1000,6);
	ShowPlayerDialog(playerid, 2002, DIALOG_STYLE_INPUT, "root@localhost:~", "Login as: root\nO sistema est� pronto para invadir um centro importante\nTDigite 'VIRUS' para lan�ar ataques", "Enviar", "Cancelar");
}
 
forward HackerSix(playerid);
public HackerSix(playerid)
{
    PlayerPlaySound( playerid, 1058, 0, 0, 0 );
    GameTextForPlayer(playerid,"~p~SUCESSO",1000,6);
	ShowPlayerDialog(playerid, 2003, DIALOG_STYLE_INPUT, "root@localhost:~", "Login as: root\nO sistema est� pronto para invadir um centro importante\nDigite 'TROJAN' para lan�ar ataques", "Enviar", "Cancelar");
}
 
forward HackerSeven(playerid);
public HackerSeven(playerid)
{
    KillTimer(HJLimitTimer);
    PlayerPlaySound( playerid, 1058, 0, 0, 0 );
    SetPlayerVirtualWorld(playerid, playerid+1);
    SetPlayerInterior(playerid,1);
    SetPlayerPos(playerid, 2164.7,1601.9,999.9);
	SetPlayerFacingAngle(playerid, 263.0);
	SetPlayerCameraPos(playerid, 2163.5,1601.9,1000.8);
	SetPlayerCameraLookAt(playerid, 2172.7,1601.9,999.9);
	ApplyAnimation(playerid,"CASINO","Roulette_win", 4.0, 1, 0, 0, 0, 0);
    GameTextForPlayer(playerid,"~p~SUCESSO",2000,6);
	SendClientMessage(playerid,COLOR_WHITE,"Voc� ganhou 760 reais pelo servi�o.");
    PlayerInfo[playerid][pGrana] += 760;
    SetTimerEx("HackerSuccesed", 3000, 0, "d", playerid);
 
}
 
forward HackerSuccesed(playerid);
public HackerSuccesed(playerid)
{
    TogglePlayerControllable(playerid,true);
	HackerJob[playerid] = 0;
    return 1;
}
