/*===================================================================================================================================
|                                        Survive the Apocalypse - Cria
por: JPedro (Mantenha os Créditos)                         |
|                                                  Versao: 0.0 - Ultimo Update: 00/00/0000                                          |
|    _____                      _               _    _              ___                             _                               |
|   /  ___|                    (_)             | |  | |            / _ \                           | |                              |
|   \ `--.  _   _  _ __ __   __ _ __   __ ___  | |_ | |__    ___  / /_\ \ _ __    ___    ___  __ _ | | _   _  _ __   ___   ___      |
|    `--. \| | | || '__|\ \ / /| |\ \ / // _ \ | __|| '_ \  / _ \ |  _  || '_ \  / _ \  / __|/ _` || || | | || '_ \ / __| / _ \     \
|   /\__/ /| |_| || |    \ V / | | \ V /|  __/ | |_ | | | ||  __/ | | | || |_) || (_) || (__| (_| || || |_| || |_) |\__ \|  __/     |
|   \____/  \__,_||_|     \_/  |_|  \_/  \___|  \__||_| |_| \___| \_| |_/| .__/  \___/  \___|\__,_||_| \__, || .__/ |___/ \___|     |
|                                                                        | |                            __/ || |                    |
|                                                                        |_|                           |___/ |_|                    |
| Index dos attached object: 0 = Mochilas, 3 = Particula do Sangue    964 = airdrop                                    |
===================================================================================================================================*/

// # Includes #
#include <a_samp>
#include <streamer>
#include <foreach>
#include <sscanf2>
#include <zcmd>
#include <DOF2>
#include <YSI\y_va>
#include <discord-connector>
#include <discord-command>


// # Defines #
#undef MAX_PLAYERS
#define MAX_PLAYERS (200)
#define MAX_PAREDE 2000 //Maximo de paredes permitidas no servidor
#define MAX_CAIXA 1000
#define MAX_CRAFT 1000
#define MAX_PORTA 1000
#define forno 2144 //sistema nunca construido

#define MODENAME "gamemodetext Survival 1.5.5"
#define HOSTNAME "hostname NextDay - Survival #WhiteList | @Ecxon.com.br"
#define LANGUAGE "language PT-BR"
#define RCON     "rcon_password projetofutil"
#define WEBURL   "weburl nextdaysurvival.rf.gd/"

#define logsdc "752727151639527426" 
static DCC_Channel:logs; 


// # Cores 

#define CinzaC  (0x828282AA)
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
new Arvores[41];
new bool:natora[MAX_PLAYERS];
new ator[7];
new idparedebomb[MAX_PLAYERS];
new objetoc4[MAX_PLAYERS];
new idcaixap[MAX_PLAYERS];
new bool:msglog[MAX_PLAYERS];
new bool:encheG[MAX_PLAYERS];
new specing[MAX_PLAYERS];
new verificador[MAX_PLAYERS];
new errousenha[MAX_PLAYERS];
new bool:permitidocaixa = true;
new avisoadm[MAX_PLAYERS];
new cadeiaadm[MAX_PLAYERS];
new idporta[MAX_PLAYERS];
new PodeArma[MAX_PLAYERS];	
new BigEar[MAX_PLAYERS];
//new g_ServerRestart;
//new g_RestartTime;

new Carro;

//new Armaagora[MAX_PLAYERS];
new BebedorSize[18];
new GalaoSize[12] = 200;
new Text3D:galaotext[12];
new Text3D:bebedortext[18];
//new ArmasAmmo[MAX_PLAYERS];
//new Tipodearma[MAX_PLAYERS];
new bool:permitidoparede = true;

#define SLOTS 10

new curandosegundos[MAX_PLAYERS];
new timerdacura[MAX_PLAYERS];
new bool:caido[MAX_PLAYERS];

new rilandosegundos[MAX_PLAYERS];
new timerrilando[MAX_PLAYERS];
new jarilando[MAX_PLAYERS];
new iddorilado;
new timercaido[MAX_PLAYERS];
new caidosegundos[MAX_PLAYERS];
new bool:morto[MAX_PLAYERS];
new sanguenatela[MAX_PLAYERS];
new temeperaturamundo;
new tempoatual;
new fogueiraplayer[MAX_PLAYERS];
new avisadofrio[MAX_PLAYERS];
new timerfrio[MAX_PAREDE];
new ideditorp[MAX_PLAYERS];
new sexo[MAX_PLAYERS];
new Float:fogueirapos[MAX_PLAYERS][3];
new objfogueira[MAX_PLAYERS];
new grupoplayer[MAX_PLAYERS];
new PlayerDeaths[MAX_PLAYERS];
new PlayerKills[MAX_PLAYERS];
//new grupoid = 0;
//new lidergrupo[MAX_PLAYERS];


new DB:Connect;

// # Dialogs #
#define D_Sexo             (2)
#define D_Inventario       (3)
#define D_UsarDropar       (4)
#define D_PegarItem        (5)
#define DIALOG_TENT_VIEW 17
#define DIALOG_TENT_VIEW_S 18
#define DIALOG_TENT_VIEW_S2 19
#define MAX_ITEMS 66

#define Suprimentos 120


#define DIALOG_REGISTRO 0
#define DIALOG_LOGIN 1
// # Enumeradores e Variaveis #

enum Player_Data
{
	pSenha[20],
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
	pTemRADIO,
	pIP[26],
	IDdb,
	pPedra,
	pFerro,
	pArmaequipada,
	pVip,
	pTemMask,	
	bool:pDuty,
};

enum ParedeInfo
{
    ID,
   	Dono[128],
    Existe,
    ObjectJ,
	Text3D:Text3Dp,
    Float: PosX,
    Float: PosY,
    Float: PosZ,
    Float: RX,
    Float: RY,
    Float: RZ,
	metallife,
	upgrade,
}
new Parede[MAX_PAREDE][ParedeInfo];

enum PortaInfo
{
	ID,
	Dono[128],
	Existe,
	ObjectP,
	Text3D:Text3Dp,
    Float: PosX,
    Float: PosY,
    Float: PosZ,
    Float: RX,
    Float: RY,
    Float: RZ,
	metallife,
	Senha[128],	
	upgrade,
}

new Porta[MAX_PORTA][PortaInfo];

enum CraftInfo
{
    ID,
   	Dono[128],
    Existe,
    ObjectT,
	Text3D:Text3Dp,
    Float: PosX,
    Float: PosY,
    Float: PosZ,
    Float: RX,
    Float: RY,
    Float: RZ,
}
new Craft[MAX_CRAFT][CraftInfo];

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


///////////////////////SPAWN DE VE�CULOS///////////////////////////////////////

stock CarregarVeiculos()
{
	CreateVehicle(526,-1366.5660,-487.0266,14.6323,206.3031,60,1,-1); // carro
    CreateVehicle(470,-1473.6290,318.2003,7.1800,268.3372,43,0,-1); // patriot
    CreateVehicle(470,-1447.9188,324.4433,7.1818,179.2394,43,0,-1); // patriot
    CreateVehicle(470,-1528.7013,364.3158,7.1799,88.4381,43,0,-1); // patriot
    CreateVehicle(468,-1919.0232,641.6234,46.0748,18.6486,30,1,-1); // samn
    CreateVehicle(422,-2084.5000,974.2706,62.4413,270.9784,30,1,-1); // san
    CreateVehicle(468,-2455.9302,741.6820,34.6848,358.7324,53,53,-1); // sanchez
    CreateVehicle(500,-2688.2822,267.8337,4.4468,178.8253,4,119,-1); // mesa
    CreateVehicle(468,-2752.4248,-252.0182,6.6994,268.2216,7,1,-1); // bike
    CreateVehicle(468,-2823.8840,-1527.6454,138.9586,177.2614,53,53,-1); // sanchez
    CreateVehicle(495,-1828.7611,-1628.0045,23.3676,90.2290,116,115,-1); // sandking
    CreateVehicle(422,-1906.8344,-1931.8519,82.4951,110.5280,113,36,-1); // bobcat
    CreateVehicle(471,-1643.6023,-2251.2673,30.9789,84.3325,74,91,-1); // quadbike
    CreateVehicle(509,-2050.1606,-2531.4275,29.9350,73.9249,25,1,-1); // bike
    CreateVehicle(526,-2148.9915,-2442.0674,30.3917,322.3669,21,1,-1); // carro
    CreateVehicle(463,-2089.3445,-2242.9895,30.5691,48.6981,79,79,-1); // freeway
    CreateVehicle(542,-1112.6207,-1675.5278,75.9922,1.1334,51,1,-1); // veio
    CreateVehicle(463,-423.0471,-1760.8734,5.4074,260.5724,19,19,-1); // freeway
    CreateVehicle(568,-367.6732,-1440.7400,25.5913,89.6966,41,29,-1); // bandito
    CreateVehicle(509,-61.2147,-1135.7361,0.5903,61.7149,53,1,-1); // bike
    CreateVehicle(500,-32.1962,-293.7333,5.5393,89.2770,13,119,-1); // mesa
    CreateVehicle(468,93.4199,-189.6609,1.1535,174.5787,46,46,-1); // sanchez
    CreateVehicle(509,183.4966,-107.5106,1.5336,229.4939,30,1,-1); // bike
    CreateVehicle(422,-177.3795,-2679.2222,33.6578,171.3843,113,36,-1); // boquete
    CreateVehicle(468,-90.8860,-1576.5012,2.2863,217.1642,6,6,-1); // sanchez
    CreateVehicle(480,889.1161,-23.2860,63.0305,152.9846,46,46,-1); // comet
    CreateVehicle(500,1387.7090,265.4638,19.6682,158.0676,21,119,-1); // mesa
    CreateVehicle(509,1273.3755,302.9951,19.0641,242.9099,36,1,-1); // bike
    CreateVehicle(545,1543.2914,15.8598,23.7958,282.8914,116,1,-1); // elegy
    CreateVehicle(478,2263.4858,-84.1085,26.5025,176.1565,59,1,-1); // walton
    CreateVehicle(468,2316.5188,65.8839,26.1514,208.0513,46,46,-1); // sanchez
    CreateVehicle(468,2457.9973,-970.2455,79.7501,89.1089,46,46,-1); // sanchez
    CreateVehicle(549,2134.1211,-1143.0068,24.6942,39.6925,91,35,-1); // tampa
    CreateVehicle(496,1629.7026,-1085.1323,23.6222,90.3225,22,22,-1); // blist
    CreateVehicle(468,1582.4097,-1326.1356,16.1535,245.4284,46,46,-1); // sanchez
    CreateVehicle(509,1945.9092,-1426.3134,9.8674,56.4305,25,1,-1); // bike
    CreateVehicle(517,2229.4666,-1357.2504,23.8423,88.3433,47,41,-1); // majestic
    CreateVehicle(545,2407.7786,-1719.7789,13.4722,358.0779,44,96,-1); // fusquinha
    CreateVehicle(468,2758.4736,-1847.3802,9.2249,198.1774,7,1,-1); // bike
    CreateVehicle(468,2416.2163,-2467.4375,13.1372,333.0653,7,1,-1); // bike
    CreateVehicle(483,2764.3240,-2390.1226,13.7488,180.7697,13,119,-1); // mesa
    CreateVehicle(483,1127.6191,-1489.1490,22.2815,231.5816,7,1,-1); // bike
    CreateVehicle(571,1245.8248,-802.9407,83.4245,177.8757,2,35,-1); // kart
    CreateVehicle(497,1587.3832,-1664.3827,20.0541,180.9234,0,1,-1); // police maverick
    CreateVehicle(596,1530.3658,-1645.2338,5.6106,180.8842,0,1,-1); // viaturals
    CreateVehicle(599,614.3348,-601.1067,17.4263,269.8077,0,1,-1); // police rancher
    CreateVehicle(478,668.0151,-464.6690,16.3276,91.6239,39,1,-1); // walton
    CreateVehicle(468,786.4204,360.7122,19.2152,101.5383,3,3,-1); // sanchez
    CreateVehicle(487,681.8943,895.7935,-39.6937,118.0888,26,3,-1); // Desert Maverick
    CreateVehicle(483,112.2441,1061.1290,13.1196,296.5618,74,1,-1); // bike
    CreateVehicle(605,-301.7305,1767.2900,42.2594,89.6090,39,106,-1); // NRG-500
    CreateVehicle(528,90.3160,1911.9968,17.9277,48.9184,0,0,-1); // FBI Truck
    CreateVehicle(568,-539.9628,2355.3384,74.3119,58.9048,9,39,-1); // bandito
    CreateVehicle(422,-812.0513,2758.1350,45.8412,94.9730,67,59,-1); // bobcat
    CreateVehicle(468,-1595.5123,2694.3135,54.7016,176.4087,3,3,-1); // sanchez
    CreateVehicle(468,-2518.5950,2388.3064,16.5149,132.5153,53,1,-1); // bike
    CreateVehicle(483,-2446.7107,2243.0122,4.8025,179.4125,0,6,-1); // kombi
    CreateVehicle(468,-2539.4580,1229.8041,37.0910,211.9225,3,3,-1); // sanchez
    CreateVehicle(597,-1638.0404,653.7358,-5.4730,269.7604,0,1,-1); // viaturasf
    CreateVehicle(468,-2129.9224,224.8442,35.5943,349.5165,3,3,-1); // sanchez
    CreateVehicle(470,331.3674,2133.2563,17.2205,271.0840,43,0,-1); // patriot
    CreateVehicle(603,1138.2468,2317.0500,16.5567,90.0359,58,1,-1); // phoenix
    CreateVehicle(471,1433.8346,2608.3928,10.1544,269.7056,74,83,-1); // quad
    CreateVehicle(468,2312.2212,2753.6160,10.4894,268.5766,46,46,-1); // sanchez
    CreateVehicle(470,2469.8906,2747.1047,10.8102,138.2713,43,0,-1); // patriot
    CreateVehicle(598,2260.5222,2477.2539,10.5664,359.5464,0,1,-1); // viaturalv
    CreateVehicle(487,2094.2485,2413.2703,74.7556,37.0103,3,29,-1); // LV Maverick
    CreateVehicle(523,2249.6963,1745.7169,10.3936,44.1531,8,82,-1); // NRG-500
    CreateVehicle(535,2148.7197,1398.2327,10.5777,0.1573,123,1,-1); // slamvan
    CreateVehicle(422,2312.5706,1387.9003,42.8123,179.4522,96,25,-1); // bobcat
    CreateVehicle(521,2884.0547,2521.8259,10.3942,225.4168,8,82,-1); // NRG-500
    CreateVehicle(424,-680.5506,966.4012,11.9139,89.0603,3,2,-1); // Bugre
	return 1;
}

//////////////////////FIM/////////////////////////////////////////////////////

// # Arrays #

stock explode(aExplode[][], const sSource[], const sDelimiter[] = " ", iVertices = sizeof aExplode, iLength = sizeof aExplode[])
{
	new
		iNode,
		iPointer,
		iPrevious = -1,
		iDelimiter = strlen(sDelimiter);

	while(iNode < iVertices)
	{
		iPointer = strfind(sSource, sDelimiter, false, iPointer);

		if(iPointer == -1)
		{
			strmid(aExplode[iNode], sSource, iPrevious, strlen(sSource), iLength);
			break;
		}
		else
		{
			strmid(aExplode[iNode], sSource, iPrevious, iPointer, iLength);
		}

		iPrevious = (iPointer += iDelimiter);
		++iNode;
	}

	return iPrevious;
}

new GunName[47][20] = 
{
	"Fist","Brass Knuckles","Golf Club","Nightstick","Knife","Basebal Bat","Shovel","Pool Cue","Katana","Chainsaw","Double-ended Dildo","Dildo","Vibrator",
	"Silver Vibrator","Flowers","Cane","Grenade","Tear Gas","Molotv Cocktail","?","?","?","9mm","Silenced 9mm","Desert Eagle","Shotgun","Sawnoff-Shotgun",
	"Combat Shotgun","Micro-SMG","MP5","Ak-47","M4","Tec9","Country Rifle","Sniper Rifle","RPG","HS-RPG","Flame-Thrower","Minigun","Satchel Charge","Detonator",
	"Spray Can","Fire Extinguisher","Camera","Night Goggles","Thermal Goggles","Parachute"
};

new Float:Respawns[][] =
{
	{-1972.5417,-2446.6587,30.6250}, 
    {-2018.2572,-860.7180,32.1719}, 
    {-2907.9512,-17.1399,3.6951},
    {-2074.8816,1431.6178,7.1016}, 
    {-2294.8931,2528.8916,3.8589}, 
    {-641.5798,1440.4730,13.6172},
    {220.3781,148.7883,2.4229}, 
    {2294.0977,524.4571,1.7944}, 
    {1393.8510,466.1010,20.1352}, 
    {260.1608,-1865.7529,2.7744},
    {2940.1350,-2051.8469,3.5480}, 
    {2946.4602,-642.7288,2.8475,98.3868}
};

