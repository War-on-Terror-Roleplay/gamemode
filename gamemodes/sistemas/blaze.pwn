#include <a_samp>
#include <zcmd>
 
#if defined FILTERSCRIPT
 
public OnFilterScriptInit()
{
	return 1;
}
 
public OnFilterScriptExit()
{
	TextDrawDestroy(BlazeDimas[0]);
	TextDrawDestroy(BlazeDimas[1]);
	TextDrawDestroy(BlazeDimas[2]);
	TextDrawDestroy(BlazeDimas[3]);
	TextDrawDestroy(BlazeDimas[4]);
	TextDrawDestroy(BlazeDimas[5]);
	TextDrawDestroy(BlazeDimas[6]);
	TextDrawDestroy(BlazeDimas[7]);
	TextDrawDestroy(BlazeDimas[8]);
	TextDrawDestroy(BlazeDimas[9]);
	TextDrawDestroy(BlazeDimas[10]);
	TextDrawDestroy(BlazeDimas[11]);
	TextDrawDestroy(BlazeDimas[12]);
	TextDrawDestroy(BlazeDimas[13]);
	TextDrawDestroy(BlazeDimas[14]);
	TextDrawDestroy(BlazeDimas[15]);
	TextDrawDestroy(BlazeDimas[16]);
	TextDrawDestroy(BlazeDimas[17]);
	TextDrawDestroy(BlazeDimas[18]);
	TextDrawDestroy(BlazeDimas[19]);
	TextDrawDestroy(BlazeDimas[20]);
	TextDrawDestroy(BlazeDimas[21]);
	TextDrawDestroy(BlazeDimas[22]);
	TextDrawDestroy(BlazeDimas[23]);
	TextDrawDestroy(textdraw_16);
	TextDrawDestroy(textdraw_18);
	TextDrawDestroy(textdraw_17);
	return 1;
}
 
#else
 
main()
{
	print("\n----------------------------------");
	print(" Desenvolvida por: Yoshi_ PAWN EXPRESS, NUNCA REMOVA OS CRÉDITOS");
	print("----------------------------------\n");
}
 
new Text:BlazeDimas[24];
new PlayerText:BlazeDimasP[MAX_PLAYERS][14];
new Text:textdraw_16;
new Text:textdraw_18;
new Text:textdraw_17;
 
new
    PlayerWin[MAX_PLAYERS],
    GameOwer[MAX_PLAYERS],
    Mode[MAX_PLAYERS] = 2,
    InGame[MAX_PLAYERS] = 0,
    clicked_td[MAX_PLAYERS][14],
	Money_Win[MAX_PLAYERS];
 
#endif
 
