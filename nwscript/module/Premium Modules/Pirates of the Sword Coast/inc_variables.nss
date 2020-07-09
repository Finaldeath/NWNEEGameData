//::///////////////////////////////////////////////
//:: Variable constants
//:: inc_variables.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Variable constants used by scripts in IoP.

    Instead of typing out strings for local variable
    names, which is prone to typos and whatnot,
    store the names in constants here.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: April 21, 2004
//:://////////////////////////////////////////////

// USER-DEFINED EVENTS
// example:
//const int UD_EVENT_REDTIP_CS_CHEERING_START = 101;


// PLOT VARIABLE CONSTANTS
/*
  Format:
    %1_%2[v]_(NAME)
      %1: g or l
          g - Global variable. Use SetGlobal* and GetGlobal*.
          l - Local variable. Use SetLocal* and GetLocal*.
      %2: Type of variable (n=int, s=string, f=float, etc)
       v: Denotes that this constant represents a variable value
          instead of a name.
      (NAME): The name of the constant.
*/
// Example plot variable constants:
/*
const string g_n_BOAT_ROUTE_INFO = "nBoatRouteInfo";
const string g_n_BOAT_INFO_THRU_HASTON = "nBoatInfoThruHaston";

const string g_n_SHIP = "nPlayersShip";
const int g_nv_SHIP_NONE = 0;
const int g_nv_SHIP_WIDOWS_PROMISE = 1;
const int g_nv_SHIP_CRIMSON_DAWN = 2;
const int g_nv_SHIP_TYMORAS_SMILE = 3;

Usage:
  SetGlobalInt(g_n_SHIP, g_nv_SHIP_NONE);
  if(GetGlobalInt(g_n_SHIP)==g_nv_SHIP_WIDOWS_PROMISE) ...
*/

// Constants for generic conversation scripts
const string l_n_GENERIC_CONV_1 = "nGenericConv1";
const string l_n_GENERIC_CONV_2 = "nGenericConv2";
const string l_n_GENERIC_CONV_3 = "nGenericConv3";
const string l_n_GENERIC_CONV_4 = "nGenericConv4";
const string l_n_GENERIC_CONV_5 = "nGenericConv5";
const string l_n_GENERIC_CONV_6 = "nGenericConv6";
const string l_n_GENERIC_CONV_7 = "nGenericConv7";
const string l_n_GENERIC_CONV_8 = "nGenericConv8";
const string l_n_GENERIC_CONV_9 = "nGenericConv9";
const string l_n_GENERIC_CONV_10 = "nGenericConv10";
const string l_n_GENERIC_CONV_11 = "nGenericConv11";
const string l_n_GENERIC_CONV_12 = "nGenericConv12";
const string l_n_GENERIC_CONV_13 = "nGenericConv13";
const string l_n_GENERIC_CONV_14 = "nGenericConv14";
const string l_n_GENERIC_CONV_15 = "nGenericConv15";
const string l_n_GENERIC_CONV_16 = "nGenericConv16";
const string l_n_GENERIC_CONV_17 = "nGenericConv17";
const string l_n_GENERIC_CONV_18 = "nGenericConv18";
const string l_n_GENERIC_CONV_19 = "nGenericConv19";
const string l_n_GENERIC_CONV_20 = "nGenericConv20";

// Redtip (warehouse)
const string l_n_REDTIP_CUTSCENE_STARTED = "nRedtipCutsceneStarted";
const string l_n_REDTIP_CUTSCENE_DONE = "nRedtipCutsceneDone";
const string l_n_REDTIP_BRAWL_ON = "nRedtipBrawlOn";
const string l_n_REDTIP_BRAWL_OUTCOME = "nRedtipBrawlOutcome";
const int l_nv_REDTIP_BRAWL_OUTCOME_NONE = 0;
const int l_nv_REDTIP_BRAWL_OUTCOME_FLED = 1;
const int l_nv_REDTIP_BRAWL_OUTCOME_WON = 2;
const int l_nv_REDTIP_BRAWL_OUTCOME_LOST = 3;
const int l_nv_REDTIP_BRAWL_OUTCOME_CHEATED = 4;
const int l_nv_REDTIP_BRAWL_OUTCOME_RESET = 5;
const string l_n_REDTIP_LEAVING_WAREHOUSE = "nRedtipLeavingWarehouse";
const string l_n_REDTIP_FIGHTER_POPUP = "nRedtipFighterPopup";
const string l_n_REDTIP_FIGHTER_LEAVE = "nRedtipFighterLeave";
//const string l_n_REDTIP_RANDOM_CONV_VAR = "nRedtipRandomConvVar";
//const string l_n_REDTIP_CS_CHEERING = "nRedtipCSCheering";
const string l_o_REDTIP_BRAWL_PLAYER_OBJECT = "oRedtipBrawlPlayerObject";
const string l_o_REDTIP_BRAWL_HENCH1 = "oRedtipBrawlHench1";
const string l_o_REDTIP_BRAWL_HENCH2 = "oRedtipBrawlHench2";