new Musics[][] = // Musicas ao entrar no servidor
{
	"https://dl.dropboxusercontent.com/s/w3yd3qz9oyinm7t/svmusic.mp3",
	"https://dl.dropboxusercontent.com/s/zogi6nmzm83qhvx/ark.mp3",
	"https://dl.dropboxusercontent.com/s/s1v4w8e08c351hy/FUNK%20DAS%20WINX.mp3",
	"https://dl.dropboxusercontent.com/s/x4p2f68fpar4k0w/music1.mp3?dl=0",
	"https://dl.dropboxusercontent.com/s/7n5hyb97cn735vq/Imagine%20Dragons%20-%20Believer.mp3?dl=0"
};

// # Forwards #

forward AtualizarFome();
forward AtualizarSede();
forward AtualizarGasolina();
forward Sangrar(playerid);
forward MsgBUG(playerid);
forward manu(playerid);

// # Macros #

#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define HOLDING(%0) ((newkeys & (%0)) == (%0))

// # Modulos #

#include "../modulos/textdraws.inc"
#include "../modulos/items.inc"
#include "../modulos/inventario.inc"
#include "../modulos/loot.inc"
#include "../modulos/mapas.inc"
#include "../modulos/staffcomandos.inc"
#include "../modulos/allcomandos.inc"
#include "../modulos/vipcomandos.inc"
#include "../modulos/discord.pwn"



stock pName2(PN)
{
    new PX[MAX_PLAYER_NAME];
    GetPlayerName(PN, PX, sizeof(PX));
    return PX;
}