public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Yoshi PAWN EXPRES");
	//AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
 
	BlazeDimas[0] = TextDrawCreate(385.000000, 201.000000, "ld_dual:light");
	TextDrawFont(BlazeDimas[0], 4);
	TextDrawLetterSize(BlazeDimas[0], 0.600000, 2.000000);
	TextDrawTextSize(BlazeDimas[0], -5.500000, 9.000000);
	TextDrawSetOutline(BlazeDimas[0], 1);
	TextDrawSetShadow(BlazeDimas[0], 0);
	TextDrawAlignment(BlazeDimas[0], 1);
	TextDrawColor(BlazeDimas[0], 255);
	TextDrawBackgroundColor(BlazeDimas[0], 255);
	TextDrawBoxColor(BlazeDimas[0], 50);
	TextDrawUseBox(BlazeDimas[0], 1);
	TextDrawSetProportional(BlazeDimas[0], 1);
	TextDrawSetSelectable(BlazeDimas[0], 0);
 
	BlazeDimas[1] = TextDrawCreate(387.000000, 390.000000, "ld_dual:light");
	TextDrawFont(BlazeDimas[1], 4);
	TextDrawLetterSize(BlazeDimas[1], 0.600000, 2.000000);
	TextDrawTextSize(BlazeDimas[1], -7.500000, 9.000000);
	TextDrawSetOutline(BlazeDimas[1], 1);
	TextDrawSetShadow(BlazeDimas[1], 0);
	TextDrawAlignment(BlazeDimas[1], 1);
	TextDrawColor(BlazeDimas[1], 255);
	TextDrawBackgroundColor(BlazeDimas[1], 255);
	TextDrawBoxColor(BlazeDimas[1], 50);
	TextDrawUseBox(BlazeDimas[1], 1);
	TextDrawSetProportional(BlazeDimas[1], 1);
	TextDrawSetSelectable(BlazeDimas[1], 0);
 
	BlazeDimas[2] = TextDrawCreate(469.000000, 390.000000, "ld_dual:light");
	TextDrawFont(BlazeDimas[2], 4);
	TextDrawLetterSize(BlazeDimas[2], 0.600000, 2.000000);
	TextDrawTextSize(BlazeDimas[2], -7.500000, 9.000000);
	TextDrawSetOutline(BlazeDimas[2], 1);
	TextDrawSetShadow(BlazeDimas[2], 0);
	TextDrawAlignment(BlazeDimas[2], 1);
	TextDrawColor(BlazeDimas[2], 255);
	TextDrawBackgroundColor(BlazeDimas[2], 255);
	TextDrawBoxColor(BlazeDimas[2], 50);
	TextDrawUseBox(BlazeDimas[2], 1);
	TextDrawSetProportional(BlazeDimas[2], 1);
	TextDrawSetSelectable(BlazeDimas[2], 0);
 
	BlazeDimas[3] = TextDrawCreate(461.000000, 201.000000, "ld_dual:light");
	TextDrawFont(BlazeDimas[3], 4);
	TextDrawLetterSize(BlazeDimas[3], 0.600000, 2.000000);
	TextDrawTextSize(BlazeDimas[3], 8.000000, 9.000000);
	TextDrawSetOutline(BlazeDimas[3], 1);
	TextDrawSetShadow(BlazeDimas[3], 0);
	TextDrawAlignment(BlazeDimas[3], 1);
	TextDrawColor(BlazeDimas[3], 255);
	TextDrawBackgroundColor(BlazeDimas[3], 255);
	TextDrawBoxColor(BlazeDimas[3], 50);
	TextDrawUseBox(BlazeDimas[3], 1);
	TextDrawSetProportional(BlazeDimas[3], 1);
	TextDrawSetSelectable(BlazeDimas[3], 0);
 
	BlazeDimas[4] = TextDrawCreate(424.000000, 205.000000, "_");
	TextDrawFont(BlazeDimas[4], 0);
	TextDrawLetterSize(BlazeDimas[4], 0.600000, -0.699997);
	TextDrawTextSize(BlazeDimas[4], 298.500000, 76.500000);
	TextDrawSetOutline(BlazeDimas[4], 1);
	TextDrawSetShadow(BlazeDimas[4], 0);
	TextDrawAlignment(BlazeDimas[4], 2);
	TextDrawColor(BlazeDimas[4], -1);
	TextDrawBackgroundColor(BlazeDimas[4], 255);
	TextDrawBoxColor(BlazeDimas[4], 255);
	TextDrawUseBox(BlazeDimas[4], 1);
	TextDrawSetProportional(BlazeDimas[4], 1);
	TextDrawSetSelectable(BlazeDimas[4], 0);
 
	BlazeDimas[5] = TextDrawCreate(424.000000, 401.000000, "_");
	TextDrawFont(BlazeDimas[5], 0);
	TextDrawLetterSize(BlazeDimas[5], 0.600000, -0.699997);
	TextDrawTextSize(BlazeDimas[5], 298.500000, 77.000000);
	TextDrawSetOutline(BlazeDimas[5], 1);
	TextDrawSetShadow(BlazeDimas[5], 0);
	TextDrawAlignment(BlazeDimas[5], 2);
	TextDrawColor(BlazeDimas[5], -1);
	TextDrawBackgroundColor(BlazeDimas[5], 255);
	TextDrawBoxColor(BlazeDimas[5], 255);
	TextDrawUseBox(BlazeDimas[5], 1);
	TextDrawSetProportional(BlazeDimas[5], 1);
	TextDrawSetSelectable(BlazeDimas[5], 0);
 
	BlazeDimas[6] = TextDrawCreate(381.000000, 208.000000, "_");
	TextDrawFont(BlazeDimas[6], 0);
	TextDrawLetterSize(BlazeDimas[6], 0.600000, 20.449977);
	TextDrawTextSize(BlazeDimas[6], 298.500000, -1.000000);
	TextDrawSetOutline(BlazeDimas[6], 1);
	TextDrawSetShadow(BlazeDimas[6], 0);
	TextDrawAlignment(BlazeDimas[6], 2);
	TextDrawColor(BlazeDimas[6], -1);
	TextDrawBackgroundColor(BlazeDimas[6], 255);
	TextDrawBoxColor(BlazeDimas[6], 255);
	TextDrawUseBox(BlazeDimas[6], 1);
	TextDrawSetProportional(BlazeDimas[6], 1);
	TextDrawSetSelectable(BlazeDimas[6], 0);
 
	BlazeDimas[7] = TextDrawCreate(468.000000, 208.000000, "_");
	TextDrawFont(BlazeDimas[7], 0);
	TextDrawLetterSize(BlazeDimas[7], 0.595833, 20.549976);
	TextDrawTextSize(BlazeDimas[7], 298.500000, -1.500000);
	TextDrawSetOutline(BlazeDimas[7], 1);
	TextDrawSetShadow(BlazeDimas[7], 0);
	TextDrawAlignment(BlazeDimas[7], 2);
	TextDrawColor(BlazeDimas[7], -1);
	TextDrawBackgroundColor(BlazeDimas[7], 255);
	TextDrawBoxColor(BlazeDimas[7], 255);
	TextDrawUseBox(BlazeDimas[7], 1);
	TextDrawSetProportional(BlazeDimas[7], 1);
	TextDrawSetSelectable(BlazeDimas[7], 0);
 
	BlazeDimas[8] = TextDrawCreate(424.000000, 400.000000, "_");
	TextDrawFont(BlazeDimas[8], 0);
	TextDrawLetterSize(BlazeDimas[8], 0.600000, -22.399993);
	TextDrawTextSize(BlazeDimas[8], 298.500000, 79.500000);
	TextDrawSetOutline(BlazeDimas[8], 1);
	TextDrawSetShadow(BlazeDimas[8], 0);
	TextDrawAlignment(BlazeDimas[8], 2);
	TextDrawColor(BlazeDimas[8], -1);
	TextDrawBackgroundColor(BlazeDimas[8], 255);
	TextDrawBoxColor(BlazeDimas[8], 255);
	TextDrawUseBox(BlazeDimas[8], 1);
	TextDrawSetProportional(BlazeDimas[8], 1);
	TextDrawSetSelectable(BlazeDimas[8], 0);
 
	BlazeDimas[9] = TextDrawCreate(466.000000, 397.000000, "_");
	TextDrawFont(BlazeDimas[9], 0);
	TextDrawLetterSize(BlazeDimas[9], 0.600000, -21.599998);
	TextDrawTextSize(BlazeDimas[9], 298.500000, -0.500000);
	TextDrawSetOutline(BlazeDimas[9], 1);
	TextDrawSetShadow(BlazeDimas[9], 0);
	TextDrawAlignment(BlazeDimas[9], 2);
	TextDrawColor(BlazeDimas[9], -1);
	TextDrawBackgroundColor(BlazeDimas[9], 255);
	TextDrawBoxColor(BlazeDimas[9], 255);
	TextDrawUseBox(BlazeDimas[9], 1);
	TextDrawSetProportional(BlazeDimas[9], 1);
	TextDrawSetSelectable(BlazeDimas[9], 0);
 
	BlazeDimas[10] = TextDrawCreate(425.000000, 390.000000, "O");
	TextDrawFont(BlazeDimas[10], 2);
	TextDrawLetterSize(BlazeDimas[10], 0.258332, 0.800000);
	TextDrawTextSize(BlazeDimas[10], 16.500000, 7.000000);
	TextDrawSetOutline(BlazeDimas[10], 0);
	TextDrawSetShadow(BlazeDimas[10], 0);
	TextDrawAlignment(BlazeDimas[10], 2);
	TextDrawColor(BlazeDimas[10], -1);
	TextDrawBackgroundColor(BlazeDimas[10], 255);
	TextDrawBoxColor(BlazeDimas[10], 9109759);
	TextDrawUseBox(BlazeDimas[10], 0);
	TextDrawSetProportional(BlazeDimas[10], 0);
	TextDrawSetSelectable(BlazeDimas[10], 1);
 
	textdraw_16 = TextDrawCreate(392.000000, 390.000000, "<");
	TextDrawFont(textdraw_16, 2);
	TextDrawLetterSize(textdraw_16, 0.266665, 0.750000);
	TextDrawTextSize(textdraw_16, 16.500000, 7.000000);
	TextDrawSetOutline(textdraw_16, 0);
	TextDrawSetShadow(textdraw_16, 0);
	TextDrawAlignment(textdraw_16, 2);
	TextDrawColor(textdraw_16, -1);
	TextDrawBackgroundColor(textdraw_16, 255);
	TextDrawBoxColor(textdraw_16, 9109759);
	TextDrawUseBox(textdraw_16, 0);
	TextDrawSetProportional(textdraw_16, 0);
	TextDrawSetSelectable(textdraw_16, 1);
 
	textdraw_18 = TextDrawCreate(453.000000, 390.000000, "X");
	TextDrawFont(textdraw_18, 2);
	TextDrawLetterSize(textdraw_18, 0.258332, 0.800000);
	TextDrawTextSize(textdraw_18, 16.500000, 7.000000);
	TextDrawSetOutline(textdraw_18, 0);
	TextDrawSetShadow(textdraw_18, 0);
	TextDrawAlignment(textdraw_18, 2);
	TextDrawColor(textdraw_18, -1);
	TextDrawBackgroundColor(textdraw_18, 255);
	TextDrawBoxColor(textdraw_18, 9109759);
	TextDrawUseBox(textdraw_18, 0);
	TextDrawSetProportional(textdraw_18, 0);
	TextDrawSetSelectable(textdraw_18, 1);
 
	textdraw_17 = TextDrawCreate(424.000000, 210.000000, "_");
	TextDrawFont(textdraw_17, 2);
	TextDrawLetterSize(textdraw_17, 0.600000, 19.449996);
	TextDrawTextSize(textdraw_17, 298.500000, 83.000000);
	TextDrawSetOutline(textdraw_17, 2);
	TextDrawSetShadow(textdraw_17, 0);
	TextDrawAlignment(textdraw_17, 2);
	TextDrawColor(textdraw_17, -1);
	TextDrawBackgroundColor(textdraw_17, 255);
	TextDrawBoxColor(textdraw_17, 437918463);
	TextDrawUseBox(textdraw_17, 1);
	TextDrawSetProportional(textdraw_17, 1);
	TextDrawSetSelectable(textdraw_17, 0);
 
	BlazeDimas[11] = TextDrawCreate(424.000000, 212.000000, "_");
	TextDrawFont(BlazeDimas[11], 2);
	TextDrawLetterSize(BlazeDimas[11], 0.600000, 9.350009);
	TextDrawTextSize(BlazeDimas[11], 298.500000, 82.500000);
	TextDrawSetOutline(BlazeDimas[11], 2);
	TextDrawSetShadow(BlazeDimas[11], 0);
	TextDrawAlignment(BlazeDimas[11], 2);
	TextDrawColor(BlazeDimas[11], -1);
	TextDrawBackgroundColor(BlazeDimas[11], 255);
	TextDrawBoxColor(BlazeDimas[11], 252645375);
	TextDrawUseBox(BlazeDimas[11], 1);
	TextDrawSetProportional(BlazeDimas[11], 1);
	TextDrawSetSelectable(BlazeDimas[11], 0);
 
	BlazeDimas[12] = TextDrawCreate(382.000000, 211.000000, "Banco");
	TextDrawFont(BlazeDimas[12], 1);
	TextDrawLetterSize(BlazeDimas[12], 0.187500, 0.850000);
	TextDrawTextSize(BlazeDimas[12], 400.000000, 17.000000);
	TextDrawSetOutline(BlazeDimas[12], 0);
	TextDrawSetShadow(BlazeDimas[12], 0);
	TextDrawAlignment(BlazeDimas[12], 1);
	TextDrawColor(BlazeDimas[12], 1296911871);
	TextDrawBackgroundColor(BlazeDimas[12], 255);
	TextDrawBoxColor(BlazeDimas[12], 1296911666);
	TextDrawUseBox(BlazeDimas[12], 0);
	TextDrawSetProportional(BlazeDimas[12], 1);
	TextDrawSetSelectable(BlazeDimas[12], 0);
 
	BlazeDimas[13] = TextDrawCreate(414.000000, 304.000000, "_");
	TextDrawFont(BlazeDimas[13], 2);
	TextDrawLetterSize(BlazeDimas[13], 0.600000, 1.450009);
	TextDrawTextSize(BlazeDimas[13], 298.500000, 62.500000);
	TextDrawSetOutline(BlazeDimas[13], 2);
	TextDrawSetShadow(BlazeDimas[13], 0);
	TextDrawAlignment(BlazeDimas[13], 2);
	TextDrawColor(BlazeDimas[13], -1);
	TextDrawBackgroundColor(BlazeDimas[13], 255);
	TextDrawBoxColor(BlazeDimas[13], 255);
	TextDrawUseBox(BlazeDimas[13], 1);
	TextDrawSetProportional(BlazeDimas[13], 1);
	TextDrawSetSelectable(BlazeDimas[13], 0);
 
	BlazeDimas[14] = TextDrawCreate(382.000000, 302.000000, "Quantia");
	TextDrawFont(BlazeDimas[14], 1);
	TextDrawLetterSize(BlazeDimas[14], 0.166666, 0.849999);
	TextDrawTextSize(BlazeDimas[14], 400.000000, 17.000000);
	TextDrawSetOutline(BlazeDimas[14], 0);
	TextDrawSetShadow(BlazeDimas[14], 0);
	TextDrawAlignment(BlazeDimas[14], 1);
	TextDrawColor(BlazeDimas[14], -1);
	TextDrawBackgroundColor(BlazeDimas[14], 255);
	TextDrawBoxColor(BlazeDimas[14], 1296911666);
	TextDrawUseBox(BlazeDimas[14], 0);
	TextDrawSetProportional(BlazeDimas[14], 1);
	TextDrawSetSelectable(BlazeDimas[14], 0);
 
	BlazeDimas[15] = TextDrawCreate(458.000000, 304.000000, "_");
	TextDrawFont(BlazeDimas[15], 2);
	TextDrawLetterSize(BlazeDimas[15], 0.600000, 1.450009);
	TextDrawTextSize(BlazeDimas[15], 298.500000, 13.500000);
	TextDrawSetOutline(BlazeDimas[15], 2);
	TextDrawSetShadow(BlazeDimas[15], 0);
	TextDrawAlignment(BlazeDimas[15], 2);
	TextDrawColor(BlazeDimas[15], -1);
	TextDrawBackgroundColor(BlazeDimas[15], 255);
	TextDrawBoxColor(BlazeDimas[15], -16776961);
	TextDrawUseBox(BlazeDimas[15], 1);
	TextDrawSetProportional(BlazeDimas[15], 1);
	TextDrawSetSelectable(BlazeDimas[15], 0);
 
	BlazeDimas[16] = TextDrawCreate(454.000000, 306.000000, "R$");
	TextDrawFont(BlazeDimas[16], 1);
	TextDrawLetterSize(BlazeDimas[16], 0.166666, 0.849999);
	TextDrawTextSize(BlazeDimas[16], 400.000000, 17.000000);
	TextDrawSetOutline(BlazeDimas[16], 0);
	TextDrawSetShadow(BlazeDimas[16], 0);
	TextDrawAlignment(BlazeDimas[16], 1);
	TextDrawColor(BlazeDimas[16], -1);
	TextDrawBackgroundColor(BlazeDimas[16], 255);
	TextDrawBoxColor(BlazeDimas[16], 1296911666);
	TextDrawUseBox(BlazeDimas[16], 0);
	TextDrawSetProportional(BlazeDimas[16], 1);
	TextDrawSetSelectable(BlazeDimas[16], 0);
 
	BlazeDimas[17] = TextDrawCreate(424.000000, 335.000000, "Comecar_jogo");
	TextDrawFont(BlazeDimas[17], 1);
	TextDrawLetterSize(BlazeDimas[17], 0.174998, 1.100000);
	TextDrawTextSize(BlazeDimas[17], 16.500000, 80.500000);
	TextDrawSetOutline(BlazeDimas[17], 0);
	TextDrawSetShadow(BlazeDimas[17], 0);
	TextDrawAlignment(BlazeDimas[17], 2);
	TextDrawColor(BlazeDimas[17], -1);
	TextDrawBackgroundColor(BlazeDimas[17], 255);
	TextDrawBoxColor(BlazeDimas[17], -16776961);
	TextDrawUseBox(BlazeDimas[17], 1);
	TextDrawSetProportional(BlazeDimas[17], 1);
	TextDrawSetSelectable(BlazeDimas[17], 1);
 
	BlazeDimas[18] = TextDrawCreate(424.000000, 352.000000, "_");
	TextDrawFont(BlazeDimas[18], 2);
	TextDrawLetterSize(BlazeDimas[18], 0.600000, 3.550009);
	TextDrawTextSize(BlazeDimas[18], 298.500000, 82.500000);
	TextDrawSetOutline(BlazeDimas[18], 2);
	TextDrawSetShadow(BlazeDimas[18], 0);
	TextDrawAlignment(BlazeDimas[18], 2);
	TextDrawColor(BlazeDimas[18], -1);
	TextDrawBackgroundColor(BlazeDimas[18], 255);
	TextDrawBoxColor(BlazeDimas[18], 252645375);
	TextDrawUseBox(BlazeDimas[18], 1);
	TextDrawSetProportional(BlazeDimas[18], 1);
	TextDrawSetSelectable(BlazeDimas[18], 0);
 
	BlazeDimas[19] = TextDrawCreate(382.000000, 322.000000, "Comece_o_jogo");
	TextDrawFont(BlazeDimas[19], 1);
	TextDrawLetterSize(BlazeDimas[19], 0.166666, 0.849999);
	TextDrawTextSize(BlazeDimas[19], 400.000000, 17.000000);
	TextDrawSetOutline(BlazeDimas[19], 0);
	TextDrawSetShadow(BlazeDimas[19], 0);
	TextDrawAlignment(BlazeDimas[19], 1);
	TextDrawColor(BlazeDimas[19], -1);
	TextDrawBackgroundColor(BlazeDimas[19], 255);
	TextDrawBoxColor(BlazeDimas[19], 1296911666);
	TextDrawUseBox(BlazeDimas[19], 0);
	TextDrawSetProportional(BlazeDimas[19], 1);
	TextDrawSetSelectable(BlazeDimas[19], 0);
 
	BlazeDimas[20] = TextDrawCreate(393.000000, 360.000000, "HUD:radar_race");
	TextDrawFont(BlazeDimas[20], 4);
	TextDrawLetterSize(BlazeDimas[20], 0.600000, 2.000000);
	TextDrawTextSize(BlazeDimas[20], 14.000000, 12.000000);
	TextDrawSetOutline(BlazeDimas[20], 1);
	TextDrawSetShadow(BlazeDimas[20], 0);
	TextDrawAlignment(BlazeDimas[20], 1);
	TextDrawColor(BlazeDimas[20], -1);
	TextDrawBackgroundColor(BlazeDimas[20], 255);
	TextDrawBoxColor(BlazeDimas[20], 50);
	TextDrawUseBox(BlazeDimas[20], 1);
	TextDrawSetProportional(BlazeDimas[20], 1);
	TextDrawSetSelectable(BlazeDimas[20], 0);
 
	BlazeDimas[21] = TextDrawCreate(437.000000, 360.000000, "ld_chat:thumbdn");
	TextDrawFont(BlazeDimas[21], 4);
	TextDrawLetterSize(BlazeDimas[21], 0.600000, 2.000000);
	TextDrawTextSize(BlazeDimas[21], 14.000000, 12.000000);
	TextDrawSetOutline(BlazeDimas[21], 1);
	TextDrawSetShadow(BlazeDimas[21], 0);
	TextDrawAlignment(BlazeDimas[21], 1);
	TextDrawColor(BlazeDimas[21], -1);
	TextDrawBackgroundColor(BlazeDimas[21], 255);
	TextDrawBoxColor(BlazeDimas[21], 50);
	TextDrawUseBox(BlazeDimas[21], 1);
	TextDrawSetProportional(BlazeDimas[21], 1);
	TextDrawSetSelectable(BlazeDimas[21], 0);
 
	BlazeDimas[22] = TextDrawCreate(389.000000, 371.000000, "Acertou");
	TextDrawFont(BlazeDimas[22], 1);
	TextDrawLetterSize(BlazeDimas[22], 0.166666, 0.849999);
	TextDrawTextSize(BlazeDimas[22], 400.000000, 17.000000);
	TextDrawSetOutline(BlazeDimas[22], 0);
	TextDrawSetShadow(BlazeDimas[22], 0);
	TextDrawAlignment(BlazeDimas[22], 1);
	TextDrawColor(BlazeDimas[22], 9109759);
	TextDrawBackgroundColor(BlazeDimas[22], 255);
	TextDrawBoxColor(BlazeDimas[22], 1296911666);
	TextDrawUseBox(BlazeDimas[22], 0);
	TextDrawSetProportional(BlazeDimas[22], 1);
	TextDrawSetSelectable(BlazeDimas[22], 0);
 
	BlazeDimas[23] = TextDrawCreate(437.000000, 371.000000, "Errou");
	TextDrawFont(BlazeDimas[23], 1);
	TextDrawLetterSize(BlazeDimas[23], 0.166666, 0.849999);
	TextDrawTextSize(BlazeDimas[23], 400.000000, 17.000000);
	TextDrawSetOutline(BlazeDimas[23], 0);
	TextDrawSetShadow(BlazeDimas[23], 0);
	TextDrawAlignment(BlazeDimas[23], 1);
	TextDrawColor(BlazeDimas[23], -16776961);
	TextDrawBackgroundColor(BlazeDimas[23], 255);
	TextDrawBoxColor(BlazeDimas[23], 1296911666);
	TextDrawUseBox(BlazeDimas[23], 0);
	TextDrawSetProportional(BlazeDimas[23], 1);
	TextDrawSetSelectable(BlazeDimas[23], 0);
 
	return 1;
}
 