const string l_o_FIGHTCLUB_FIGHTER1 = "oFightClubFighter1";
const string l_o_FIGHTCLUB_FIGHTER2 = "oFightClubFighter2";
const string l_l_FIGHTCLUB_ORIG_POS_FIGHTER1 = "lFightClubOrigPosFighter1";
const string l_l_FIGHTCLUB_ORIG_POS_FIGHTER2 = "lFightClubOrigPosFighter2";
const string l_n_FIGHTCLUB_CUTSCENE_NUMBER = "nFightClubCutsceneNumber";
const string l_o_FIGHTCLUB_BETTING_PLAYER = "oFightClubBettingPlayer";
const string l_n_FIGHTCLUB_FIGHTACTIVE = "nFightClubFightActive";
const string l_n_FIGHTCLUB_PARTICIPANT = "nFightClubParticipant";
const int l_nv_FIGHTCLUB_PARTICIPANT_NOT = 0;
const int l_nv_FIGHTCLUB_PARTICIPANT_WINNER = 1;
const int l_nv_FIGHTCLUB_PARTICIPANT_LOSER = 2;
const string l_n_FIGHTCLUB_PLAYER_WON_BET = "nFightClubPlayerWonBet";
const string l_n_FIGHTCLUB_REDTIP_SAY_1LINER = "nFightClubRedtipSay1Liner";

// xpm stuff
const string l_n_XPM_START_CS_ON_AEN = "nXPMStartCSOnAEN";

// beneath temple in spindrift
const string l_n_A2_TEMPLE_PORTAL_OUT_ACTIVE = "nA2TemplePortalOutActive";
const string l_oa_A2_TEMPLE_PRIESTESS_ARRAY = "oaA2TemplePriestessArray";
const string l_oa_A2_TEMPLE_SAHCLERIC_ARRAY = "oaA2TempleSahClericArray";
const string l_oa_A2_TEMPLE_SAHGUARD_ARRAY = "oaA2TempleSahGuardArray";
const string l_oa_A2_TEMPLE_ALL_ARRAY = "oaA2TempleAllArray";
const string l_n_A2_TEMPLE_PRIESTESS_COUNT = "nA2TemplePriestessCount";
const string l_n_A2_TEMPLE_SAHCLERIC_COUNT = "nA2TempleSahClericCount";
const string l_n_A2_TEMPLE_SAHGUARD_COUNT = "nA2TempleSahGuardCount";
const string l_n_A2_TEMPLE_ALL_COUNT = "nA2TempleAllCount";
const string l_n_A2_TEMPLE_STAYING_TO_FIGHT = "nStayToFight";

// Willigan
const string l_n_A2_WILLIGAN_SUCCESS_CS_START = "nA2WilliganSuccessCSStart";
const string l_n_A2_WILLIGAN_PC_KICKED_OUT = "nA2WilliganPCKickedOut";
// this is for a dialogue conditional on Willigan
const string l_n_A2_WILLIGAN_PC_FAILED = "nA2WilliganPCFailed";
const string l_n_A2_WILLIGAN_FANNY_STATE = "nA2WilliganFannyState";
const int l_nv_A2_WILLIGAN_FANNY_STATE_WALKING = 0;
const int l_nv_A2_WILLIGAN_FANNY_STATE_INVESTIGATING = 1;
const int l_nv_A2_WILLIGAN_FANNY_STATE_CHASING = 2;
const int l_nv_A2_WILLIGAN_FANNY_STATE_CUTSCENE = 3;
const string l_l_A2_WILLIGAN_FANNY_PERCEIVE_LOC = "lA2WilliganFannyPerceiveLoc";
const string l_n_A2_WILLIGAN_FANNY_CALLS = "nA2WilliganFannyCalls";
const string g_oa_A2_WILLIGAN_CHESTS = "oaA2WilliganChests";
const string g_n_A2_WILLIGAN_CHESTS_NUM = "nA2WilliganChestsNum";
const string g_oa_A2_WILLIGAN_HENCH = "oaA2WilliganHench";