main()
{
	print("\n----------------------------------");
	print("-------NEXTDAY BY: JOAOGHOST--------");
	print("------EDIT BY: heyboy & Saints!-----");
	print("--------------INICIANDO-------------");
	print("----------------------------------\n");
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
	for(new i = 0; i < MAX_CRAFT; i ++)
	{
		CarregarCraft(i);
	}
	for(new i = 0; i < MAX_PORTA; i ++)
	{
		CarregarPorta(i);
	}

	
    Connect = db_open("contas.db"); // formata a variavel connect e abre a database
    
    db_free_result(db_query(Connect, "CREATE TABLE IF NOT EXISTS `contas` (`id`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,`nome`  TEXT DEFAULT '',`senha` TEXT DEFAULT '',`admin` INTEGER DEFAULT 0,`level`  INTEGER DEFAULT 0,`coin`    INTEGER DEFAULT 0,`skin`    INTEGER DEFAULT 0,`matou`    INTEGER DEFAULT 0,`morreu`    INTEGER DEFAULT 0,`mochila`    INTEGER DEFAULT 0,`fome`    INTEGER DEFAULT 0,`sede`    INTEGER DEFAULT 0,`px`    INTEGER DEFAULT 0,`py`    INTEGER DEFAULT 0,`pz`    INTEGER DEFAULT 0,`vip`    INTEGER DEFAULT 0,`gps`    INTEGER DEFAULT 0,`temcolete`    INTEGER DEFAULT 0,`capacete`    INTEGER DEFAULT 0,`vida`    INTEGER DEFAULT 0,`colete`    INTEGER DEFAULT 0,`madeira`    INTEGER DEFAULT 0,`radio`    INTEGER DEFAULT 0,`mask`    INTEGER DEFAULT 0,`ferro`    INTEGER DEFAULT 0,`pedra`    INTEGER DEFAULT 0);"));
	
    SendRconCommand(MODENAME), SendRconCommand(HOSTNAME), SendRconCommand(LANGUAGE), SendRconCommand(RCON), SendRconCommand(WEBURL);
	DisableInteriorEnterExits(), EnableStuntBonusForAll(false), ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	SetNameTagDrawDistance(30.0), ManualVehicleEngineAndLights();

    SpawnLoots();
	CarregarVeiculos();
	CarregarMapa();
	new rand = minrand(12,17);
	SetWorldTime(6);
	tempoatual = 1;
	temeperaturamundo = rand;				
    SetTimer("AtualizarFome", 120000, true);
	SetTimer("AtualizarSede", 60000, true);
	SetTimer("AtualizarGasolina", 60000, true);
//	SetTimer("AtualizarMotor", 9000, true);
	SetTimer("ciclo", 900000, true);
	SetTimer("reloot", 3600000, true);
	SetTimer("MsgBUG", 120000, true);
	
	logs = DCC_FindChannelById(logsdc);

	//trade
	CreateDynamicPickup(1254, 23,-386.9058,-1148.4536,69.3862, 0);
	Create3DTextLabel("{00FF00}Suprimentos\ndigite /trade", -1, -386.9058,-1148.4536,69.3862, 15.0, 0, 0);

	Arvores[0] = CreateDynamicObject(658, 679.617248, 342.678100, 19.225036, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[1] = CreateDynamicObject(658, 679.617248, 342.678100, 19.225036, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[2] = CreateDynamicObject(658, 599.827026, 213.498733, 21.601118, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[3] = CreateDynamicObject(658, 390.753479, 106.640335, 4.592312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[4] = CreateDynamicObject(658, 130.824905, 58.788642, 0.413884, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[5] = CreateDynamicObject(658, -345.443786, 23.651773, 33.181743, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[6] = CreateDynamicObject(658, -460.741424, -172.789962, 76.831665, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[7] = CreateDynamicObject(658, -560.227111, -174.254882, 77.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[8] = CreateDynamicObject(658, -491.749755, -66.780975, 60.562339, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[9] = CreateDynamicObject(658, -627.358215, 4.795939, 59.407562, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[10] = CreateDynamicObject(658, -574.653869, 134.700607, 20.531217, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[11] = CreateDynamicObject(658, -1300.012207, -2197.628173, 21.219097, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[12] = CreateDynamicObject(658, -1277.998168, -2257.617919, 22.797897, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[13] = CreateDynamicObject(658, -1374.619995, -2216.374023, 27.289703, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[14] = CreateDynamicObject(658, -1546.692382, -2174.729248, 6.559782, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[15] = CreateDynamicObject(658, -1665.043701, -2094.123779, 39.557891, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[16] = CreateDynamicObject(658, -1648.652832, -2215.644287, 31.298286, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	Arvores[17] = CreateDynamicObject(658, -1710.318725, -2223.307617, 45.382064, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[18] = CreateDynamicObject(658, -1719.974121, -2295.730468, 44.214645, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[19] = CreateDynamicObject(658, -1648.343383, -2341.276123, 46.974082, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[20] = CreateDynamicObject(658, -1570.641967, -2429.360351, 45.818706, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[21] = CreateDynamicObject(658, -1461.991455, -2372.167236, 15.955082, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[22] = CreateDynamicObject(658, -1369.847534, -2379.116210, 32.686683, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[23] = CreateDynamicObject(658, -1341.864257, -2457.291503, 29.966573, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[24] = CreateDynamicObject(658, -1260.438354, -2372.943115, 16.772386, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[25] = CreateDynamicObject(658, -1330.614013, -2589.546142, 39.585121, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[26] = CreateDynamicObject(658, -1607.468261, -2642.362060, 52.720294, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[27] = CreateDynamicObject(658, -1930.778686, -2066.772216, 62.081886, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[28] = CreateDynamicObject(658, -1966.536010, -1982.612792, 76.910606, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[29] = CreateDynamicObject(658, -1809.227661, -1946.908935, 90.890815, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[30] = CreateDynamicObject(658, -1822.531738, -1886.805664, 88.174308, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	Arvores[31] = CreateDynamicObject(658, -1299.356445, -2082.996093, 22.421049, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[32] = CreateDynamicObject(658, -674.446777, -2072.700927, 24.468067, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	Arvores[33] = CreateDynamicObject(658, -1652.330078, -1875.979614, 90.506393, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	Arvores[34] = CreateDynamicObject(658, -1503.098999, -1770.420776, 51.144008, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[35] = CreateDynamicObject(658, -1417.436523, -1808.154174, 45.993030, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	Arvores[36] = CreateDynamicObject(658, -1175.415893, -2471.869384, 57.859985, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	Arvores[37] = CreateDynamicObject(658, -1061.434692, -2593.798828, 78.010589, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	Arvores[38] = CreateDynamicObject(658, -862.555847, -2571.152343, 90.427474, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[39] = CreateDynamicObject(658, -1227.823120, -2620.843261, 9.710881, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	Arvores[40] = CreateDynamicObject(658, -1332.155395, -2616.987304, 16.727563, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 

	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, 679.617248, 342.678100, 19.225036, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, 679.617248, 342.678100, 19.225036, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, 599.827026, 213.498733, 21.601118, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, 390.753479, 106.640335, 4.592312, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, 130.824905, 58.788642, 0.413884, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -345.443786, 23.651773, 33.181743, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -460.741424, -172.789962, 76.831665, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -560.227111, -174.254882, 77.406250, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -491.749755, -66.780975, 60.562339, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -627.358215, 4.795939, 59.407562, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -574.653869, 134.700607, 20.531217, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1300.012207, -2197.628173, 21.219097, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1277.998168, -2257.617919, 22.797897, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1374.619995, -2216.374023, 27.289703, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1546.692382, -2174.729248, 6.559782, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1665.043701, -2094.123779, 39.557891, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1648.652832, -2215.644287, 31.298286, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1710.318725, -2223.307617, 45.382064, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1719.974121, -2295.730468, 44.214645, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1648.343383, -2341.276123, 46.974082, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1570.641967, -2429.360351, 45.818706, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1461.991455, -2372.167236, 15.955082, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1369.847534, -2379.116210, 32.686683, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1341.864257, -2457.291503, 29.966573, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1260.438354, -2372.943115, 16.772386, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1330.614013, -2589.546142, 39.585121, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1607.468261, -2642.362060, 52.720294, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1930.778686, -2066.772216, 62.081886, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1966.536010, -1982.612792, 76.910606, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1809.227661, -1946.908935, 90.890815, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1822.531738, -1886.805664, 88.174308, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1299.356445, -2082.996093, 22.421049, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -674.446777, -2072.700927, 24.468067, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1652.330078, -1875.979614, 90.506393, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1503.098999, -1770.420776, 51.144008, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1417.436523, -1808.154174, 45.993030, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1175.415893, -2471.869384, 57.859985, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1061.434692, -2593.798828, 78.010589, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -862.555847, -2571.152343, 90.427474, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1227.823120, -2620.843261, 9.710881, 20, 0);
	Create3DTextLabel("{00FF80}* Arvore * \n {A9A9A9} Pegue Madeiras",azul, -1332.155395, -2616.987304, 16.727563, 20, 0);

	ator[0] = CreateActor(67, 261.4818,2895.9587,10.2384, 90.0926);
	ator[1] = CreateActor(73, -385.3081,-1148.4958,69.3842,91.6382);
	ator[2] = CreateActor(79, -385.3656,-1138.4384,69.5629,89.4060);
	ator[3] = CreateActor(67, -390.6171,-1143.7770,69.2632,180.4003);
	ator[4] = CreateActor(133, -379.2323,-1124.4413,70.6140,355.5399);
	ator[5] = CreateActor(135, -388.2737,-1135.5786,69.5268,209.2585);
	ator[6] = CreateActor(142, -388.9610,-1152.3962,69.5000,175.8861);

	ApplyActorAnimation(ator[0], "RIOT","RIOT_CHANT",4.0,1,1,1,1,0);

	bebedortext[0] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, 2178.9702,2798.1052,10.8203, 10, 0);
	bebedortext[1] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, 1880.0948,2074.1824,11.0625, 10, 0);
	bebedortext[2] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, 2462.9690,2031.8120,11.0625, 10, 0);
	bebedortext[3] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, 1362.6451,239.2939,19.5669, 10, 0);
	bebedortext[4] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, 685.1468,-473.8537,16.5363, 10, 0);
	bebedortext[5] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, 1209.4060,-917.3860,43.0442, 10, 0);
	bebedortext[6] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, 2104.7280,-1803.6128,13.5547, 10, 0);
	bebedortext[7] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, 2420.2957,-1504.8816,24.0000, 10, 0);
	bebedortext[8] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, 926.2271,-1356.6251,13.3794, 10, 0);
	bebedortext[9] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, 812.9777,-1618.2938,13.5547, 10, 0);
	bebedortext[10] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, -2144.3264,-2457.7358,30.6250, 10, 0);
	bebedortext[11] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, -2328.0645,-164.4072,35.5547, 10, 0);
	bebedortext[12] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, -2678.1021,260.4480,4.6328, 10, 0);
	bebedortext[13] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, -2354.1089,999.3513,50.8984, 10, 0);
	bebedortext[14] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, 209.8602,-202.7691,1.5703, 10, 0);
	bebedortext[15] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, -142.3332,1222.9147,19.8992, 10, 0);
	bebedortext[16] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, -1212.8503,1827.9877,41.7188, 10, 0);
	bebedortext[17] = Create3DTextLabel( "{51A8FF}* Bebedor *\n{FFFFFF}Litros: 20/20",azul, -1943.3630,2387.3462,49.6953, 10, 0);

	galaotext[0] = Create3DTextLabel( "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: 200/200",azul, 1020.753967, -937.980407, 44.459697, 10, 0);
	galaotext[1] = Create3DTextLabel( "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: 200/200",azul, 1920.391845, -1789.534912, 15.632811, 10, 0);
	galaotext[2] = Create3DTextLabel( "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: 200/200",azul, 667.087951, -581.716003, 18.595932, 10, 0);
	galaotext[3] = Create3DTextLabel( "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: 200/200",azul, -2425.073730, 955.764221, 47.556884, 10, 0);
	galaotext[4] = Create3DTextLabel( "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: 200/200",azul, -1309.912719, 2706.951904, 52.342521, 10, 0);
	galaotext[5] = Create3DTextLabel( "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: 200/200",azul, 2133.232910, 2730.413330, 13.100315, 10, 0);
	galaotext[6] = Create3DTextLabel( "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: 200/200",azul, 2180.193603, 2485.237548, 12.930315, 10, 0);
	galaotext[7] = Create3DTextLabel( "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: 200/200",azul, 2648.048583, 1083.573364, 13.100318, 10, 0);
	galaotext[8] = Create3DTextLabel( "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: 200/200",azul, 2104.457031, 943.173034, 13.110318, 10, 0);
	galaotext[9] = Create3DTextLabel( "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: 200/200",azul, -2234.054687, -2570.366699, 34.231861, 10, 0);
	galaotext[10] = Create3DTextLabel( "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: 200/200",azul, -1702.718994, 412.100433, 9.469684, 10, 0);
	galaotext[11] = Create3DTextLabel( "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: 200/200",azul, -82.244033, -1188.752685, 3.996512, 10, 0);

	BebedorSize[0] = 20;
	BebedorSize[1] = 20;
	BebedorSize[2] = 20;
	BebedorSize[3] = 20;
	BebedorSize[4] = 20;
	BebedorSize[5] = 20;
	BebedorSize[6] = 20;
	BebedorSize[7] = 20;
	BebedorSize[8] = 20;
	BebedorSize[9] = 20;
	BebedorSize[10] = 20;
	BebedorSize[11] = 20;
	BebedorSize[12] = 20;
	BebedorSize[13] = 20;
	BebedorSize[14] = 20;
	BebedorSize[15] = 20;
	BebedorSize[16] = 20;
	BebedorSize[17] = 20;

	GalaoSize[0] = 200;
	GalaoSize[1] = 200;
	GalaoSize[2] = 200;
	GalaoSize[3] = 200;
	GalaoSize[4] = 200;
	GalaoSize[5] = 200;
	GalaoSize[6] = 200;
	GalaoSize[7] = 200;
	GalaoSize[8] = 200;
	GalaoSize[9] = 200;
	GalaoSize[10] = 200;
	GalaoSize[11] = 200;
	return 1;
	
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    if(pInfo[playerid][pAdmin] >= 4)
    {
            if(!IsPlayerInAnyVehicle(playerid))
            {
                SetPlayerPosFindZ(playerid, fX, fY, fZ);
            }
            else if(IsPlayerInAnyVehicle(playerid))
            {
                new Babatz = GetPlayerVehicleID(playerid);
                new Batz = GetPlayerVehicleSeat(playerid);
                SetVehiclePos(Babatz,fX,fY,fZ);
                SetPlayerPosFindZ(playerid, fX, fY, fZ);
                PutPlayerInVehicle(playerid,Babatz,Batz);
            }
    }
    return SendClientMessage(playerid,azul, "[INFO] Teleportado ate o local demarcado.");
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
     if(!success)
     {
            SendClientMessage(playerid,-1, "[ERRO] Comando inexistente. Use /cmds ou /duvida para ser atendido.");
            return 1;
     }
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
	for(new i; i < MAX_CAIXA; i++)
	{
		if(Craft[i][Existe]) SalvarCraft(i);
	}
	for(new i; i < MAX_CAIXA; i++)
	{ 
		if(Porta[i][Existe]) SalvarPorta(i);
	}	
    DOF2_Exit();
    db_close(Connect);
	return 1;
}
SaveWeaponsToFile(playerid)
{
	new i, path[50], string[128], weaponid, ammo;
    format(path, sizeof(path), "Armas/%s.ini", pName2(playerid));
    if (!DOF2_FileExists(path))
    {
        DOF2_CreateFile(path);
		for (i=0; i<13; i++)
		{
	    	GetPlayerWeaponData(playerid,i,weaponid,ammo);
	    	format(string,sizeof(string),"Arma - %d",i);
	    	DOF2_SetInt(path,string,weaponid);
	    	format(string,sizeof(string),"Municao - %d",i);
	    	DOF2_SetInt(path,string,ammo == 65535 ? 0 : ammo);
		}
		DOF2_SaveFile();
	}
	else
	{
		for (i=0; i<13; i++)
		{
	    	GetPlayerWeaponData(playerid,i,weaponid,ammo);
	    	format(string,sizeof(string),"Arma - %d",i);
	    	DOF2_SetInt(path,string,weaponid);
	    	format(string,sizeof(string),"Municao - %d",i);
	    	DOF2_SetInt(path,string,ammo == 65535 ? 0 : ammo);
		}
		DOF2_SaveFile();
	}
}

forward LoadArmasToFile(playerid);
public LoadArmasToFile(playerid)
{
    ResetPlayerWeapons(playerid);
	new i, path[50], string[128], weaponid, ammo;
    format(path, sizeof(path), "Armas/%s.ini", pName2(playerid));
    if(!DOF2_FileExists(path))
    {
        DOF2_CreateFile(path);
		for (i=0; i<13; i++)
		{
	    	GetPlayerWeaponData(playerid,i,weaponid,ammo);
	    	format(string,sizeof(string),"Arma - %d",i);
	    	DOF2_SetInt(path,string,weaponid);
	    	format(string,sizeof(string),"Municao - %d",i);
	    	DOF2_SetInt(path,string,ammo == 65535 ? 0 : ammo);
		}
		DOF2_SaveFile();
	}
	else
	{
		for (i=0; i<13; i++)
		{
	    	format(string,sizeof(string),"Arma - %d",i);
	    	weaponid = DOF2_GetInt(path,string);
	    	format(string,sizeof(string),"Municao - %d",i);
	    	ammo = DOF2_GetInt(path,string);
	    	GivePlayerWeapon(playerid,weaponid,ammo);
		}
	}
}
CMD:ban(playerid, params[])
{
    if(pInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]: Voce nao pode usar este comando.");
    new id;
    new motivo[128];
    new str[300];
    new path5[100];
    new ano, mes, dia;
    if(sscanf(params, "ds", id,motivo)) return SendClientMessage(playerid, -1, "Use: /ban [id] [motivo]");
    getdate(ano, mes, dia);
    format(path5, sizeof(path5), "Banidos/%s.ban", pName2(id));
    if(DOF2_FileExists(path5)) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Usuario ja banido.");
    DOF2_CreateFile(path5);
    DOF2_SetInt(path5, "Ano", ano);
    DOF2_SetInt(path5, "Mes", mes);
    DOF2_SetInt(path5, "Dia", dia);
    DOF2_SetString(path5, "Motivo", motivo);
    DOF2_SaveFile();
    format(str, sizeof(str), "{FF3C3C}O Jogador {FFFFFF}%s {FF3C3C}foi banido pelo admin {FFFFFF}%s{FF3C3C} | Motivo: {FFFFFF}%s", pName2(id), pName2(playerid), motivo);
    SendClientMessageToAll(-1, str);
    SetTimerEx( "banindo", 500, false, "i", id);
    format(str, sizeof(str), "```O Jogador %s foi banido pelo admin %s | Motivo: %s```", pName2(id), pName2(playerid), motivo);
    DCC_SendChannelMessage(logs, str);
    return 1;
}
public OnPlayerConnect(playerid)
{
	new arquivo2[128];
	new arquivo3[128];
	//new arquivo5[128];
	new ip[16];
	pInfo[playerid][pConectado] = false;
	antibug(playerid);
	grupoplayer[playerid] = -1;
	CarregarPlayerText(playerid);
	SetPlayerColor(playerid, 0xC0C0C0FF);
	GameTextForPlayer(playerid, "~r~CARREGANDO", 2000, 4);
	for(new i; i < MAX_PLAYER_ATTACHED_OBJECTS; i++) RemovePlayerAttachedObject(playerid, i); // Remove os objetos
	//new string[128];
	format(arquivo, sizeof(arquivo), "Banidos/%s.ban", pName2(playerid));
	if(DOF2_FileExists(arquivo))
	{
		ShowPlayerDialog(playerid, 378, DIALOG_STYLE_MSGBOX, "Banido", "{FF0000}Voce esta banido do servidor, verifique o CANAL PUNIDOS o motivo e as provas de seu BAN.", "Fachar", #);
		SetTimerEx( "banindo", 500, false, "i", playerid);
	}
	GetPlayerIp(playerid, ip, sizeof(ip));
	format(arquivo2, sizeof(arquivo2), "BanidosIp/%s.ip", ip);
	if(DOF2_FileExists(arquivo2))
	{
		ShowPlayerDialog(playerid, 378, DIALOG_STYLE_MSGBOX, "Banido", "{FF0000}Seu IP esta banido do servido, verifique o CANAL PUNIDOS o motivo e as provas de seu BAN.", "Fechar", #);
		SetTimerEx( "banindo", 500, false, "i", playerid);		
	}
	format(arquivo3, sizeof(arquivo3), "BanidosTemp/%s.ban", pName2(playerid));
	if(DOF2_FileExists(arquivo3))
	{
		ShowPlayerDialog(playerid, 378, DIALOG_STYLE_MSGBOX, "Banido", "{FF0000}Voce esta banido do servidor, verifique o CANAL PUNIDOS o motivo e as provas de seu BAN.", "Fechar", #);
		SetTimerEx( "banindo", 500, false, "i", playerid);		
	}
	format(arquivo3, sizeof(arquivo3), "Whitelist/%s.list", pName2(playerid));
	if(!DOF2_FileExists(arquivo3))
	{
		ShowPlayerDialog(playerid, 89, DIALOG_STYLE_MSGBOX, "Whitelist", "{FFFFFF}Voce nao esta registrado em nossa {0080FF}Whitelist {FFFFFF}Por favor visite nosso discord e peça o acesso.\n\n\nhttps://discord.gg/37CAvRV", "Sair", #);
		SetTimerEx( "banindo", 500, false, "i", playerid);
	}
	/*format(arquivo5, sizeof arquivo5, "Manutencao/%s.staff", pName2(playerid));
	if(!DOF2_FileExists(arquivo5)){
		ShowPlayerDialog(playerid, 303, DIALOG_STYLE_MSGBOX, "Manutencao", "{FFFFFF}Servidor em manutencao, aguarde ate voltar.", "Sair", #);
		SetTimerEx("manu", 500, false, "i", playerid);
	}*/
	SetTimerEx( "carregandologin", 2000, false, "i", playerid);
	new aMusic = random(sizeof(Musics));
	PlayAudioStreamForPlayer(playerid, Musics[aMusic]);
	return 1;
}

forward banindo(playerid);
public banindo(playerid)
{
	Kick(playerid);
	return 1;
}

forward carregandologin(playerid);
public carregandologin(playerid)
{
	antibug(playerid);
    new query[61], DBResult:Result;
	//new Dialog[120];
    format(query, sizeof(query), "SELECT * FROM `contas` WHERE `nome`='%s'", DB_Escape(GetName(playerid)));
    Result = db_query(Connect, query);

    if(db_num_rows(Result) == 0)
    {
        	//N�o tem uma conta..
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

stock antibug(playerid)
{
	grupoplayer[playerid] = 0;
	curandosegundos[playerid] = 0;
	caido[playerid] = false;
	rilandosegundos[playerid] = 0;
	cadeiaadm[playerid] = 0;
	avisoadm[playerid] = 0;
	errousenha[playerid] = 0;
	jarilando[playerid] = 0;
	caidosegundos[playerid] = 0;
	morto[playerid] = false;
	sanguenatela[playerid] = 0;
	fogueiraplayer[playerid] = 0;
	avisadofrio[playerid] = 0;
	pInfo[playerid][pConectado] = false;
	for(new Player_Data:i; i < Player_Data; i++) pInfo[playerid][i] = 0;
	KillTimer(timerfrio[playerid]);
	KillTimer(timercaido[playerid]);
	KillTimer(timerrilando[playerid]);
	KillTimer(timerdacura[playerid]);
	KillTimer(verificador[playerid]);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new str4[128];
	if(pInfo[playerid][pConectado] == true)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_WASTED)
		{
			ResetPlayerInventory(playerid);
			format(str4, sizeof(str4), "{EE4448}O Jogador {FFFFFF}%s {EE4448}Teve o Inventario RESETADO | (Deslogou morto)", pName2(playerid));
			SendClientMessageToAll(-1, str4);
		}
	    SavePlayer(playerid);
	    SaveInventory(playerid);
	    SaveWeaponsToFile(playerid);
	}
	for(new Player_Data:i; i < Player_Data; i++) pInfo[playerid][i] = 0;  // Resta os Dados
	pInfo[playerid][pConectado] = false;
	antibug(playerid);
	pInfo[playerid][pConectado] = false;
	new string[128];
	switch(reason)
	{
		case 0:format(string,sizeof(string), "{FFFF00}%s {C0C0C0}saiu do servidor. (Problemas de conexao)", pName2(playerid));
		case 1:format(string,sizeof(string), "{FFFF00}%s {C0C0C0}saiu do servidor. (Resolveu sair)", pName2(playerid));
		case 2:format(string,sizeof(string), "{FFFF00}%s {C0C0C0}saiu do servidor. (Kickado ou Banido)", pName2(playerid));
	}
	ProxDetectorEx(200.0, playerid, string, CinzaC);
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
		morto[playerid] = false;
		caido[playerid] = false;
        ShowPlayerDialog(playerid, 30, DIALOG_STYLE_LIST, "Escolha seu sexo", "{FFFF00}Masculino\n{0000FF}Feminino", "Selecionar",#);
	}
	KillTimer(timercaido[playerid]);

    for(new i = 0; i < 16; i++) { PlayerTextDrawShow(playerid, HUDNovo[playerid][i]); }
	for(new i = 0; i < 5; i++) { PlayerTextDrawShow(playerid, Temp[playerid][i]); }
	for(new i = 0; i < 7; i++) { PlayerTextDrawShow(playerid, StatusText[playerid][i]); }
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
	new str[128];
	if(pInfo[playerid][pConectado] == true && IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	{
		ForceDrop(playerid);
		PlayerDeaths[killerid] ++;
		PlayerKills[playerid] ++;
		SetPlayerScore(playerid, GetPlayerScore(playerid)+1);
		format(str, sizeof(str), "[CHAT KILL] %s Matou o jogador %s", pName2(killerid), PegarNome(playerid));
		SendClientMessageToAll(-1, str);
	}
	pInfo[playerid][pMadeira] = 0;
	pInfo[playerid][pTemGPS] = 0;
	pInfo[playerid][pTemRADIO] = 0;
	pInfo[playerid][pPedra] = 0;
	pInfo[playerid][pFerro] = 0;
	caido[playerid] = false;
	caidosegundos[playerid] = 0;
	morto[playerid] = true;
	sanguenatela[playerid] = 0;
	KillTimer(timercaido[playerid]);

	if(pInfo[playerid][pTemCapacete] == 1)
	{
	    RemovePlayerAttachedObject(playerid, 8);
        pInfo[playerid][pTemCapacete] = 0;
	}
	if(pInfo[playerid][pTemColete] == 1)
	{
	    RemovePlayerAttachedObject(playerid, 9);
        pInfo[playerid][pTemColete] = 0;
	}
	if(pInfo[playerid][pTemMask] == 1)
	{
	    RemovePlayerAttachedObject(playerid, 7);
        pInfo[playerid][pTemMask] = 0;
	}
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	new animlib[32], animname[32];
	GetAnimationName(GetPlayerAnimationIndex(playerid), animlib, 32, animname, 32);
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(pInfo[playerid][pConectado] == false) return SendClientMessage(playerid, -1, "VOCE NAO PODE ENVIAR MENSAGENS");
    new message[128];
	if(pInfo[playerid][pVip] == 1)
	{
		format(message, sizeof(message), "[Local]{FFFF00}[VIP] {FFFFFF}%s: %s", pName2(playerid), text);	
		ProxDetector(30.0, playerid, message, -1);
		return 0;
	}
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

   			format(str, sizeof(str), "%.0i", pInfo[playerid][pCoin]);
			PlayerTextDrawSetString(playerid, HUDNovo[playerid][4], str);

   			format(str, sizeof(str), "%.0i", PlayerKills[playerid]);
			PlayerTextDrawSetString(playerid, HUDNovo[playerid][6], str);

   			format(str, sizeof(str), "%.0i", PlayerDeaths[playerid]);
			PlayerTextDrawSetString(playerid, HUDNovo[playerid][8], str);

   			format(str, sizeof(str), "%.0i", pInfo[playerid][pMadeira]);
			PlayerTextDrawSetString(playerid, HUDNovo[playerid][10], str);

   			format(str, sizeof(str), "%.0i", pInfo[playerid][pPedra]);
			PlayerTextDrawSetString(playerid, HUDNovo[playerid][12], str);

			format(str, sizeof(str), "%.0i", temeperaturamundo);
			PlayerTextDrawSetString(playerid, Temp[playerid][2], str);

			format(str, sizeof(str), "%.0i%", pInfo[playerid][pFome]);
			PlayerTextDrawSetString(playerid, StatusText[playerid][3], str);

			format(str, sizeof(str), "%.0i%", pInfo[playerid][pSede]);
			PlayerTextDrawSetString(playerid, StatusText[playerid][5], str);

			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				new vehicleid = GetPlayerVehicleID(playerid)
				;
				if(IsABike(vehicleid)) { SetVehicleParamsEx(vehicleid, 1, lights, alarm, doors, bonnet, boot, objective); } 
				format(str, sizeof(str), "Gas: ~r~%i~n~~w~Motor: %s", vInfo[vehicleid][vCombustivel], vInfo[vehicleid][vTemMotor] ? ("~g~Sim") : ("~r~Nao"));
				PlayerTextDrawSetString(playerid, VEH_HUD[playerid][3], str);
				if(vInfo[vehicleid][vCombustivel] <= 0)
				{
					SetVehicleParamsEx(vehicleid, 0, lights, alarm, 0, bonnet, boot, objective);
				}
				if(vInfo[vehicleid][vTemMotor] == false)
				{
					SetVehicleParamsEx(vehicleid, 0, lights, alarm, 0, bonnet, boot, objective);
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
		if(PlayerNoLugar(playerid, 2.0, 679.617248, 342.678100, 19.225036)
		|| PlayerNoLugar(playerid, 2.0,  599.827026, 213.498733, 21.601118)
		|| PlayerNoLugar(playerid, 2.0,  390.753479, 106.640335, 4.592312)
		|| PlayerNoLugar(playerid, 2.0,  130.824905, 58.788642, 0.413884)
		|| PlayerNoLugar(playerid, 2.0,  -345.443786, 23.651773, 33.181743)
		|| PlayerNoLugar(playerid, 2.0,  -460.741424, -172.789962, 76.831665)
		|| PlayerNoLugar(playerid, 2.0,  -560.227111, -174.254882, 77.406250)
		|| PlayerNoLugar(playerid, 2.0,  -491.749755, -66.780975, 60.562339)
		|| PlayerNoLugar(playerid, 2.0,  -627.358215, 4.795939, 59.407562)
		|| PlayerNoLugar(playerid, 2.0,  -574.653869, 134.700607, 20.531217)
		|| PlayerNoLugar(playerid, 2.0,  -1300.012207, -2197.628173, 21.219097)
		|| PlayerNoLugar(playerid, 2.0,  -1277.998168, -2257.617919, 22.797897)
		|| PlayerNoLugar(playerid, 2.0,  -1374.619995, -2216.374023, 27.289703)
		|| PlayerNoLugar(playerid, 2.0,   -1546.692382, -2174.729248, 6.559782)
		|| PlayerNoLugar(playerid, 2.0,  -1665.043701, -2094.123779, 39.557891)
		|| PlayerNoLugar(playerid, 2.0,  -1648.652832, -2215.644287, 31.298286)
		|| PlayerNoLugar(playerid, 2.0,  -1710.318725, -2223.307617, 45.382064)
		|| PlayerNoLugar(playerid, 2.0,  -1719.974121, -2295.730468, 44.214645)
		|| PlayerNoLugar(playerid, 2.0,  -1648.343383, -2341.276123, 46.974082)
		|| PlayerNoLugar(playerid, 2.0,  -1570.641967, -2429.360351, 45.818706)
		|| PlayerNoLugar(playerid, 2.0,  -1461.991455, -2372.167236, 15.955082)
		|| PlayerNoLugar(playerid, 2.0,  -1369.847534, -2379.116210, 32.686683)
		|| PlayerNoLugar(playerid, 2.0,  -1341.864257, -2457.291503, 29.966573)
		|| PlayerNoLugar(playerid, 2.0,  -1260.438354, -2372.943115, 16.772386)
		|| PlayerNoLugar(playerid, 2.0,  -1330.614013, -2589.546142, 39.585121)
		|| PlayerNoLugar(playerid, 2.0,  -1607.468261, -2642.362060, 52.720294)
		|| PlayerNoLugar(playerid, 2.0,  -1930.778686, -2066.772216, 62.081886)
		|| PlayerNoLugar(playerid, 2.0,  -1966.536010, -1982.612792, 76.910606)
		|| PlayerNoLugar(playerid, 2.0,  -1809.227661, -1946.908935, 90.890815)
		|| PlayerNoLugar(playerid, 2.0,  -1822.531738, -1886.805664, 88.174308)
		|| PlayerNoLugar(playerid, 2.0,  -1299.356445, -2082.996093, 22.421049)
		|| PlayerNoLugar(playerid, 2.0,  -674.446777, -2072.700927, 24.468067)
		|| PlayerNoLugar(playerid, 2.0,  -1652.330078, -1875.979614, 90.506393)
		|| PlayerNoLugar(playerid, 2.0,  -1503.098999, -1770.420776, 51.144008)
		|| PlayerNoLugar(playerid, 2.0,  -1417.436523, -1808.154174, 45.993030)
		|| PlayerNoLugar(playerid, 2.0,  -1175.415893, -2471.869384, 57.859985)
		|| PlayerNoLugar(playerid, 2.0,  -1061.434692, -2593.798828, 78.010589)
		|| PlayerNoLugar(playerid, 2.0,  -862.555847, -2571.152343, 90.427474)
		|| PlayerNoLugar(playerid, 2.0,  -1227.823120, -2620.843261, 9.710881)
		|| PlayerNoLugar(playerid, 2.0,  -1332.155395, -2616.987304, 16.727563))
		{
            {
                if(natora[playerid] == false)
                {
                	if(!PlayerHasItem(playerid, "Motoserra")) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao possui uma moto-serra.");
                	GameTextForPlayer(playerid, "~w~Coletando ~g~Madeira", 1000, 4);
                	SetPlayerAttachedObject(playerid, 5, 341, 6, 0.150000, 0.000000, 0.182000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
                	ApplyAnimation(playerid, "CHAINSAW", "CSAW_2", 4.1, 1, 0, 0, 1, 0, 0);
					SetTimerEx( "pegandomadeira", 6000, false, "i", playerid);
					natora[playerid] = true;
				}
				else return SendClientMessage(playerid, azul, "{CE0000}[ERRO] Voce ja esta coletando madeira.");
			}
		}
	}
    if(newkeys & KEY_FIRE && oldkeys & KEY_CROUCH)
	{
		if(GetPlayerWeapon(playerid) == 24)
		{
			ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 0, 0, 1);
			SendClientMessage(playerid, COR_VERMELHO, "[AntiCBUG] Pare com o cbug!");
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
        if(!response) Kick(playerid);
        new query[3000];
		format(query, sizeof(query), "INSERT INTO `contas` (`nome`,`senha`,`admin`,`level`,`coin`,`skin`,`matou`,`morreu`,`mochila`,`fome`,`sede`,`px`,`py`,`pz`,`vip`,`gps`,`temcolete`,`capacete`,`vida`,`colete`,`madeira`,`radio`,`mask`,`ferro`,`pedra`) VALUES ('%s','%s','0','0','0','0','0','0','0','0','0','0.0','0.0','0.0','0','0','0','0','0.0','0.0','0','0','0','0','0')", DB_Escape(GetName(playerid)), DB_Escape(inputtext));
        db_free_result(db_query(Connect, query));

        pInfo[playerid][pConectado] = true;
        pInfo[playerid][pAdmin] = 0;
        pInfo[playerid][pSkin] = 0;
        pInfo[playerid][pLevel] = 0;
        pInfo[playerid][pCoin] = 0;
        PlayerKills[playerid] = 0;
        PlayerDeaths[playerid] = 0;
        pInfo[playerid][pBackpack] = 5;
        pInfo[playerid][pFome] = 50;
        pInfo[playerid][pSede] = 50;
        pInfo[playerid][pPosX] = 0.0;
        pInfo[playerid][pPosY] = 0.0;
        pInfo[playerid][pPosZ] = 0.0;
        pInfo[playerid][pVip] = 0;
        pInfo[playerid][pTemGPS] = 0;
        pInfo[playerid][pTemColete] = 0;
        pInfo[playerid][pTemCapacete] = 0;
        pInfo[playerid][pMadeira] = 0;
        pInfo[playerid][pTemRADIO] = 0;
        pInfo[playerid][pFerro] = 0;
        pInfo[playerid][pPedra] = 0;
        pInfo[playerid][pTemMask] = 0;
        vida32[playerid] = 100.0;
        colete32[playerid] = 0;
        pInfo[playerid][pRespawn] = 2;
        SetSpawnInfo(playerid, 1, 70, 0.0,0.0,0.0,0.0,0,0,0,0,0,0);
        SpawnPlayer(playerid);
        verificador[playerid] = SetTimerEx( "verificacao", 5000, true, "i", playerid);
        return 1;
       
	}
	if(dialogid == 1)
	{
        if(!response) Kick(playerid);
        new query[118], DBResult:Result;
        format(query, sizeof(query), "SELECT * FROM `contas` WHERE `nome` = '%s' AND `senha` = '%s'", DB_Escape(GetName(playerid)), DB_Escape(inputtext));
        Result = db_query(Connect, query);
        
        if(db_num_rows(Result) == 0)
        {
			if(errousenha[playerid] == 3) return Kick(playerid);
            SendClientMessage(playerid, COR_VERMELHO, "* Voce errou sua senha! 1/3");
			errousenha[playerid]++;
			ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "Voce ja possui uma conta", "Voce ja possui uma conta, digite sua para poder logar", "Logar", "sair");
            return 0;
		}
        else
        {
            //Acertou a senha
            new field[20];
            db_get_field_assoc(Result, "admin", field, sizeof(field));
        	pInfo[playerid][pAdmin] = strval(field);
        	
         	db_get_field_assoc(Result, "skin", field, sizeof(field));
        	pInfo[playerid][pSkin] = strval(field);
        	
         	db_get_field_assoc(Result, "fome", field, sizeof(field));
        	pInfo[playerid][pFome] = strval(field);
        	
         	db_get_field_assoc(Result, "sede", field, sizeof(field));
        	pInfo[playerid][pSede] = strval(field);
        	
        	db_get_field_assoc(Result, "coin", field, sizeof(field));
        	pInfo[playerid][pCoin] = strval(field);
        	
        	db_get_field_assoc(Result, "level", field, sizeof(field));
        	pInfo[playerid][pLevel] = strval(field);
        	
       		db_get_field_assoc(Result, "mochila", field, sizeof(field));
        	pInfo[playerid][pBackpack] = strval(field);
        	
       		db_get_field_assoc(Result, "px", field, sizeof(field));
        	pInfo[playerid][pPosX] = float(strval(field));
        	
       		db_get_field_assoc(Result, "py", field, sizeof(field));
        	pInfo[playerid][pPosY] = float(strval(field));
        	
       		db_get_field_assoc(Result, "pz", field, sizeof(field));
        	pInfo[playerid][pPosZ] = float(strval(field));
        	
       		db_get_field_assoc(Result, "vip", field, sizeof(field));
        	pInfo[playerid][pVip] = strval(field);
        	
       		db_get_field_assoc(Result, "gps", field, sizeof(field));
        	pInfo[playerid][pTemGPS] = strval(field);
        	
       		db_get_field_assoc(Result, "temcolete", field, sizeof(field));
        	pInfo[playerid][pTemColete] = strval(field);
        	
       		db_get_field_assoc(Result, "capacete", field, sizeof(field));
        	pInfo[playerid][pTemCapacete] = strval(field);
        	
       		db_get_field_assoc(Result, "vida", field, sizeof(field));
        	vida32[playerid] = float(strval(field));
        	
       		db_get_field_assoc(Result, "colete", field, sizeof(field));
        	colete32[playerid] = float(strval(field));
        	
       		db_get_field_assoc(Result, "madeira", field, sizeof(field));
        	pInfo[playerid][pMadeira] = strval(field);
        	
       		db_get_field_assoc(Result, "radio", field, sizeof(field));
        	pInfo[playerid][pTemRADIO] = strval(field);
        	
       		db_get_field_assoc(Result, "mask", field, sizeof(field));
        	pInfo[playerid][pTemMask] = strval(field);
        	
       		db_get_field_assoc(Result, "ferro", field, sizeof(field));
        	pInfo[playerid][pFerro] = strval(field);
        	
       		db_get_field_assoc(Result, "pedra", field, sizeof(field));
        	pInfo[playerid][pPedra] = strval(field);

       		db_get_field_assoc(Result, "matou", field, sizeof(field));
        	PlayerKills[playerid] = strval(field);

       		db_get_field_assoc(Result, "morreu", field, sizeof(field));
        	PlayerDeaths[playerid] = strval(field);
        	
        	for(new i = 0; i < 100; i++) SendClientMessage(playerid,-1, " ");
			SendClientMessage(playerid, azul, "Logado com sucesso!");
/*   			new string[64];
			format(string,sizeof(string), "{FFFF00}%s {C0C0C0}Entrou no servidor.", pName2(playerid));
			ProxDetectorEx(100.0, playerid, string, CinzaC); */
            pInfo[playerid][pConectado] = true;
            SetSpawnInfo(playerid, 1, 70, pInfo[playerid][pPosX],pInfo[playerid][pPosY],pInfo[playerid][pPosZ],0,0,0,0,0,0,0);
            SpawnPlayer(playerid);
            SetTimerEx( "carregandodados", 3000, false, "i", playerid);
            SetTimerEx( "LoadArmasToFile", 500, false, "i", playerid);
            LoadInventory(playerid);
		}
        db_free_result(Result);
        return 1;
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
				sexo[playerid] = 1;
			}
			if(listitem == 1)
			{
		        SendClientMessage(playerid, azul, "Voce escolheu uma skin feminina");
		        SetPlayerSkin(playerid, 90);
				sexo[playerid] = 2;
			}
		}
	}
    if(dialogid == 67)
    {
        if(response) //Ao Clickar no primeiro bot�o
        {
            if(listitem == 0) //Ao clickar no primeiro item
            {
				ShowPlayerDialog(playerid, 68, DIALOG_STYLE_LIST, "Defesas", "{76CA6C}Parede Nivel 1\n{76CA6C}Porta Nivel 1", "Ver Craft", "Fechar");
            }
            if(listitem == 1) //Ao clickar no segundo item
            {
				ShowPlayerDialog(playerid, 69, DIALOG_STYLE_MSGBOX, "Maquinas", "{76CA6C}Em Breve", "Fechar", #);
            }
            if(listitem == 2) //Ao clickar no terceiro item
            {
                ShowPlayerDialog(playerid, 70, DIALOG_STYLE_LIST, "Itens", "{76CA6C}Fogueira\n{76CA6C}TNT Cronometrada", "Ver Craft", "Fechar");
            }
			if(listitem == 3)
			{
				ShowPlayerDialog(playerid, 71, DIALOG_STYLE_LIST, "Bancadas", "{76CA6C}Banca de trabalho\nCaixa", "Ver Craft", "Fechar");
			}
        }
    }
    if(dialogid == 68)
    {
        if(response) //Ao Clickar no primeiro bot�o
        {
            if(listitem == 0) //Ao clickar no primeiro item
            {
				ShowPlayerDialog(playerid, 69, DIALOG_STYLE_MSGBOX, "Parede Nivel", "{FFFFFF}45 {4AC13E}Madeiras\n{FF0000}Para fazer use /criarparede", "fechar", #);
            }
            if(listitem == 1) //Ao clickar no segundo item
            {
				ShowPlayerDialog(playerid, 69, DIALOG_STYLE_MSGBOX, "Porta Nivel 1", "{FFFFFF}30 {4AC13E}Madeiras\n{FFFFFF}1 {4AC13E}Martelo\n{FF0000}Para fazer use /criarporta", "fechar", #);
            }
            if(listitem == 2) //Ao clickar no terceiro item
            {
                //Fun��o se o player clickar no terceiro item
            }
        }
    }
	if(dialogid == 70)
	{
		if(response)
		{
			if(listitem == 0)
			{
				ShowPlayerDialog(playerid, 72, DIALOG_STYLE_MSGBOX, "Fogueira", "{FFFFFF}9 {4AC13E}Madeiras\n{FFFFFF}1 {4AC13E}Isqueiro", "Fazer", "Fechar");
			}
			if(listitem == 1)
			{
				ShowPlayerDialog(playerid, 73, DIALOG_STYLE_MSGBOX, "TNT Cronometrada", "{FFFFFF}1 {4AC13E}TNT\n{FFFFFF}1 {4AC13E}Celular\n\n{FF1515}So e possivel fazer em uma mesa de trabalho.", "Fechar", #);
			}
		}
	}
	if(dialogid == 71)
	{
		if(response)
		{
			if(listitem == 0)
			{
				ShowPlayerDialog(playerid, 55, DIALOG_STYLE_MSGBOX, "Mesa de Trabalho", "{FFFFFF}30 {5BCD3F} Mesa de Trabalho\n{FFFFFF}1 {5BCD3F}Martelo\n{FF0000}Para fazer use /criarcraft", "Fechar", #);
			}
			if(listitem == 1)
			{
				ShowPlayerDialog(playerid, 56, DIALOG_STYLE_MSGBOX, "Caixa", "{FFFFFF}35 {5BCD3F} Madeira\n{FF0000}Para fazer use /criarcaixa", "Fechar", #);
			}
		}
	}
	if(dialogid == 72)
	{
		if(response)
		{
			if(!PlayerHasItem(playerid, "Isqueiro")) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem um isqueiro");
			if(pInfo[playerid][pMadeira] >= 9)
			{
				AddItem(playerid, "Fogueira", 1);
				pInfo[playerid][pMadeira]-=9;
				SendClientMessage(playerid, COR_AMARELO, "[Craft] Voce fez 1 fogueira");
			}
		}
	}
	if(dialogid == 45)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(!PlayerHasItem(playerid, "TNT")) return SendClientMessage(playerid, -1, "Voce nao possui uma TNT");
				if(!PlayerHasItem(playerid, "Celular")) return SendClientMessage(playerid, -1, "Voce nao possui uma Celular");
				RemoveItem(playerid, "TNT", 1);
				RemoveItem(playerid, "Celular", 1);
				AddItem(playerid, "TNT Cronometrada", 1);
				SendClientMessage(playerid, -1, "Voce fez uma TNT Cronometrada");
			}
			if(listitem == 1)
			{
				if(!PlayerHasItem(playerid, "Isqueiro")) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem um isqueiro");
				if(pInfo[playerid][pMadeira] < 9) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao possui madeiras suficientes");
				pInfo[playerid][pMadeira] -=9;
				AddItem(playerid, "Fogueira", 1);
			}
			if(listitem == 2)
			{
				if(!PlayerHasItem(playerid, "Roupa")) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem um roupa");
				RemoveItem(playerid, "Roupa", 1);
				AddItem(playerid, "Pano", 1);
				SendClientMessage(playerid, -1, "Craftado com sucesso");
			}
			if(listitem == 3)
			{
				if(!PlayerHasItem(playerid, "Pano")) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem um Pano");	
				if(!PlayerHasItem(playerid, "Garrafa vazia")) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem uma garrafa vazia");
				if(!PlayerHasItem(playerid, "Galao de combustivel")) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem um galao de combustivel");
				if(!PlayerHasItem(playerid, "Isqueiro")) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem um isqueiro");
				RemoveItem(playerid, "Pano", 1);
				RemoveItem(playerid, "Garrafa vazia", 1);
				RemoveItem(playerid, "Galao de combustivel", 1);
				AddItem(playerid, "Molotov", 1);
				AddItem(playerid, "Galao vazio", 1);
				SendClientMessage(playerid, -1, "Craftado com sucesso");
			}
		}
	}
	if(dialogid == 57)
	{
		if(response)
		{
			if(listitem == 0)
			{
				SetPlayerColor(playerid, 0xFFFF00FF);
				SendClientMessage(playerid, COR_AMARELO, "Cor mudada com sucesso");
			}
			if(listitem == 1)
			{
				SetPlayerColor(playerid, 0xFF0000FF);
				SendClientMessage(playerid, COR_AMARELO, "Cor mudada com sucesso");
			}
			if(listitem == 2)
			{
				SetPlayerColor(playerid, 0x0080FFFF);
				SendClientMessage(playerid, COR_AMARELO, "Cor mudada com sucesso");
			}
			if(listitem == 3)
			{
				SetPlayerColor(playerid, 0xFF8000FF);
				SendClientMessage(playerid, COR_AMARELO, "Cor mudada com sucesso");
			}
			if(listitem == 4)
			{
				SetPlayerColor(playerid, 0x80FFFFFF);
				SendClientMessage(playerid, COR_AMARELO, "Cor mudada com sucesso");
			}
			if(listitem == 5)
			{
				SetPlayerColor(playerid, 0xC0C0C0FF);
				SendClientMessage(playerid, COR_AMARELO, "Cor mudada com sucesso");
			}
		}
	}
	if(dialogid == 310)
	{
		if(response)
		{
			if(listitem == 0)
			{
				GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
				new id = ideditorp[playerid];
				new str[60];
				DestroyDynamicObject(Parede[id][ObjectJ]);
				Parede[id][PosX] = Parede[id][PosX]+0.3;
				Parede[id][ObjectJ] = CreateDynamicObject(19360, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], Parede[id][RX], Parede[id][RY], Parede[id][RZ]);	
				Delete3DTextLabel(Parede[id][Text3Dp]);
				format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Parede[id][metallife]);
				Parede[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 10, 0, 0);	
				ShowPlayerDialog(playerid, 310, DIALOG_STYLE_LIST, "Editor Teste 1.1.0", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
				SetPlayerPos(playerid, pInfo[playerid][pPosX]+0.1, pInfo[playerid][pPosY], pInfo[playerid][pPosZ]+0.3);
			}
			if(listitem == 1)
			{
				GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
				new id = ideditorp[playerid];
				new str[60];
				DestroyDynamicObject(Parede[id][ObjectJ]);
				Parede[id][PosX] = Parede[id][PosX]-0.3;
				Parede[id][ObjectJ] = CreateDynamicObject(19360, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], Parede[id][RX], Parede[id][RY], Parede[id][RZ]);	
				Delete3DTextLabel(Parede[id][Text3Dp]);
				format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Parede[id][metallife]);
				Parede[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 10, 0, 0);	
				ShowPlayerDialog(playerid, 310, DIALOG_STYLE_LIST, "Editor Teste 1.1.0", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
				SetPlayerPos(playerid, pInfo[playerid][pPosX]+0.1, pInfo[playerid][pPosY], pInfo[playerid][pPosZ]+0.3);
			}
			if(listitem == 2)
			{
				GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
				new id = ideditorp[playerid];
				new str[60];
				DestroyDynamicObject(Parede[id][ObjectJ]);
				Parede[id][PosY] = Parede[id][PosY]+0.3;
				Parede[id][ObjectJ] = CreateDynamicObject(19360, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], Parede[id][RX], Parede[id][RY], Parede[id][RZ]);	
				Delete3DTextLabel(Parede[id][Text3Dp]);
				format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Parede[id][metallife]);
				Parede[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 10, 0, 0);	
				ShowPlayerDialog(playerid, 310, DIALOG_STYLE_LIST, "Editor Teste 1.1.0", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
				SetPlayerPos(playerid, pInfo[playerid][pPosX]+0.1, pInfo[playerid][pPosY], pInfo[playerid][pPosZ]+0.3);
			}
			if(listitem == 3)
			{
				GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
				new id = ideditorp[playerid];
				new str[60];
				DestroyDynamicObject(Parede[id][ObjectJ]);
				Parede[id][PosY] = Parede[id][PosY]-0.3;
				Parede[id][ObjectJ] = CreateDynamicObject(19360, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], Parede[id][RX], Parede[id][RY], Parede[id][RZ]);	
				Delete3DTextLabel(Parede[id][Text3Dp]);
				format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Parede[id][metallife]);
				Parede[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 10, 0, 0);	
				ShowPlayerDialog(playerid, 310, DIALOG_STYLE_LIST, "Editor Teste 1.1.0", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
				SetPlayerPos(playerid, pInfo[playerid][pPosX]+0.1, pInfo[playerid][pPosY], pInfo[playerid][pPosZ]+0.3);
			}
			if(listitem == 4)
			{
				GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
				new id = ideditorp[playerid];
				new str[60];
				DestroyDynamicObject(Parede[id][ObjectJ]);
				Parede[id][PosZ] = Parede[id][PosZ]+0.3;
				Parede[id][ObjectJ] = CreateDynamicObject(19360, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], Parede[id][RX], Parede[id][RY], Parede[id][RZ]);	
				Delete3DTextLabel(Parede[id][Text3Dp]);
				format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Parede[id][metallife]);
				Parede[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 10, 0, 0);
				SetPlayerPos(playerid, pInfo[playerid][pPosX]+0.1, pInfo[playerid][pPosY], pInfo[playerid][pPosZ]+0.3);	
				ShowPlayerDialog(playerid, 310, DIALOG_STYLE_LIST, "Editor Teste 1.1.0", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
			}
			if(listitem == 5)
			{
				GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
				new id = ideditorp[playerid];
				new str[60];
				DestroyDynamicObject(Parede[id][ObjectJ]);
				Parede[id][PosZ] = Parede[id][PosZ]-0.3;
				Parede[id][ObjectJ] = CreateDynamicObject(19360, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], Parede[id][RX], Parede[id][RY], Parede[id][RZ]);	
				Delete3DTextLabel(Parede[id][Text3Dp]);
				format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Parede[id][metallife]);
				Parede[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 10, 0, 0);	
				SetPlayerPos(playerid, pInfo[playerid][pPosX]+0.1, pInfo[playerid][pPosY], pInfo[playerid][pPosZ]+0.3);
				ShowPlayerDialog(playerid, 310, DIALOG_STYLE_LIST, "Editor Teste 1.1.0", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
			}
			if(listitem == 6)
			{
				GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
				new id = ideditorp[playerid];
				new str[60];
				DestroyDynamicObject(Parede[id][ObjectJ]);
				Parede[id][RZ] = Parede[id][RZ]+90;
				Parede[id][ObjectJ] = CreateDynamicObject(19360, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], Parede[id][RX], Parede[id][RY], Parede[id][RZ]);	
				Delete3DTextLabel(Parede[id][Text3Dp]);
				format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Parede[id][metallife]);
				Parede[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 10, 0, 0);	
				SetPlayerPos(playerid, pInfo[playerid][pPosX]+0.1, pInfo[playerid][pPosY], pInfo[playerid][pPosZ]+1.3);
				ShowPlayerDialog(playerid, 310, DIALOG_STYLE_LIST, "Editor Teste 1.1.0", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
			}
		}
	}
	if(dialogid == 311)
	{
		if(response)
		{
			if(listitem == 0)
			{
				GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
				new id = ideditorp[playerid];
				new str[60];
				DestroyDynamicObject(Porta[id][ObjectP]);
				Porta[id][PosX] = Porta[id][PosX]+0.3;
				Porta[id][ObjectP] = CreateDynamicObject(1497, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], Porta[id][RX], Porta[id][RY], Porta[id][RZ]);	
				Delete3DTextLabel(Porta[id][Text3Dp]);
				format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Porta[id][metallife]);
				Porta[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], 10, 0, 0);	
				ShowPlayerDialog(playerid, 311, DIALOG_STYLE_LIST, "Editor Teste 1.1.0", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
				SetPlayerPos(playerid, pInfo[playerid][pPosX]+0.1, pInfo[playerid][pPosY], pInfo[playerid][pPosZ]+0.3);
			}
			if(listitem == 1)
			{
				GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
				new id = ideditorp[playerid];
				new str[60];
				DestroyDynamicObject(Porta[id][ObjectP]);
				Porta[id][PosX] = Porta[id][PosX]-0.3;
				Porta[id][ObjectP] = CreateDynamicObject(1497, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], Porta[id][RX], Porta[id][RY], Porta[id][RZ]);	
				Delete3DTextLabel(Porta[id][Text3Dp]);
				format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Porta[id][metallife]);
				Porta[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], 10, 0, 0);	
				ShowPlayerDialog(playerid, 311, DIALOG_STYLE_LIST, "Editor Teste 1.1.0", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
				SetPlayerPos(playerid, pInfo[playerid][pPosX]+0.1, pInfo[playerid][pPosY], pInfo[playerid][pPosZ]+0.3);
			}
			if(listitem == 2)
			{
				GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
				new id = ideditorp[playerid];
				new str[60];
				DestroyDynamicObject(Porta[id][ObjectP]);
				Porta[id][PosY] = Porta[id][PosY]+0.3;
				Porta[id][ObjectP] = CreateDynamicObject(1497, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], Porta[id][RX], Porta[id][RY], Porta[id][RZ]);	
				Delete3DTextLabel(Porta[id][Text3Dp]);
				format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Porta[id][metallife]);
				Porta[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], 10, 0, 0);	
				ShowPlayerDialog(playerid, 311, DIALOG_STYLE_LIST, "Editor Teste 1.1.0", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
				SetPlayerPos(playerid, pInfo[playerid][pPosX]+0.1, pInfo[playerid][pPosY], pInfo[playerid][pPosZ]+0.3);
			}
			if(listitem == 3)
			{
				GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
				new id = ideditorp[playerid];
				new str[60];
				DestroyDynamicObject(Porta[id][ObjectP]);
				Porta[id][PosY] = Porta[id][PosY]-0.3;
				Porta[id][ObjectP] = CreateDynamicObject(1497, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], Porta[id][RX], Porta[id][RY], Porta[id][RZ]);	
				Delete3DTextLabel(Porta[id][Text3Dp]);
				format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Porta[id][metallife]);
				Porta[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], 10, 0, 0);	
				ShowPlayerDialog(playerid, 311, DIALOG_STYLE_LIST, "Editor Teste 1.1.0", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
				SetPlayerPos(playerid, pInfo[playerid][pPosX]+0.1, pInfo[playerid][pPosY], pInfo[playerid][pPosZ]+0.3);
			}
			if(listitem == 4)
			{
				GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
				new id = ideditorp[playerid];
				new str[60];
				DestroyDynamicObject(Porta[id][ObjectP]);
				Porta[id][PosZ] = Porta[id][PosZ]+0.3;
				Porta[id][ObjectP] = CreateDynamicObject(1497, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], Porta[id][RX], Porta[id][RY], Porta[id][RZ]);	
				Delete3DTextLabel(Porta[id][Text3Dp]);
				format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Porta[id][metallife]);
				Porta[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], 10, 0, 0);
				SetPlayerPos(playerid, pInfo[playerid][pPosX]+0.1, pInfo[playerid][pPosY], pInfo[playerid][pPosZ]+0.3);	
				ShowPlayerDialog(playerid, 311, DIALOG_STYLE_LIST, "Editor Teste 1.1.0", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
			}
			if(listitem == 5)
			{
				GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
				new id = ideditorp[playerid];
				new str[60];
				DestroyDynamicObject(Porta[id][ObjectP]);
				Porta[id][PosZ] = Porta[id][PosZ]-0.3;
				Porta[id][ObjectP] = CreateDynamicObject(1497, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], Porta[id][RX], Porta[id][RY], Porta[id][RZ]);	
				Delete3DTextLabel(Porta[id][Text3Dp]);
				format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Porta[id][metallife]);
				Porta[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], 10, 0, 0);	
				SetPlayerPos(playerid, pInfo[playerid][pPosX]+0.1, pInfo[playerid][pPosY], pInfo[playerid][pPosZ]+0.3);
				ShowPlayerDialog(playerid, 311, DIALOG_STYLE_LIST, "Editor Teste 1.1.0", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
			}
			if(listitem == 6)
			{
				GetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
				new id = ideditorp[playerid];
				new str[60];
				DestroyDynamicObject(Porta[id][ObjectP]);
				Porta[id][RZ] = Porta[id][RZ]+90;
				Porta[id][ObjectP] = CreateDynamicObject(1497, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], Porta[id][RX], Porta[id][RY], Porta[id][RZ]);	
				Delete3DTextLabel(Porta[id][Text3Dp]);
				format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Porta[id][metallife]);
				Porta[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], 10, 0, 0);	
				SetPlayerPos(playerid, pInfo[playerid][pPosX]+0.1, pInfo[playerid][pPosY], pInfo[playerid][pPosZ]+1.3);
				ShowPlayerDialog(playerid, 311, DIALOG_STYLE_LIST, "Editor Teste 1.1.0", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
			}
		}
	}
	if(dialogid == 301)
	{
		if(!response) ShowPlayerDialog(playerid, 301, DIALOG_STYLE_INPUT, "Coloque uma senha", "Digite uma senha para colocar na PORTA", "Confirmar", #);
		if(response)
		{
			new id = idporta[playerid];
			format(Porta[id][Senha], 50, inputtext);
			SendClientMessage(playerid, COR_AMARELO, "Senha setada com sucesso!");
			ideditorp[playerid] = id;
			ShowPlayerDialog(playerid, 311, DIALOG_STYLE_LIST, "Editor Teste 1.1.1", "{3E9EFF}+X\n{3E9EFF}-X\n{3E9EFF}+Y\n{3E9EFF}-Y\n{3E9EFF}UP\n{3E9EFF}DOWN\n{3E9EFF}+RZ", "Selecionar", "Fechar");
		}
	}
	if(dialogid == 302)
	{
		if(response)
		{
			new id = idporta[playerid];
			new pass[50];
			format(pass, 50, inputtext);
			if(strcmp(Porta[id][Senha], pass)) return SendClientMessage(playerid, -1, "senha errada");
			DestroyDynamicObject(Porta[id][ObjectP]);
			SendClientMessage(playerid, -1, "Porta fechada use /fechar");
		}
	}
    if(dialogid == 120)
	{
		if(response)
	    {
     		if(listitem == 0)
	        {
	            if(pInfo[playerid][pCoin] < 120) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem dinheiro suficiente");
                AddItem(playerid, "Motoserra", 1);
				pInfo[playerid][pCoin] -=120;
				SendClientMessage(playerid, azul, "[INFO] Item adquirido, cheque seu inventario.");
			}
			if(listitem == 1)
			{
	            if(pInfo[playerid][pCoin] < 150) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem dinheiro suficiente");
                AddItem(playerid, "Toolbox", 1);
				pInfo[playerid][pCoin] -=150;
				SendClientMessage(playerid, azul, "[INFO] Item adquirido, cheque seu inventario.");
			}
			if(listitem == 2)
			{
				if(pInfo[playerid][pCoin] < 420) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem dinheiro suficiente");
                AddItem(playerid, "Motor", 1);
				pInfo[playerid][pCoin] -=420;
				SendClientMessage(playerid, azul, "[INFO] Item adquirido, cheque seu inventario.");
			}
			if(listitem == 3)
			{
				if(pInfo[playerid][pCoin] < 620) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem dinheiro suficiente");
				AddItem(playerid, "Colete", 1); 
				pInfo[playerid][pCoin] -=620;
				SendClientMessage(playerid, azul, "[INFO] Item adquirido, cheque seu inventario.");
			}
			if(listitem == 4)
			{
				if(pInfo[playerid][pCoin] < 230) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem dinheiro suficiente");
				AddItem(playerid, "Mochila de caca", 1);
				pInfo[playerid][pCoin] -=230;
				SendClientMessage(playerid, azul, "[INFO] Item adquirido, cheque seu inventario.");
			}
			if(listitem == 5)
			{
				if(pInfo[playerid][pCoin] < 90) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem dinheiro suficiente");
				AddItem(playerid, "Martelo", 1);
				pInfo[playerid][pCoin] -=90;
				SendClientMessage(playerid, azul, "[INFO] Item adquirido, cheque seu inventario.");
			}
			if(listitem == 6)
			{
				if(pInfo[playerid][pCoin] < 70) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem dinheiro suficiente");
				AddItem(playerid, "Roupa", 1); 
				pInfo[playerid][pCoin] -=70;
				SendClientMessage(playerid, azul, "[INFO] Item adquirido, cheque seu inventario.");
			}
			if(listitem == 7)
			{
				if(pInfo[playerid][pCoin] < 350) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem dinheiro suficiente");
				AddItem(playerid, "Faca Ak-47", 1);
				pInfo[playerid][pCoin] -=350;
				SendClientMessage(playerid, azul, "[INFO] Item adquirido, cheque seu inventario.");
			}
			if(listitem == 8)
			{
				if(pInfo[playerid][pCoin] < 1300) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem dinheiro suficiente");
				AddItem(playerid, "MP5-K", 1);
				pInfo[playerid][pCoin] -=1300;
				SendClientMessage(playerid, azul, "[INFO] Item adquirido, cheque seu inventario.");
			}

		}
	}


	Item_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[0]);
	INV_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[0]);
	return 1;
}
public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(vehicleid == Carro){
	{
    DestroyVehicle(Carro);
    }
    return 1;
}
	SetVehicleParamsEx(vehicleid, 0, lights, alarm, 0, bonnet, boot, objective);
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
				if(vInfo[vehicleid][vTemMotor] == true && vInfo[vehicleid][vMotor] == false) SendClientMessage(playerid, COR_AMARELO,"[INFO]: Digite: '/engine' ou aperte 'CAPSLOCK' para ligar o motor.");
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
	foreach(new i : Player)
	{
		if(pInfo[i][pConectado] == true && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
			new vehicleid = GetPlayerVehicleID(i);
			if(GetPlayerState(i) == PLAYER_STATE_DRIVER && !IsABike(vehicleid))
			{
				if(vInfo[vehicleid][vCombustivel] > 0) vInfo[vehicleid][vCombustivel]--;
				if(vInfo[vehicleid][vCombustivel] == 0)
				{
					GameTextForPlayer(i, "~r~Sem Gasolina", 2000, 3);
					RemovePlayerFromVehicle(i);
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
	foreach(new i : Player)
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
	foreach(new i : Player)
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
public MsgBUG(playerid){
	GameTextForPlayer(playerid, "~r~Se abusar de bugs, sera banido!", 2400, 4);
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
	pInfo[playerid][pTemColete] = 0;
	pInfo[playerid][pTemCapacete] = 0;
	pInfo[playerid][pTemRADIO] = 0;
	pInfo[playerid][pTemGPS] = 1;
	

	AddItem(playerid, "Garrafa com agua", 1);
	AddItem(playerid, "Curativo", 1);
	if(pInfo[playerid][pVip] == 1)
	{
		AddItem(playerid, "Mochila normal", 1);
		AddItem(playerid, "Motoserra", 1);
		AddItem(playerid, "Galao vazio", 1);
		GivePlayerWeapon(playerid, 22, 15);
	}
	
	if(pInfo[playerid][pTemColete] == 1)
	{
	    RemovePlayerAttachedObject(playerid, 9);
	}
	if(pInfo[playerid][pTemCapacete] == 1)
	{
	    RemovePlayerAttachedObject(playerid, 8);
	}
	return 1;
}

stock IsPlayerInFrontVehicle(playerid,vehicleid,Float:radius,Float:vehiclelength)
{
  new Float:x,Float:y,Float:z,Float:a;
  GetVehiclePos(vehicleid, x, y, z);
  GetPlayerFacingAngle(vehicleid, a);
  x += (vehiclelength* floatsin(-a, degrees));
  y += (vehiclelength* floatcos(-a, degrees));
  return IsPlayerInRangeOfPoint(playerid,radius,x,y,z);
}

stock SetPlayerObject(playerid)
{
	// # Mochilas #
	switch(pInfo[playerid][pBackpack])
    {
        case 5: SetPlayerAttachedObject(playerid, 0, 363, 1, 0.097999, -0.151000, 0.000000, -1.800000, -93.100006, -5.599999, 1.000000, 1.000000, 1.000000);
        case 10: SetPlayerAttachedObject(playerid, 0, 3026, 1, 0.045999, -0.141000, -0.011000, 0.000000, 86.500007, 0.000000, 1.000000, 1.000000, 1.000000);
        case 16: SetPlayerAttachedObject(playerid, 0, 371, 1, 0.056999, -0.160999, 0.000000, 0.000000, 85.299964, 0.000000, 1.000000, 1.000000, 1.000000);
        case 24: SetPlayerAttachedObject(playerid, 0, 19559, 1, 0.005999, -0.158999, -0.006000, 0.000000, 86.299980, 0.000000, 1.000000, 1.000000, 1.000000);
        case 32: SetPlayerAttachedObject(playerid, 0, 1550, 1, 0.047000, -0.145999, 0.000000, 0.000000, 92.099998, 0.000000, 1.000000, 1.000000, 1.000000);
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
	SendClientMessage(playerid, -1, "{FFFF00}[>] {5BADFF}se quiser parar com a musica use /stop!");
    if(pInfo[playerid][pTemColete] == 1)
    {
        SetPlayerAttachedObject(playerid, 9, 19515, 1, 0.072999, 0.032000, 0.000000, 0.000000, 0.000000, 0.000000, 1.027999, 1.188000, 1.062999);
	}
	if(pInfo[playerid][pTemCapacete] == 1)
	{
	    SetPlayerAttachedObject(playerid, 8, 19200, 2, 0.119999, 0.014999, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
	}
	if(pInfo[playerid][pTemMask] == 1)
	{
		SetPlayerAttachedObject(playerid, 7, 19472, 2, 0.013000, 0.111999, 0.001000, 106.399971, 82.700004, -12.100005, 1.000000, 1.000000, 1.000000);
	}
	verificador[playerid] = SetTimerEx( "verificacao", 5000, true, "i", playerid);
	PreloadAnims(playerid);
}
                                                                   
stock PreloadAnims(playerid)
{
    PreloadAnimLib(playerid,"DANCING");
    PreloadAnimLib(playerid,"HEIST9");
    PreloadAnimLib(playerid,"BOMBER");
    PreloadAnimLib(playerid,"RAPPING");
    PreloadAnimLib(playerid,"SHOP");
    PreloadAnimLib(playerid,"BEACH");
    PreloadAnimLib(playerid,"SMOKING");
    PreloadAnimLib(playerid,"FOOD");
    PreloadAnimLib(playerid,"ON_LOOKERS");
    PreloadAnimLib(playerid,"DEALER");
    PreloadAnimLib(playerid,"CRACK");
    PreloadAnimLib(playerid,"CARRY");
    PreloadAnimLib(playerid,"COP_AMBIENT");
    PreloadAnimLib(playerid,"PARK");
    PreloadAnimLib(playerid,"INT_HOUSE");
    PreloadAnimLib(playerid,"FOOD" );
    PreloadAnimLib(playerid,"ped" );
    PreloadAnimLib(playerid,"MISC" );
    PreloadAnimLib(playerid,"POLICE" );
    PreloadAnimLib(playerid,"GRAVEYARD" );
    PreloadAnimLib(playerid,"WUZI" );
    PreloadAnimLib(playerid,"SUNBATHE" );
    PreloadAnimLib(playerid,"PLAYIDLES" );
    PreloadAnimLib(playerid,"CAMERA" );
    PreloadAnimLib(playerid,"RIOT" );
    PreloadAnimLib(playerid,"DAM_JUMP" );
    PreloadAnimLib(playerid,"JST_BUISNESS" );
    PreloadAnimLib(playerid,"KISSING" );
    PreloadAnimLib(playerid,"GANGS" );
    PreloadAnimLib(playerid,"GHANDS" );
    PreloadAnimLib(playerid,"BLOWJOBZ" );
    PreloadAnimLib(playerid,"SWEET" );
	PreloadAnimLib(playerid,"SWORD" );
}

stock PreloadAnimLib(playerid, animlib[]) {
ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0); }

forward verificacao(playerid);
public verificacao(playerid)
{
	//new Float:colete;
	new Float:vida;
    GetPlayerHealth(playerid, vida);
	if(vida <= 25.0 && caido[playerid] == false && morto[playerid] == false && pInfo[playerid][pConectado] == true)
	{
	    caido[playerid] = true;
		ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 1, 0, 0, 1, 0, 1);
		GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~r~~h~Voce Caiu....", 2000, 3);
		timercaido[playerid] = SetTimerEx( "caidonochao", 1000, true, "i", playerid);
		for(new i = 0; i < 1; i++) { PlayerTextDrawShow(playerid, Sangue1[playerid][i]); }
	}
	if(vida <= 30.0 && sanguenatela[playerid] == 0)
	{
		sanguenatela[playerid] = 1;
		for(new i = 0; i < 1; i++) { PlayerTextDrawShow(playerid, Sangue1[playerid][i]); }

	}
	if(vida >= 50 && sanguenatela[playerid] == 1)
	{
		sanguenatela[playerid] = 0;
		for(new i = 0; i < 1; i++) { PlayerTextDrawHide(playerid, Sangue1[playerid][i]); }	
	}
	if(temeperaturamundo <= 9)
	{
		if(avisadofrio[playerid] == 0)
		{
			if(!IsPlayerInRangeOfPoint(playerid, 3, fogueirapos[playerid][0], fogueirapos[playerid][1], fogueirapos[playerid][2]))
			{
				avisadofrio[playerid] = 1;
				SendClientMessage(playerid, -1, "{80FFFF}[!] Voce esta com frio, faca uma fogueira /crafts");
				SetTimerEx( "friolouco", 300000, true, "i", playerid);
			}
		}
	}
	if(GetPlayerWeapon(playerid) == 38)
	{
		SendClientMessage(playerid, COR_VERMELHO, "Kickado por suspeitas de Cheat!");
		SetTimerEx( "banindo", 500, false, "i", playerid);
	}
	if(GetPlayerWeapon(playerid) == 37)
	{
		SendClientMessage(playerid, COR_VERMELHO, "Kickado por suspeitas de Cheat!");
		SetTimerEx( "banindo", 500, false, "i", playerid);
	}
	if(GetPlayerWeapon(playerid) == 36)
	{
		SendClientMessage(playerid, COR_VERMELHO, "Kickado por suspeitas de Cheat!");
		SetTimerEx( "banindo", 500, false, "i", playerid);
	}
	if(GetPlayerWeapon(playerid) == 34)
	{
		SendClientMessage(playerid, COR_VERMELHO, "Kickado por suspeitas de Cheat!");
		SetTimerEx( "banindo", 500, false, "i", playerid);
	}
	if(GetPlayerSkin(playerid) == 0)
	{
		SendClientMessage(playerid, COR_VERMELHO, "[AntiCJ] Voce foi setado a skin ID 97 por esta de CJ");
		SetPlayerSkin(playerid, 97);
	}
	return 1;
}

forward friolouco(playerid);
public friolouco(playerid)
{
	if(!IsPlayerInRangeOfPoint(playerid, 3, fogueirapos[playerid][0], fogueirapos[playerid][1], fogueirapos[playerid][2]))
	{
		new Float:vida;
		GetPlayerHealth(playerid, vida);
		SetPlayerHealth(playerid, vida-10);
		SendClientMessage(playerid, COR_AMARELO, "[Frio] Voce esta morrendo de frio, LITERALMENTE!!");
		GameTextForPlayer(playerid, "~b~FRIO", 3000, 4);
	}
	else
	{
		KillTimer(timerfrio[playerid]);
		avisadofrio[playerid] = 0;
	}
}

forward caidonochao(playerid);
public caidonochao(playerid)
{
	new str[60];
	if(caidosegundos[playerid] == 30)
	{
	    KillTimer(timercaido[playerid]);
	    caidosegundos[playerid] = 0;
	    caido[playerid] = false;
		ClearAnimations(playerid, 1);
		SetPlayerHealth(playerid, 50);
		GameTextForPlayer(playerid, "~g~Levantou", 2000, 4);
	}
	else
	{
		caidosegundos[playerid]++;
		format(str, sizeof(str), "~n~~n~~n~~n~~n~~n~~n~~n~~r~~h~Levantando em: ~w~%d~r~/~w~30", caidosegundos[playerid]);
		GameTextForPlayer(playerid, str, 1000,  3);
	}
	return 1;
}
stock CarregarParede(id)
{
	new file[64];
	new str[60];
    format(file, 64, "Data/Paredes/%d.ini", id);
    if(DOF2_FileExists(file))
    {
    
		format(Parede[id][Dono], 28, DOF2_GetString(file, "Dono"));
		Parede[id][PosX] = DOF2_GetFloat(file, "PosX" );
		Parede[id][PosY] = DOF2_GetFloat(file, "PosY" );
		Parede[id][PosZ] = DOF2_GetFloat(file, "PosZ" );
		Parede[id][RX] = DOF2_GetFloat(file, "RX" );
		Parede[id][RY] = DOF2_GetFloat(file, "RY" );
		Parede[id][RZ] = DOF2_GetFloat(file, "RZ" );
		Parede[id][metallife] = DOF2_GetInt(file, "Metal" );
		Parede[id][upgrade] = DOF2_GetInt(file, "upgrade");
		Parede[id][ObjectJ] = CreateDynamicObject(19360, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], Parede[id][RX], Parede[id][RY], Parede[id][RZ]);
  		format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Parede[id][metallife]);
  		Parede[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 10.0, 0, 0);
		Parede[id][Existe] = 1;
	}
	return 1;
}

stock CarregarPorta(id)
{
	new file[64];
	new str[60];
    format(file, 64, "Data/Portas/%d.ini", id);
    if(DOF2_FileExists(file))
    {
    
		format(Porta[id][Dono], 28, DOF2_GetString(file, "Dono"));
		format(Porta[id][Dono], 28, DOF2_GetString(file, "Dono"));
		Porta[id][PosX] = DOF2_GetFloat(file, "PosX" );
		Porta[id][PosY] = DOF2_GetFloat(file, "PosY" );
		Porta[id][PosZ] = DOF2_GetFloat(file, "PosZ" );
		Porta[id][RX] = DOF2_GetFloat(file, "RX" );
		Porta[id][RY] = DOF2_GetFloat(file, "RY" );
		Porta[id][RZ] = DOF2_GetFloat(file, "RZ" );
		Porta[id][metallife] = DOF2_GetInt(file, "Metal" );
		format(Porta[id][Senha], 28, DOF2_GetString(file, "Senha"));
		Porta[id][upgrade] = DOF2_GetInt(file, "upgrade");
		Porta[id][ObjectP] = CreateDynamicObject(1497, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], Porta[id][RX], Porta[id][RY], Porta[id][RZ]);
  		format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Parede[id][metallife]);
  		Porta[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Porta[id][PosX], Porta[id][PosY], Porta[id][PosZ], 10.0, 0, 0);
		Porta[id][Existe] = 1;
	}
	return 1;
}

stock CarregarCraft(id)
{
	new file[64];
	new str[60];
    format(file, 64, "Data/Craft/%d.ini", id);
    if(DOF2_FileExists(file))
    {
    
		format(Craft[id][Dono], 28, DOF2_GetString(file, "Dono"));
		format(Craft[id][Dono], 28, DOF2_GetString(file, "Dono"));
		Craft[id][PosX] = DOF2_GetFloat(file, "PosX" );
		Craft[id][PosY] = DOF2_GetFloat(file, "PosY" );
		Craft[id][PosZ] = DOF2_GetFloat(file, "PosZ" );
		Craft[id][RX] = DOF2_GetFloat(file, "RX" );
		Craft[id][RY] = DOF2_GetFloat(file, "RY" );
		Craft[id][RZ] = DOF2_GetFloat(file, "RZ" );
		Craft[id][ObjectT] = CreateDynamicObject(936, Craft[id][PosX], Craft[id][PosY], Craft[id][PosZ]-0.5, Craft[id][RX], Craft[id][RY], Craft[id][RZ]+90);
  		format(str, 60, "ID:{0080C0} %d",id);
  		Craft[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Craft[id][PosX], Craft[id][PosY], Craft[id][PosZ], 10.0, 0, 0);
		Craft[id][Existe] = 1;
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
		Caixa[id][ObjectC] = CreateDynamicObject(1271, Caixa[id][PosX], Caixa[id][PosY], Caixa[id][PosZ]-0.6, Caixa[id][RX], Caixa[id][RY], Caixa[id][RZ]);
  		format(str, 60, "ID:{0080C0} %d",id);
  		Create3DTextLabel(str, 0xFFFF00FF, Caixa[id][PosX], Caixa[id][PosY], Caixa[id][PosZ], 10.0, 0, 0);
		Caixa[id][Existe] = 1;
	}
	return 1;
}


GetName(playerid)
{
    new
    gName[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, gName, sizeof(gName));
    return gName;
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

stock GetPlayerRangePorta(playerid)
{
	new id = -1, Float: distanciaA = 2.0, Float: distanciaB;
	for(new i; i < MAX_PORTA; i++)
	{
		if(!Porta[i][Existe]) continue;
	    distanciaB = GetPlayerDistanceFromPoint(playerid, Porta[i][PosX], Porta[i][PosY], Porta[i][PosZ]);

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

stock GetPlayerRangeCraft(playerid)
{
	new id = -1, Float: distanciaA = 2.0, Float: distanciaB;
	for(new i; i < MAX_CRAFT; i++)
	{
		if(!Craft[i][Existe]) continue;
	    distanciaB = GetPlayerDistanceFromPoint(playerid, Craft[i][PosX], Craft[i][PosY], Craft[i][PosZ]);

		if(distanciaB <= distanciaA)
		{
			distanciaA = distanciaB;
			id = i;
			break;
		}
	}
	return id;
}

stock GetDistanceBetweenPlayers(playerid,playerid2) //By Slick (Edited by Sacky)
{
new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
new Float:dis;
GetPlayerPos(playerid,x1,y1,z1);
GetPlayerPos(playerid2,x2,y2,z2);
dis = floatsqroot((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)+(z2-z1)*(z2-z1));
return floatround(dis);
}

SavePlayer(playerid)
{
	GetPlayerPos(playerid,pInfo[playerid][pPosX],pInfo[playerid][pPosY],pInfo[playerid][pPosZ]);
 	GetPlayerHealth(playerid, vida32[playerid]);
	GetPlayerArmour(playerid, colete32[playerid]);
    new query[3000], DBResult:Result;

    format(query, sizeof(query), "UPDATE `contas` SET `admin` = '%d',`level` = '%d',`coin` = '%d',`skin` = '%d',`matou` = '%d',`morreu` = '%d',`mochila` = '%d',`fome` = '%d',`sede` = '%d',`px` = '%f',`py` = '%f',`pz` = '%f',`vip` = '%d',`gps` = '%d',`temcolete` = '%d',`capacete` = '%d',`vida` = '%f',`colete` = '%f',`madeira` = '%d',`radio` = '%d',`mask` = '%d',`ferro` = '%d',`pedra` = '%d' WHERE `nome` = '%s'",
        pInfo[playerid][pAdmin],
		GetPlayerScore(playerid),
        pInfo[playerid][pCoin],
        GetPlayerSkin(playerid),
        PlayerKills[playerid],
        PlayerDeaths[playerid],
        pInfo[playerid][pBackpack],
        pInfo[playerid][pFome],
        pInfo[playerid][pSede],
        pInfo[playerid][pPosX],
        pInfo[playerid][pPosY],
        pInfo[playerid][pPosZ],
        pInfo[playerid][pVip],
        pInfo[playerid][pTemGPS],
        pInfo[playerid][pTemColete],
        pInfo[playerid][pTemCapacete],
        vida32[playerid],
        colete32[playerid],
        pInfo[playerid][pMadeira],
        pInfo[playerid][pTemRADIO],
        pInfo[playerid][pTemMask],
        pInfo[playerid][pFerro],
        pInfo[playerid][pPedra],

        DB_Escape(GetName(playerid)));
    Result = db_query(Connect, query);
    db_free_result(Result);
    print( "Conta salva");
    return 1;
}

CMD:stop(playerid)
{
	StopAudioStreamForPlayer(playerid);
	return 1;
}

CMD:agua(playerid)
{
	new str[128];
	if(!PlayerHasItem(playerid, "Garrafa vazia")) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO]  Voce nao possui uma garrafa vazia");
	if(IsPlayerInRangeOfPoint(playerid, 2,2178.9702,2798.1052,10.8203))
	{
		if(BebedorSize[0] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[0] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[0]);
		Update3DTextLabelText(bebedortext[0], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,1880.0948,2074.1824,11.0625))
	{
		if(BebedorSize[1] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[1] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[1]);
		Update3DTextLabelText(bebedortext[1], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,2462.9690,2031.8120,11.0625))
	{
		if(BebedorSize[2] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[2] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[2]);
		Update3DTextLabelText(bebedortext[2], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,1362.6451,239.2939,19.5669))
	{
		if(BebedorSize[3] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[3] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[3]);
		Update3DTextLabelText(bebedortext[3], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,685.1468,-473.8537,16.5363))
	{
		if(BebedorSize[4] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[4] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[4]);
		Update3DTextLabelText(bebedortext[4], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
 		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,1209.4060,-917.3860,43.0442))
	{
		if(BebedorSize[5] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[5] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[5]);
		Update3DTextLabelText(bebedortext[5], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
 		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,2104.7280,-1803.6128,13.5547))
	{
		if(BebedorSize[6] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[6] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[6]);
		Update3DTextLabelText(bebedortext[6], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
 		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,2420.2957,-1504.8816,24.0000))
	{
		if(BebedorSize[7] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[7] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[7]);
		Update3DTextLabelText(bebedortext[7], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
 		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,926.2271,-1356.6251,13.3794))
	{
		if(BebedorSize[8] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[8] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[8]);
		Update3DTextLabelText(bebedortext[8], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
 		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,812.9777,-1618.2938,13.5547))
	{
		if(BebedorSize[9] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[9] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[9]);
		Update3DTextLabelText(bebedortext[9], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
 		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,-2144.3264,-2457.7358,30.6250))
	{
		if(BebedorSize[10] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[10] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[10]);
		Update3DTextLabelText(bebedortext[10], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
 		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,-2328.0645,-164.4072,35.5547))
	{
		if(BebedorSize[11] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[11] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[11]);
		Update3DTextLabelText(bebedortext[11], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
 		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,-2678.1021,260.4480,4.6328))
	{
		if(BebedorSize[12] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[12] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[12]);
		Update3DTextLabelText(bebedortext[12], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
 		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,-2354.1089,999.3513,50.8984))
	{
		if(BebedorSize[13] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[13] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[13]);
		Update3DTextLabelText(bebedortext[13], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,209.8602,-202.7691,1.5703))
	{
		if(BebedorSize[14] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[14] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[14]);
		Update3DTextLabelText(bebedortext[14], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
 		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,-142.3332,1222.9147,19.8992))
	{
		if(BebedorSize[15] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[15] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[15]);
		Update3DTextLabelText(bebedortext[15], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,-1212.8503,1827.9877,41.7188))
	{
		if(BebedorSize[16] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[16] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[16]);
		Update3DTextLabelText(bebedortext[16], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
 		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,-1943.3630,2387.3462,49.6953))
	{
		if(BebedorSize[17] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Esse bebedor nao tem agua.");
		BebedorSize[17] -=2;
		format(str, sizeof(str), "{51A8FF}* Bebedor *\n{FFFFFF}Litros: %d/20", BebedorSize[17]);
		Update3DTextLabelText(bebedortext[17], -1, str);
		RemoveItem(playerid, "Garrafa vazia", 1);
		AddItem(playerid, "Garrafa com agua", 1);
		SendClientMessage(playerid,azul, "Enchendo a garrafa com agua potavel.");
 		SetTimerEx( "delaymsg", 10000, false, "i", playerid);
	}
	return 1;
}

CMD:enchergalao(playerid)
{
	new str[128];
	if(encheG[playerid] == true) return SendClientMessage(playerid, -1, "Aguarde 30 segundos para usar o reservatorio novamente.");
	if(!PlayerHasItem(playerid, "Galao vazio")) return SendClientMessage(playerid, COR_VERMELHO, "[ERRO] Voce nao tem um galao vazio.");
	if(IsPlayerInRangeOfPoint(playerid, 2,-1702.0271,409.0946,7.1797))
	{
		if(GalaoSize[0] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Reservatorio vazio.");
		GalaoSize[0] -=20;
		format(str, sizeof(str), "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: %d/200", GalaoSize[0]);
		Update3DTextLabelText(galaotext[0], -1, str);
		RemoveItem(playerid, "Galao vazio", 1);
		SetPlayerAttachedObject(playerid, 5, 1650, 6, 0.150000, 0.000000, 0.182000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
		GameTextForPlayer(playerid,"~w~Enchendo galao aguarde ~y~30 segundos", 5000, 4);
		SetTimerEx( "delaymsg", 30000, false, "i", playerid);
		ApplyAnimation(playerid,"SWORD","sword_block",4.1,0,1,1,1,1,1);
		SetTimerEx( "abastecendogalao", 30000, false, "i", playerid);
		encheG[playerid] = true;
		TogglePlayerControllable(playerid,0);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2,-81.9605,-1191.6680,1.7500))
	{
		if(GalaoSize[1] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Reservatorio vazio.");
		GalaoSize[1] -=20;
		format(str, sizeof(str), "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: %d/200", GalaoSize[1]);
		Update3DTextLabelText(galaotext[1], -1, str);
		RemoveItem(playerid, "Galao vazio", 1);
		SetPlayerAttachedObject(playerid, 5, 1650, 6, 0.150000, 0.000000, 0.182000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
		GameTextForPlayer(playerid,"~w~Enchendo galao aguarde ~y~30 segundos", 5000, 4);
 		SetTimerEx( "delaymsg", 30000, false, "i", playerid);
		ApplyAnimation(playerid,"SWORD","sword_block",4.1,0,1,1,1,1,1);
		SetTimerEx( "abastecendogalao", 30000, false, "i", playerid);
		encheG[playerid] = true;
		TogglePlayerControllable(playerid,0);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2, 1018.3885,-936.8539,42.1797))
	{
		if(GalaoSize[2] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Reservatorio vazio.");
		GalaoSize[2] -=20;
		format(str, sizeof(str), "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: %d/200", GalaoSize[2]);
		Update3DTextLabelText(galaotext[2], -1, str);
		RemoveItem(playerid, "Galao vazio", 1);
		SetPlayerAttachedObject(playerid, 5, 1650, 6, 0.150000, 0.000000, 0.182000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
		GameTextForPlayer(playerid,"~w~Enchendo galao aguarde ~y~30 segundos", 5000, 4);
 		SetTimerEx( "delaymsg", 30000, false, "i", playerid);
		ApplyAnimation(playerid,"SWORD","sword_block",4.1,0,1,1,1,1,1);
		SetTimerEx( "abastecendogalao", 30000, false, "i", playerid);
		encheG[playerid] = true;
		TogglePlayerControllable(playerid,0);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2, 1921.9299,-1791.6898,13.3828))
	{
		if(GalaoSize[3] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Reservatorio vazio.");
		GalaoSize[3] -=20;
		format(str, sizeof(str), "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: %d/200", GalaoSize[3]);
		Update3DTextLabelText(galaotext[3], -1, str);
		RemoveItem(playerid, "Galao vazio", 1);
		SetPlayerAttachedObject(playerid, 5, 1650, 6, 0.150000, 0.000000, 0.182000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
		GameTextForPlayer(playerid,"~w~Enchendo galao aguarde ~y~30 segundos", 5000, 4);
 		SetTimerEx( "delaymsg", 30000, false, "i", playerid);
		ApplyAnimation(playerid,"SWORD","sword_block",4.1,0,1,1,1,1,1);
		SetTimerEx( "abastecendogalao", 30000, false, "i", playerid);
		encheG[playerid] = true;
		TogglePlayerControllable(playerid,0);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2, 664.1801,-583.2779,16.3359))
	{
		if(GalaoSize[4] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Reservatorio vazio.");
		GalaoSize[4] -=20;
		format(str, sizeof(str), "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: %d/200", GalaoSize[4]);
		Update3DTextLabelText(galaotext[4], -1, str);
		RemoveItem(playerid, "Galao vazio", 1);
		SetPlayerAttachedObject(playerid, 5, 1650, 6, 0.150000, 0.000000, 0.182000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
		GameTextForPlayer(playerid,"~w~Enchendo galao aguarde ~y~30 segundos", 5000, 4);
 		SetTimerEx( "delaymsg", 30000, false, "i", playerid);
		ApplyAnimation(playerid,"SWORD","sword_block",4.1,0,1,1,1,1,1);
		SetTimerEx( "abastecendogalao", 30000, false, "i", playerid);
		encheG[playerid] = true;
		TogglePlayerControllable(playerid,0);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2, -2426.7146,953.6508,45.2969))
	{
		if(GalaoSize[5] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Reservatorio vazio.");
		GalaoSize[5] -=20;
		format(str, sizeof(str), "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: %d/200", GalaoSize[5]);
		Update3DTextLabelText(galaotext[5], -1, str);
		RemoveItem(playerid, "Galao vazio", 1);
		SetPlayerAttachedObject(playerid, 5, 1650, 6, 0.150000, 0.000000, 0.182000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
		GameTextForPlayer(playerid,"~w~Enchendo galao aguarde ~y~30 segundos", 5000, 4);
 		SetTimerEx( "delaymsg", 30000, false, "i", playerid);
		ApplyAnimation(playerid,"SWORD","sword_block",4.1,0,1,1,1,1,1);
		SetTimerEx( "abastecendogalao", 30000, false, "i", playerid);
		encheG[playerid] = true;
		TogglePlayerControllable(playerid,0);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2, -1310.0796,2704.3252,50.0625))
	{
		if(GalaoSize[6] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Reservatorio vazio.");
		GalaoSize[6] -=20;
		format(str, sizeof(str), "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: %d/200", GalaoSize[6]);
		Update3DTextLabelText(galaotext[6], -1, str);
		RemoveItem(playerid, "Galao vazio", 1);
		SetPlayerAttachedObject(playerid, 5, 1650, 6, 0.150000, 0.000000, 0.182000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
		GameTextForPlayer(playerid,"~w~Enchendo galao aguarde ~y~30 segundos", 5000, 4);
 		SetTimerEx( "delaymsg", 30000, false, "i", playerid);
		ApplyAnimation(playerid,"SWORD","sword_block",4.1,0,1,1,1,1,1);
		SetTimerEx( "abastecendogalao", 30000, false, "i", playerid);
		encheG[playerid] = true;
		TogglePlayerControllable(playerid,0);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2130.7759,2729.0083,10.8203))
	{
		if(GalaoSize[7] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Reservatorio vazio.");
		GalaoSize[7] -=20;
		format(str, sizeof(str), "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: %d/200", GalaoSize[7]);
		Update3DTextLabelText(galaotext[7], -1, str);
		RemoveItem(playerid, "Galao vazio", 1);
		SetPlayerAttachedObject(playerid, 5, 1650, 6, 0.150000, 0.000000, 0.182000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
		GameTextForPlayer(playerid,"~w~Enchendo galao aguarde ~y~30 segundos", 5000, 4);
 		SetTimerEx( "delaymsg", 30000, false, "i", playerid);
		ApplyAnimation(playerid,"SWORD","sword_block",4.1,0,1,1,1,1,1);
		SetTimerEx( "abastecendogalao", 30000, false, "i", playerid);
		encheG[playerid] = true;
		TogglePlayerControllable(playerid,0);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2181.8005,2487.9229,10.8203))
	{
		if(GalaoSize[8] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Reservatorio vazio.");
		GalaoSize[8] -=20;
		format(str, sizeof(str), "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: %d/200", GalaoSize[8]);
		Update3DTextLabelText(galaotext[8], -1, str);
		RemoveItem(playerid, "Galao vazio", 1);
		SetPlayerAttachedObject(playerid, 5, 1650, 6, 0.150000, 0.000000, 0.182000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
		GameTextForPlayer(playerid,"~w~Enchendo galao aguarde ~y~30 segundos", 5000, 4);
 		SetTimerEx( "delaymsg", 30000, false, "i", playerid);
		ApplyAnimation(playerid,"SWORD","sword_block",4.1,0,1,1,1,1,1);
		SetTimerEx( "abastecendogalao", 30000, false, "i", playerid);
		encheG[playerid] = true;
		TogglePlayerControllable(playerid,0);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2646.2976,1086.3092,10.8203))
	{
		if(GalaoSize[9] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Reservatorio vazio.");
		GalaoSize[9] -=20;
		format(str, sizeof(str), "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: %d/200", GalaoSize[9]);
		Update3DTextLabelText(galaotext[9], -1, str);
		RemoveItem(playerid, "Galao vazio", 1);
		SetPlayerAttachedObject(playerid, 5, 1650, 6, 0.150000, 0.000000, 0.182000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
		GameTextForPlayer(playerid,"~w~Enchendo galao aguarde ~y~30 segundos", 5000, 4);
 		SetTimerEx( "delaymsg", 30000, false, "i", playerid);
		ApplyAnimation(playerid,"SWORD","sword_block",4.1,0,1,1,1,1,1);
		SetTimerEx( "abastecendogalao", 30000, false, "i", playerid);
		encheG[playerid] = true;
		TogglePlayerControllable(playerid,0);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2, 2105.9255,940.4212,10.8203))
	{
		if(GalaoSize[10] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Reservatorio vazio.");
		GalaoSize[10] -=20;
		format(str, sizeof(str), "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: %d/200", GalaoSize[10]);
		Update3DTextLabelText(galaotext[10], -1, str);
		RemoveItem(playerid, "Galao vazio", 1);
		SetPlayerAttachedObject(playerid, 5, 1650, 6, 0.150000, 0.000000, 0.182000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
		GameTextForPlayer(playerid,"~w~Enchendo galao aguarde ~y~30 segundos", 5000, 4);
 		SetTimerEx( "delaymsg", 30000, false, "i", playerid);
		ApplyAnimation(playerid,"SWORD","sword_block",4.1,0,1,1,1,1,1);
		SetTimerEx( "abastecendogalao", 30000, false, "i", playerid);
		encheG[playerid] = true;
		TogglePlayerControllable(playerid,0);
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2, -2236.8618,-2570.4922,31.9219))
	{
		if(GalaoSize[11] == 0) return SendClientMessage(playerid, COR_VERMELHO, "Reservatorio vazio.");
		GalaoSize[11] -=20;
		format(str, sizeof(str), "{51A8FF}* Reservatorio de combustivel *\n{FFFFFF}Litros: %d/200", GalaoSize[11]);
		Update3DTextLabelText(galaotext[11], -1, str);
		RemoveItem(playerid, "Galao vazio", 1);
		SetPlayerAttachedObject(playerid, 5, 1650, 6, 0.150000, 0.000000, 0.182000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
		GameTextForPlayer(playerid,"~w~Enchendo galao aguarde ~y~30 segundos", 5000, 4);
 		SetTimerEx( "delaymsg", 30000, false, "i", playerid);
		ApplyAnimation(playerid,"SWORD","sword_block",4.1,0,1,1,1,1,1);
		SetTimerEx( "abastecendogalao", 30000, false, "i", playerid);
		encheG[playerid] = true;
		TogglePlayerControllable(playerid,0);
	}
	return 1;
}

forward abastecendogalao(playerid);
public abastecendogalao(playerid)
{
	ClearAnimations(playerid, 1);                              
	AddItem(playerid, "Galao de combustivel", 1);
	RemovePlayerAttachedObject(playerid, 5);
	encheG[playerid] = false;
	GameTextForPlayer(playerid, "~g~Galao Cheio", 1000, 4);
    TogglePlayerControllable(playerid,1);
	return 1;
}
/*CMD:fornalha(playerid)
{
    new id = GetPlayerRangeParede(playerid);
    if(id == -1) return SendClientMessage(playerid, -1, "Voce esta perto de sua Forno!");
    if(strcmp(Parede[id][Dono], pName(playerid))) return SendClientMessage(playerid, -1, "Esta Forno n�o � sua!");
    ShowPlayerDialog(playerid, 55, DIALOG_STYLE_LIST, "Fornalha", "Cozinhar Peru\nCozinhar seupai\nLalal\npoximos itens", "Selecionar", "Cancelar");
    return 1;
}*/


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
	DOF2_SetInt(file, "upgrade", Parede[id][upgrade]);
	DOF2_SaveFile();
	return 1;
}

stock SalvarPorta(id)
{
	new file[64];
  	format(file, sizeof(file), "Data/Portas/%d.ini", id);

	DOF2_CreateFile(file);
	DOF2_SetString(file,"Dono",Porta[id][Dono]);

	DOF2_SetFloat(file, "PosX", Porta[id][PosX]);
	DOF2_SetFloat(file, "PosY", Porta[id][PosY]);
	DOF2_SetFloat(file, "PosZ", Porta[id][PosZ]);
	DOF2_SetFloat(file, "RX", Porta[id][RX]);
	DOF2_SetFloat(file, "RY", Porta[id][RY]);
	DOF2_SetFloat(file, "RZ", Porta[id][RZ]);
	DOF2_SetInt(file, "Metal", Porta[id][metallife]);
	DOF2_SetString(file, "Senha", Porta[id][Senha]);
	DOF2_SetInt(file, "upgrade", Porta[id][upgrade]);
	DOF2_SaveFile();	
}

stock SalvarCraft(id)
{
	new file[64];
  	format(file, sizeof(file), "Data/Craft/%d.ini", id);

	DOF2_CreateFile(file);
	DOF2_SetString(file,"Dono",Craft[id][Dono]);

	DOF2_SetFloat(file, "PosX", Craft[id][PosX]);
	DOF2_SetFloat(file, "PosY", Craft[id][PosY]);
	DOF2_SetFloat(file, "PosZ", Craft[id][PosZ]);
	DOF2_SetFloat(file, "RX", Craft[id][RX]);
	DOF2_SetFloat(file, "RY", Craft[id][RY]);
	DOF2_SetFloat(file, "RZ", Craft[id][RZ]);
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
	SendClientMessage(playerid, azul, "{FFFF00}[>] {0080FF}Voce coletou {FFFF00}5 {0080FF}madeiras.");
	ClearAnimations(playerid, 1);
	RemovePlayerAttachedObject(playerid, 5);
	natora[playerid] = false;
	pInfo[playerid][pMadeira] +=5;
	return 1;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	/*if(clickedid == PublicTD6[6])
	{
    	new query[61], DBResult:Result;
		new Dialog[240];
    	format(query, sizeof(query), "SELECT * FROM `contas` WHERE `nome`='%s'", DB_Escape(GetName(playerid)));
    	Result = db_query(Connect, query);

    	if(db_num_rows(Result) == 0)
    	{
        	//N�o tem uma conta..
        	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_PASSWORD, "Registrando a sua conta", "Digite uma senha para criar uma conta ( UTILIZE APENAS NUMEROS )", "Registrar", "sair");
		}
    	else
    	{
        	//Tem uma conta..
         ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "Voce ja possui uma conta", "Voce ja possui uma conta, digite sua para poder logar", "Logar", "sair");
    	}
    	db_free_result(Result);
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
	if(clickedid == PublicTD40[1])
	{
		new id = ideditorp[playerid];
		new str[60];
		DestroyObject(Parede[id][ObjectJ]);
		Parede[id][PosY] = Parede[id][PosY]-0.3;
		Parede[id][ObjectJ] = CreateObject(19360, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ]+0.5, Parede[id][RX], Parede[id][RY], Parede[id][RZ]+90);	
		Delete3DTextLabel(Parede[id][Text3Dp]);
		format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Parede[id][metallife]);
		Parede[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 10, 0, 0);
	}
	if(clickedid == PublicTD40[2])
	{
		new id = ideditorp[playerid];
		new str[60];
		DestroyObject(Parede[id][ObjectJ]);
		Parede[id][PosX] = Parede[id][PosX]-0.3;
		Parede[id][ObjectJ] = CreateObject(19360, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ]+0.5, Parede[id][RX], Parede[id][RY], Parede[id][RZ]+90);	
		Delete3DTextLabel(Parede[id][Text3Dp]);
		format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Parede[id][metallife]);
		Parede[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 10, 0, 0);		
	}
	if(clickedid == PublicTD40[3])
	{
		new id = ideditorp[playerid];
		new str[60];
		DestroyObject(Parede[id][ObjectJ]);
		Parede[id][PosY] = Parede[id][PosY]+0.3;
		Parede[id][ObjectJ] = CreateObject(19360, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ]+0.5, Parede[id][RX], Parede[id][RY], Parede[id][RZ]+90);	
		Delete3DTextLabel(Parede[id][Text3Dp]);
		format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Parede[id][metallife]);
		Parede[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 10, 0, 0);	
	}	
	if(clickedid == PublicTD40[4])
	{
		new id = ideditorp[playerid];
		new str[60];
		DestroyObject(Parede[id][ObjectJ]);
		Parede[id][PosX] = Parede[id][PosX]+0.3;
		Parede[id][ObjectJ] = CreateObject(19360, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ]+0.5, Parede[id][RX], Parede[id][RY], Parede[id][RZ]+90);	
		Delete3DTextLabel(Parede[id][Text3Dp]);
		format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Parede[id][metallife]);
		Parede[id][Text3Dp] = Create3DTextLabel(str, 0xFFFF00FF, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 10, 0, 0);	
	}*/
	return 1;
}

forward delyanaimacao(playerid);
public delyanaimacao(playerid)
{
	ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.1, 0, 0, 0, 1, 0, 1);
	ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.1, 0, 0, 0, 1, 0, 1);
	ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.1, 0, 0, 0, 1, 0, 1);
    ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.1, 0, 0, 0, 1, 0, 1);
	ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.1, 0, 0, 0, 1, 0, 1);
    return 1;
}

forward rilandoamigo(playerid);
public rilandoamigo(playerid)
{
	new str[60];
	if(rilandosegundos[playerid] == 10)
	{
	    KillTimer(timerrilando[playerid]);
	    ClearAnimations(playerid, 1);
	    GameTextForPlayer(iddorilado,"~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~Reanimado!",1000,3);
	    rilandosegundos[playerid] = 0;
	    jarilando[playerid] = 0;
        ClearAnimations(iddorilado, 1);
        SetPlayerHealth(iddorilado, 50);
        caido[iddorilado] = false;
		KillTimer(timercaido[iddorilado]);
		caidosegundos[iddorilado] = 0;
		iddorilado = 0;
	}
	else
	{
        rilandosegundos[playerid]++;
		format(str, sizeof(str), "~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~Reanimando: ~w~%d~r~/~w~10", rilandosegundos[playerid]);
		GameTextForPlayer(playerid, str, 1000,  3);
	}
	return 1;
}
forward Curandocura(playerid);
public Curandocura(playerid)
{
	new str[60];
	if(curandosegundos[playerid] == 10)
	{
	    KillTimer(timerdacura[playerid]);
		ClearAnimations(playerid, 1);
		SetPlayerHealth(playerid, 100);
		GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~Curado",1000,3);
		curandosegundos[playerid] = 0;
		return 0;
	}
	else
	{
		curandosegundos[playerid]++;
		format(str, sizeof(str), "~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~Curando: ~w~%d~r~/~w~10", curandosegundos[playerid]);
		GameTextForPlayer(playerid, str, 1000,  3);
	}
	return 1;
}

forward Curandocura2(playerid);
public Curandocura2(playerid)
{
	new str[60];
	if(curandosegundos[playerid] == 10)
	{
	    KillTimer(timerdacura[playerid]);
		ClearAnimations(playerid, 1);
		GetPlayerHealth(playerid, vida32[playerid]);
		SetPlayerHealth(playerid, vida32[playerid]+20);
		GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~Curado",1000,3);
		return 0;
	}
	else
	{
		curandosegundos[playerid]++;
		format(str, sizeof(str), "~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~Curando: ~w~%d~r~/~w~10", curandosegundos[playerid]);
		GameTextForPlayer(playerid, str, 1000,  3);
	}
	return 1;
}

forward Platandobomba(playerid);
public Platandobomba(playerid)
{
	new id = idparedebomb[playerid];
	ClearAnimations(playerid, 1);
	TogglePlayerControllable(playerid, 1);
	GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~n~~r~~h~Saia de perto!",1000,3);
	objetoc4[playerid] = CreateDynamicObject(1252, Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 0, 0, 0);
	SetTimerEx( "Explodindobomba", 5000, false, "i", playerid);
	return 1;
}

forward Explodindobomba(playerid);
public Explodindobomba(playerid)
{
	new id = idparedebomb[playerid];
	new str[60];
    CreateExplosion(Parede[id][PosX], Parede[id][PosY], Parede[id][PosZ], 6, 5);
    if(Parede[id][metallife] == 1)
    {
    	DestroyDynamicObject(Parede[id][ObjectJ]);
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
		Parede[id][metallife] -=2;
		DestroyObject(objetoc4[playerid]);
		format(str, 60, "ID:{0080C0} %d\n{FFFF00}Protecao:{0080C0} %d",id, Parede[id][metallife]);
		Update3DTextLabelText(Parede[id][Text3Dp], 0xFFFF00FF, str);
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
    foreach(new i : Player)
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

DB_Escape(text[])
{
        new
        ret[80 * 2],
        ch,
        i,
        j;
        while ((ch = text[i++]) && j < sizeof (ret))
        {

                if (ch == '\'')
                {

                        if (j < sizeof (ret) - 2)
                        {

                                ret[j++] = '\'';
                                ret[j++] = '\'';
                        }
                }
                else if (j < sizeof (ret))
                {

                        ret[j++] = ch;
                }
                else
                {

                        j++;
                }
        }
        ret[sizeof (ret) - 1] = '\0';
        return ret;
        // '''
}

stock InRangeOfAnyVehicle(playerid)
{
    new Float:X, Float:Y, Float:Z, id = -1;
    for(new I = 0; I < MAX_VEHICLES; I++)
    {
        GetVehiclePos(I, X, Y, Z);
        if(IsPlayerInRangeOfPoint(playerid, 5.0, X, Y, Z))
        {
            id = I;
            break;
        }
    }
    return id;
}

forward ciclo();
public ciclo()
{
	new str[60];
	if(tempoatual == 1)
	{
		new rand = minrand(25,33);
		SetWorldTime(12);
		tempoatual = 2;
		format(str, sizeof(str), "[Clima] o Mundo se aproxima de 12:00 | Temperatura: %dC", rand);
		SendClientMessageToAll(COR_AMARELO, str);
		temeperaturamundo = rand;
	}
	else if(tempoatual == 2)
	{
		new rand = minrand(20,25);
		SetWorldTime(20);
		tempoatual = 3;
		format(str, sizeof(str), "[Clima] o Mundo se aproxima de 17:30 | Temperatura: %dC", rand);
		SendClientMessageToAll(COR_AMARELO, str);
		temeperaturamundo = rand;
	}
	else if(tempoatual == 3)
	{
		new rand = minrand(10,17);
		SetWorldTime(0);
		tempoatual = 4;
		format(str, sizeof(str), "[Clima] o Mundo se aproxima de 21:00 | Temperatura: %dC", rand);
		SendClientMessageToAll(COR_AMARELO, str);
		temeperaturamundo = rand;	
	}
	else if(tempoatual == 4)
	{
		new rand = minrand(3,7);
		SetWorldTime(3);
		tempoatual = 5;
		format(str, sizeof(str), "[Clima] o Mundo se aproxima de 03:00 | Temperatura: %dC", rand);
		SendClientMessageToAll(COR_AMARELO, str);
		temeperaturamundo = rand;				
	}
	else if(tempoatual == 5)
	{
		new rand = minrand(12,17);
		SetWorldTime(6);
		tempoatual = 1;
		format(str, sizeof(str), "[Clima] o Mundo se aproxima de 06:00 | Temperatura: %dC", rand);
		SendClientMessageToAll(COR_AMARELO, str);
		temeperaturamundo = rand;				
	}	
}

forward reloot();
public reloot()
{
	foreach(new i : Player)
	{
		if(pInfo[i][pConectado] == true && IsPlayerConnected(i))
		{
			SavePlayer(i);
			SaveWeaponsToFile(i);
			SaveInventory(i);
		}
	}
	SendClientMessageToAll(-1, "{FFFF00}[!] {62B0FF}Servidor Reiniciando em {FFFFFF} 3 minutos {62B0FF}!");
	SetTimer( "reiniciando1", 180000, false);
	return 1;
}

forward reiniciando1();
public reiniciando1()
{
	foreach(new i : Player)
	{
		if(pInfo[i][pConectado] == true && IsPlayerConnected(i))
		{
			SavePlayer(i);
			SaveWeaponsToFile(i);
			SaveInventory(i);
			TogglePlayerControllable(i, 0);
		}
	}
	SendClientMessageToAll(-1, "{FFFF00}[!] {62B0FF}Servidor reiniciando em instantes {62B0FF}!");
	SetTimer("Reiniciando2", 6000, false);
	return 1;
}

forward Reiniciando2();
public Reiniciando2()
{
	SendRconCommand("gmx");
}

stock MensageAdmin(cor, string[])
{
	for(new d; d < GetMaxPlayers(); ++d)
	{
		if(IsPlayerConnected(d) && pInfo[d][pAdmin] >= 1)
		{
			SendClientMessage(d, cor, string);
		}
	}
}

forward loadingspec(playerid);
public loadingspec(playerid)
{
	pInfo[playerid][pRespawn] = 2;
	return 1;
}

forward parededelaY();
public parededelaY()
{
	permitidoparede = true;
	return 1;
}

forward caixadelay();
public caixadelay()
{
	permitidocaixa = true;
	return 1;
}

forward ProxDetectorEx(Float:radi, playerid, string[], col1);
public ProxDetectorEx(Float:radi, playerid, string[], col1)
{
	if(IsPlayerConnected(playerid) && GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
        new VW = GetPlayerVirtualWorld(playerid);

		//radi = 2.0; //Trigger Radius
		foreach(new i: Player)
		{
			if(!BigEar[i])
			{
                if(GetPlayerVirtualWorld(i) != VW)
                    continue;

				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);
				if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
				{
					SendClientMessage(i, col1, string);
				}
			}
			else
			{
				SendClientMessage(i, col1, string);
			}
		}
	}
	return true;
}

public manu(playerid){
	return Kick(playerid);
}