public OnGameModeExit()
{
	return 1;
}
 
public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}
 
public OnPlayerConnect(playerid)
{
	BlazeDimasP[playerid][0] = CreatePlayerTextDraw(playerid, 432.000000, 212.000000, "$999.999.999");
	PlayerTextDrawFont(playerid, BlazeDimasP[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, BlazeDimasP[playerid][0], 0.145833, 0.699998);
	PlayerTextDrawTextSize(playerid, BlazeDimasP[playerid][0], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, BlazeDimasP[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, BlazeDimasP[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, BlazeDimasP[playerid][0], 1);
	PlayerTextDrawColor(playerid, BlazeDimasP[playerid][0], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, BlazeDimasP[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, BlazeDimasP[playerid][0], 1296911666);
	PlayerTextDrawUseBox(playerid, BlazeDimasP[playerid][0], 0);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        SendClientMessage(playerid, -1, #create by: Yoshi_ não retire os créditos!);
	PlayerTextDrawSetProportional(playerid, BlazeDimasP[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, BlazeDimasP[playerid][0], 0);
 
	BlazeDimasP[playerid][1] = CreatePlayerTextDraw(playerid, 379.000000, 220.000000, "HUD:radar_light");
	PlayerTextDrawFont(playerid, BlazeDimasP[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, BlazeDimasP[playerid][1], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, BlazeDimasP[playerid][1], 25.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, BlazeDimasP[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, BlazeDimasP[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, BlazeDimasP[playerid][1], 2);
	PlayerTextDrawColor(playerid, BlazeDimasP[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, BlazeDimasP[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, BlazeDimasP[playerid][1], 200);
	PlayerTextDrawUseBox(playerid, BlazeDimasP[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, BlazeDimasP[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, BlazeDimasP[playerid][1], 1);
 
	BlazeDimasP[playerid][2] = CreatePlayerTextDraw(playerid, 401.000000, 220.000000, "HUD:radar_light");
	PlayerTextDrawFont(playerid, BlazeDimasP[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, BlazeDimasP[playerid][2], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, BlazeDimasP[playerid][2], 25.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, BlazeDimasP[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, BlazeDimasP[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, BlazeDimasP[playerid][2], 2);
	PlayerTextDrawColor(playerid, BlazeDimasP[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, BlazeDimasP[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, BlazeDimasP[playerid][2], 200);
	PlayerTextDrawUseBox(playerid, BlazeDimasP[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, BlazeDimasP[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, BlazeDimasP[playerid][2], 1);
 
	BlazeDimasP[playerid][3] = CreatePlayerTextDraw(playerid, 422.000000, 220.000000, "HUD:radar_light");
	PlayerTextDrawFont(playerid, BlazeDimasP[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid, BlazeDimasP[playerid][3], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, BlazeDimasP[playerid][3], 25.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, BlazeDimasP[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, BlazeDimasP[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, BlazeDimasP[playerid][3], 2);
	PlayerTextDrawColor(playerid, BlazeDimasP[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, BlazeDimasP[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, BlazeDimasP[playerid][3], 200);
	PlayerTextDrawUseBox(playerid, BlazeDimasP[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, BlazeDimasP[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, BlazeDimasP[playerid][3], 1);
 
	BlazeDimasP[playerid][4] = CreatePlayerTextDraw(playerid, 443.000000, 220.000000, "HUD:radar_light");
	PlayerTextDrawFont(playerid, BlazeDimasP[playerid][4], 4);
	PlayerTextDrawLetterSize(playerid, BlazeDimasP[playerid][4], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, BlazeDimasP[playerid][4], 25.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, BlazeDimasP[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, BlazeDimasP[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, BlazeDimasP[playerid][4], 2);
	PlayerTextDrawColor(playerid, BlazeDimasP[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, BlazeDimasP[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, BlazeDimasP[playerid][4], 200);
	PlayerTextDrawUseBox(playerid, BlazeDimasP[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, BlazeDimasP[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, BlazeDimasP[playerid][4], 1);
 
	BlazeDimasP[playerid][5] = CreatePlayerTextDraw(playerid, 379.000000, 245.000000, "HUD:radar_light");
	PlayerTextDrawFont(playerid, BlazeDimasP[playerid][5], 4);
	PlayerTextDrawLetterSize(playerid, BlazeDimasP[playerid][5], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, BlazeDimasP[playerid][5], 25.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, BlazeDimasP[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, BlazeDimasP[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, BlazeDimasP[playerid][5], 2);
	PlayerTextDrawColor(playerid, BlazeDimasP[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, BlazeDimasP[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, BlazeDimasP[playerid][5], 200);
	PlayerTextDrawUseBox(playerid, BlazeDimasP[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, BlazeDimasP[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, BlazeDimasP[playerid][5], 1);
 
	BlazeDimasP[playerid][6] = CreatePlayerTextDraw(playerid, 401.000000, 245.000000, "HUD:radar_light");
	PlayerTextDrawFont(playerid, BlazeDimasP[playerid][6], 4);
	PlayerTextDrawLetterSize(playerid, BlazeDimasP[playerid][6], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, BlazeDimasP[playerid][6], 25.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, BlazeDimasP[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, BlazeDimasP[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, BlazeDimasP[playerid][6], 2);
	PlayerTextDrawColor(playerid, BlazeDimasP[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, BlazeDimasP[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, BlazeDimasP[playerid][6], 200);
	PlayerTextDrawUseBox(playerid, BlazeDimasP[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, BlazeDimasP[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, BlazeDimasP[playerid][6], 1);
 
	BlazeDimasP[playerid][7] = CreatePlayerTextDraw(playerid, 422.000000, 245.000000, "HUD:radar_light");
	PlayerTextDrawFont(playerid, BlazeDimasP[playerid][7], 4);
	PlayerTextDrawLetterSize(playerid, BlazeDimasP[playerid][7], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, BlazeDimasP[playerid][7], 25.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, BlazeDimasP[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, BlazeDimasP[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, BlazeDimasP[playerid][7], 2);
	PlayerTextDrawColor(playerid, BlazeDimasP[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, BlazeDimasP[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, BlazeDimasP[playerid][7], 200);
	PlayerTextDrawUseBox(playerid, BlazeDimasP[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, BlazeDimasP[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, BlazeDimasP[playerid][7], 1);
 
	BlazeDimasP[playerid][8] = CreatePlayerTextDraw(playerid, 443.000000, 245.000000, "HUD:radar_light");
	PlayerTextDrawFont(playerid, BlazeDimasP[playerid][8], 4);
	PlayerTextDrawLetterSize(playerid, BlazeDimasP[playerid][8], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, BlazeDimasP[playerid][8], 25.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, BlazeDimasP[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, BlazeDimasP[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, BlazeDimasP[playerid][8], 2);
	PlayerTextDrawColor(playerid, BlazeDimasP[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, BlazeDimasP[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, BlazeDimasP[playerid][8], 200);
	PlayerTextDrawUseBox(playerid, BlazeDimasP[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, BlazeDimasP[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, BlazeDimasP[playerid][8], 1);
 
	BlazeDimasP[playerid][9] = CreatePlayerTextDraw(playerid, 379.000000, 270.000000, "HUD:radar_light");
	PlayerTextDrawFont(playerid, BlazeDimasP[playerid][9], 4);
	PlayerTextDrawLetterSize(playerid, BlazeDimasP[playerid][9], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, BlazeDimasP[playerid][9], 25.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, BlazeDimasP[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, BlazeDimasP[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, BlazeDimasP[playerid][9], 2);
	PlayerTextDrawColor(playerid, BlazeDimasP[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, BlazeDimasP[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, BlazeDimasP[playerid][9], 200);
	PlayerTextDrawUseBox(playerid, BlazeDimasP[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, BlazeDimasP[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, BlazeDimasP[playerid][9], 1);
 
	BlazeDimasP[playerid][10] = CreatePlayerTextDraw(playerid, 422.000000, 270.000000, "HUD:radar_light");
	PlayerTextDrawFont(playerid, BlazeDimasP[playerid][10], 4);
	PlayerTextDrawLetterSize(playerid, BlazeDimasP[playerid][10], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, BlazeDimasP[playerid][10], 25.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, BlazeDimasP[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, BlazeDimasP[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, BlazeDimasP[playerid][10], 2);
	PlayerTextDrawColor(playerid, BlazeDimasP[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, BlazeDimasP[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, BlazeDimasP[playerid][10], 200);
	PlayerTextDrawUseBox(playerid, BlazeDimasP[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, BlazeDimasP[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, BlazeDimasP[playerid][10], 1);
 
	BlazeDimasP[playerid][11] = CreatePlayerTextDraw(playerid, 401.000000, 270.000000, "HUD:radar_light");
	PlayerTextDrawFont(playerid, BlazeDimasP[playerid][11], 4);
	PlayerTextDrawLetterSize(playerid, BlazeDimasP[playerid][11], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, BlazeDimasP[playerid][11], 25.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, BlazeDimasP[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, BlazeDimasP[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, BlazeDimasP[playerid][11], 2);
	PlayerTextDrawColor(playerid, BlazeDimasP[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, BlazeDimasP[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, BlazeDimasP[playerid][11], 200);
	PlayerTextDrawUseBox(playerid, BlazeDimasP[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, BlazeDimasP[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, BlazeDimasP[playerid][11], 1);
 
	BlazeDimasP[playerid][12] = CreatePlayerTextDraw(playerid, 443.000000, 270.000000, "HUD:radar_light");
	PlayerTextDrawFont(playerid, BlazeDimasP[playerid][12], 4);
	PlayerTextDrawLetterSize(playerid, BlazeDimasP[playerid][12], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, BlazeDimasP[playerid][12], 25.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, BlazeDimasP[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, BlazeDimasP[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, BlazeDimasP[playerid][12], 2);
	PlayerTextDrawColor(playerid, BlazeDimasP[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, BlazeDimasP[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, BlazeDimasP[playerid][12], 200);
	PlayerTextDrawUseBox(playerid, BlazeDimasP[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, BlazeDimasP[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, BlazeDimasP[playerid][12], 1);
 
	BlazeDimasP[playerid][13] = CreatePlayerTextDraw(playerid, 382.000000, 313.000000, "0,00");
	PlayerTextDrawFont(playerid, BlazeDimasP[playerid][13], 1);
	PlayerTextDrawLetterSize(playerid, BlazeDimasP[playerid][13], 0.145833, 0.699998);
	PlayerTextDrawTextSize(playerid, BlazeDimasP[playerid][13], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, BlazeDimasP[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, BlazeDimasP[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, BlazeDimasP[playerid][13], 1);
	PlayerTextDrawColor(playerid, BlazeDimasP[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, BlazeDimasP[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, BlazeDimasP[playerid][13], 1296911666);
	PlayerTextDrawUseBox(playerid, BlazeDimasP[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, BlazeDimasP[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, BlazeDimasP[playerid][13], 0);
 
	return 1;
}
 
public OnPlayerDisconnect(playerid, reason)
{
	PlayerTextDrawDestroy(playerid, BlazeDimasP[playerid][0]);
	PlayerTextDrawDestroy(playerid, BlazeDimasP[playerid][1]);
	return 1;
}
 
public OnPlayerSpawn(playerid)
{
	return 1;
}
 
public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}
 
public OnVehicleSpawn(vehicleid)
{
	return 1;
}
 
public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}
 
public OnPlayerText(playerid, text[])
{
	return 1;
}
 
public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}
 
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}
 
public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}
 
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}
 
public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}
 
public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}
 
public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}
 
public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}
 
public OnRconCommand(cmd[])
{
	return 1;
}
 
public OnPlayerRequestSpawn(playerid)
{
	return 1;
}
 
public OnObjectMoved(objectid)
{
	return 1;
}
 
public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}
 
public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}
 
public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}
 
public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}
 
public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}
 
public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}
 
public OnPlayerExitedMenu(playerid)
{
	return 1;
}
 
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}
 
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}
 
public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}
 
public OnPlayerUpdate(playerid)
{
	return 1;
}
 
public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}
 
public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}
 
public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}
 
public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}
 
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}
 
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid >= BlazeDimasP[playerid][1] && playertextid <= BlazeDimasP[playerid][12])
    {
        if(Money_Win[playerid] == 0) return ShowPlayerDialog(playerid, 0, 0, "{FF6F00}Aviso Blaze", "Voce nao apostou nada.", "OK","");
        new clicked;
        for(new t = 12; t-- != 1;)
        {
            if(playertextid == BlazeDimasP[playerid][t])
               clicked = t;
        }
        if(clicked_td[playerid][clicked])
            return true;
        InGame[playerid] = 1;
        PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);
        new ran;
	    ran = random(2);
	    switch(ran)
	    {
	        case 0:
	        {
	            PlayerTextDrawSetString(playerid,BlazeDimasP[playerid][clicked], "LD_CHAT:thumbup");
	            PlayerWins(playerid);
	        }
	        case 1:
			{
				PlayerTextDrawSetString(playerid,BlazeDimasP[playerid][clicked], "LD_CHAT:thumbdn");
	            GameOwers(playerid);
			}
		}
		clicked_td[playerid][clicked] = 1;
    }
	return 1;
}
 
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == BlazeDimas[17])
	{
		cmd_apostar(playerid);
	}
	return 1;
}
 
CMD:blazedimas(playerid){
	if(IsPlayerConnected(playerid)){
		TextDrawShowForPlayer(playerid, BlazeDimas[0]);
		TextDrawShowForPlayer(playerid, BlazeDimas[1]);
		TextDrawShowForPlayer(playerid, BlazeDimas[2]);
		TextDrawShowForPlayer(playerid, BlazeDimas[3]);
		TextDrawShowForPlayer(playerid, BlazeDimas[4]);
		TextDrawShowForPlayer(playerid, BlazeDimas[5]);
		TextDrawShowForPlayer(playerid, BlazeDimas[6]);
		TextDrawShowForPlayer(playerid, BlazeDimas[7]);
		TextDrawShowForPlayer(playerid, BlazeDimas[8]);
		TextDrawShowForPlayer(playerid, BlazeDimas[9]);
		TextDrawShowForPlayer(playerid, BlazeDimas[10]);
		TextDrawShowForPlayer(playerid, BlazeDimas[11]);
		TextDrawShowForPlayer(playerid, BlazeDimas[12]);
		TextDrawShowForPlayer(playerid, BlazeDimas[13]);
		TextDrawShowForPlayer(playerid, BlazeDimas[14]);
		TextDrawShowForPlayer(playerid, BlazeDimas[15]);
		TextDrawShowForPlayer(playerid, BlazeDimas[16]);
		TextDrawShowForPlayer(playerid, BlazeDimas[17]);
		TextDrawShowForPlayer(playerid, BlazeDimas[18]);
		TextDrawShowForPlayer(playerid, BlazeDimas[19]);
		TextDrawShowForPlayer(playerid, BlazeDimas[20]);
		TextDrawShowForPlayer(playerid, BlazeDimas[21]);
		TextDrawShowForPlayer(playerid, BlazeDimas[22]);
		TextDrawShowForPlayer(playerid, BlazeDimas[23]);
		TextDrawShowForPlayer(playerid, textdraw_16);
		TextDrawShowForPlayer(playerid, textdraw_18);
		TextDrawShowForPlayer(playerid, textdraw_17);
		PlayerTextDrawShow(playerid, BlazeDimasP[playerid][0]);
		PlayerTextDrawShow(playerid, BlazeDimasP[playerid][1]);
		PlayerTextDrawShow(playerid, BlazeDimasP[playerid][2]);
		PlayerTextDrawShow(playerid, BlazeDimasP[playerid][3]);
		PlayerTextDrawShow(playerid, BlazeDimasP[playerid][4]);
		PlayerTextDrawShow(playerid, BlazeDimasP[playerid][5]);
		PlayerTextDrawShow(playerid, BlazeDimasP[playerid][6]);
		PlayerTextDrawShow(playerid, BlazeDimasP[playerid][7]);
		PlayerTextDrawShow(playerid, BlazeDimasP[playerid][8]);
		PlayerTextDrawShow(playerid, BlazeDimasP[playerid][9]);
		PlayerTextDrawShow(playerid, BlazeDimasP[playerid][10]);
		PlayerTextDrawShow(playerid, BlazeDimasP[playerid][11]);
		PlayerTextDrawShow(playerid, BlazeDimasP[playerid][12]);
		PlayerTextDrawShow(playerid, BlazeDimasP[playerid][13]);
		for ( new t = 1 ; t < 13 ; t++ )
		{
		    if(t < 13) clicked_td[playerid][t] = 0;
			PlayerTextDrawSetString(playerid, BlazeDimasP[playerid][t], "LD_BEAT:cring");
 
		}
 
		SelectTextDraw(playerid, 0xFF0000FF);
		GivePlayerMoney(playerid, 100000);
	}
	return 1;
}
 
CMD:fecharblaze(playerid){
	if(IsPlayerConnected(playerid)){
		TextDrawHideForPlayer(playerid, BlazeDimas[0]);
		TextDrawHideForPlayer(playerid, BlazeDimas[1]);
		TextDrawHideForPlayer(playerid, BlazeDimas[2]);
		TextDrawHideForPlayer(playerid, BlazeDimas[3]);
		TextDrawHideForPlayer(playerid, BlazeDimas[4]);
		TextDrawHideForPlayer(playerid, BlazeDimas[5]);
		TextDrawHideForPlayer(playerid, BlazeDimas[6]);
		TextDrawHideForPlayer(playerid, BlazeDimas[7]);
		TextDrawHideForPlayer(playerid, BlazeDimas[8]);
		TextDrawHideForPlayer(playerid, BlazeDimas[9]);
		TextDrawHideForPlayer(playerid, BlazeDimas[10]);
		TextDrawHideForPlayer(playerid, BlazeDimas[11]);
		TextDrawHideForPlayer(playerid, BlazeDimas[12]);
		TextDrawHideForPlayer(playerid, BlazeDimas[13]);
		TextDrawHideForPlayer(playerid, BlazeDimas[14]);
		TextDrawHideForPlayer(playerid, BlazeDimas[15]);
		TextDrawHideForPlayer(playerid, BlazeDimas[16]);
		TextDrawHideForPlayer(playerid, BlazeDimas[17]);
		TextDrawHideForPlayer(playerid, BlazeDimas[18]);
		TextDrawHideForPlayer(playerid, BlazeDimas[19]);
		TextDrawHideForPlayer(playerid, BlazeDimas[20]);
		TextDrawHideForPlayer(playerid, BlazeDimas[21]);
		TextDrawHideForPlayer(playerid, BlazeDimas[22]);
		TextDrawHideForPlayer(playerid, BlazeDimas[23]);
		TextDrawHideForPlayer(playerid, textdraw_16);
		TextDrawHideForPlayer(playerid, textdraw_18);
		TextDrawHideForPlayer(playerid, textdraw_17);
		PlayerTextDrawHide(playerid, BlazeDimasP[playerid][0]);
		PlayerTextDrawHide(playerid, BlazeDimasP[playerid][1]);
		PlayerTextDrawHide(playerid, BlazeDimasP[playerid][2]);
		PlayerTextDrawHide(playerid, BlazeDimasP[playerid][3]);
		PlayerTextDrawHide(playerid, BlazeDimasP[playerid][4]);
		PlayerTextDrawHide(playerid, BlazeDimasP[playerid][5]);
		PlayerTextDrawHide(playerid, BlazeDimasP[playerid][6]);
		PlayerTextDrawHide(playerid, BlazeDimasP[playerid][7]);
		PlayerTextDrawHide(playerid, BlazeDimasP[playerid][8]);
		PlayerTextDrawHide(playerid, BlazeDimasP[playerid][9]);
		PlayerTextDrawHide(playerid, BlazeDimasP[playerid][10]);
		PlayerTextDrawHide(playerid, BlazeDimasP[playerid][11]);
		PlayerTextDrawHide(playerid, BlazeDimasP[playerid][12]);
		PlayerTextDrawHide(playerid, BlazeDimasP[playerid][13]);
 
		CancelSelectTextDraw(playerid);
	}
	return 1;
}
 
CMD:converter(playerid){
	if(IsPlayerConnected(playerid))
    {
    	PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
        if(Money_Win[playerid] == 0) return ShowPlayerDialog(playerid, 0, 0, "{FF6F00}Blaze Dimas", "Voce nao ganhou nada.", "OK","");
        new string[15];
        format(string,sizeof(string),"~g~+$%d",Money_Win[playerid]);
		GameTextForPlayer(playerid, string, 3000, 6);
    	GivePlayerMoney(playerid, Money_Win[playerid]);
    	Money_Win[playerid] = 0;
    	PlayerWin[playerid] = 0;
    	InGame[playerid] = 0;
		for ( new t = 1 ; t < 12 ; t++ )
		{
		    if(t < 12) clicked_td[playerid][t] = 0;
			PlayerTextDrawSetString(playerid, BlazeDimasP[playerid][t], "LD_BEAT:cring");
		}
		PlayerPlaySound(playerid, 43001, 0.0, 0.0, 0.0);
    }
	return 1;
}
 
CMD:apostar(playerid){
	if(IsPlayerConnected(playerid))
	{
  		new quant;
        //if(quant < 100 || quant > 3000) return SendClientMessage(playerid,0xAFAFAFAA,"AvisoBlaze: Voce nao tem a quantidade apostada.");
        GivePlayerMoney(playerid, -3000);
        Money_Win[playerid] += SetPVarInt(playerid,"w_m",3000/100);
        new string[25];
        SendClientMessage(playerid,0xAFAFAFAA,"AvisoBlaze: Voce apostou R$3.000,00.");
	}
	return 1;
}
 
forward PlayerWins(playerid);
public PlayerWins(playerid)
{
	new string[25];
    PlayerWin[playerid] ++;
    switch(Mode[playerid])
    {
		case 2:
        {
		    switch(PlayerWin[playerid])
		    {
		        case 1,2: Money_Win[playerid] += GetPVarInt(playerid,"w_m") * 25;
		        case 3: Money_Win[playerid] += GetPVarInt(playerid,"w_m") * 50;
		        case 4: Money_Win[playerid] += GetPVarInt(playerid,"w_m") * 75;
		        case 5..12: Money_Win[playerid] += GetPVarInt(playerid,"w_m") * 150;
		    }
		}
	}
    format(string, sizeof(string), "~w~R$%d,00",Money_Win[playerid]);
	PlayerTextDrawSetString(playerid, BlazeDimasP[playerid][13],string);
    return 1;
}
 
forward GameOwers(playerid);
public GameOwers(playerid)
{
	new string[25];
	GameOwer[playerid] ++;
	switch(Mode[playerid])
	{
		case 2:
        {
			if(GameOwer[playerid] >= 1)
			{
 
		    	Money_Win[playerid] = 0;
		    	PlayerWin[playerid] = 0;
				GameOwer[playerid] = 0;
				InGame[playerid] = 0;
				GameTextForPlayer(playerid, "~r~Perdeu o Jogo", 3000, 6);
    			format(string, sizeof(string), "~w~R$%0,00");
				PlayerTextDrawSetString(playerid, BlazeDimasP[playerid][13],string);
				for ( new t = 1 ; t < 13 ; t++ )
				{
				    if(t < 13) clicked_td[playerid][t] = 0;
					PlayerTextDrawSetString(playerid, BlazeDimasP[playerid][t], "LD_BEAT:cring");
 
				}
				PlayerPlaySound(playerid, 31202, 0.0, 0.0, 0.0);
			}
		}
 
	}
}