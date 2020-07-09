//::///////////////////////////////////////////////
//:: dla_mel_inc
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Include file of DLA Melee Fight mini-game.
*/
//:://////////////////////////////////////////////
//:: Create By: Gale
//:: Created On: Jan 11, 2006
//:://////////////////////////////////////////////

/*
     modified by : gaoneng erick
     modified on : may 7, 2006
                   fix various odd bugs and issues causing tournament
                   to not end properly at times
                   fix henchmen not getting healed/resurrected after combat
     modified on : may 12, 2006
                   fix henchmen stacking up on same space in the end
*/

#include "nw_i0_generic"
#include "x0_i0_position"

const string nMeleePKills = "nMeleePKills"; //name of the local var that stores individual kills
const string nMeleeTKills = "nMeleeTKills"; //name of the local var that stores team kills
const string WPStartFight = "WP_dla_me_start"; //tag of the waypoint to move to when starting the fight
const string WPEndFight = "WP_dla_me_end"; //tag of the waypoint to move to when ending the fight
const string nTeamMembers = "nTeamMembers"; //name of the local var that stores the number of party members the PC had when entered the fight
const string nLastManStand = "nLastManStand"; //name of local int.

//Max PC Party size to enter the fight
const int DLA_MEL_MAX_PC_PARTY_SIZE = 3;
//Max number of times per day that a player can play the Melee Fight minigame
const int DLA_MAX_FIGHTS_PER_DAY    = 2;
//Max number of enemies during one Melee Fight.
//This will be decreased by one for each additional party member on PC's team
const int DLA_MEL_MAX_NUM_ENEMIES   = 15;

const string nMeleeOutcome = "nMeleeOutcome"; //name of the local var that stores if the player won or lose last fight
// 0 means have not fight yet
// 1 means lose
// 2 means won

const string nMeleeJustFinish = "nMeleeJustFinish";
// 0 means did not just finished a fight
// 1 means did just finish a fight

//Gale Jan 11, 2006:
//Move the whole party which oPartyMember is a member to lDestination
void DLA_MovePartyToLocation(object oPartyMember, location lDestination);

//Gale Jan 11, 2006:
//Returns the number of members on oCreature team.
//* Returns 1 if oCreature is not a player object, or invalid.
int DLA_GetNumMembersOnTeam(object oCreature);

//Gale Jan 11, 2006:
//Stores the number of party members on oPC party
void DLA_StoreNumPartyMembers(object oPC);

//Gale Jan 11, 2006:
//Returns the number of party members on oPC party stored using
//DLA_StoreNumPartyMembers function
int DLA_GetNumPartyMembers(object oPC);

//Gale Jan 11, 2006:
//Return the current in game Date (combination of Day, Month and Year)
//on the pattern: yyyy-mm-dd
string DLA_Retrieve_Current_Game_Date();

//Gale Jan 11, 2006:
//Increments the number of times entered on Melee Fight mini-game today
void DLA_CountFightsToday(object oPC);

//Gale Jan 11, 2006:
//-iPosition: The number of the enemy. Ranges from 1 to
//Creates one enemy used during Melee Fight mini-game.
object DLA_CreateEnemy(int iPosition);

//Gale Jan 11, 2006:
//Returns the creature object correspondent to iPositionSpawned that was
//spawned during Melee Fight mini-game using function DLA_CreateEnemy
object DLA_GetEnemy(int iPositionSpawned);

//Gale Jan 11, 2006:
void DLA_SpawnOpponents(object oPC, int iAmount = DLA_MEL_MAX_NUM_ENEMIES);

///////////////////////////////////////////
//////////////Functions////////////////////
///////////////////////////////////////////

void DLA_MovePartyToLocation(object oPartyMember, location lDestination)
{
   oPartyMember = GetFirstFactionMember(oPartyMember, FALSE);
   do
   {
       //gaoneng erick may 7, 2006: Added call to ClearAllActions
       AssignCommand(oPartyMember, ClearAllActions(TRUE));
       AssignCommand(oPartyMember, JumpToLocation(lDestination));
   }
   while (GetIsObjectValid(oPartyMember = GetNextFactionMember(oPartyMember, FALSE)));
}

int DLA_GetNumMembersOnTeam(object oPC)
{
  if (!GetIsPC(oPC)) return 1;

  int i;
  object oCreature = GetFirstFactionMember(oPC, FALSE);
  do
       i++;
  while (GetIsObjectValid(oCreature = GetNextFactionMember(oPC, FALSE)));

  return i;
}

//gaoneng erick may 7, 2006:
//Stores party members of oCreature to be returned after the end of the minigame
void DLA_StorePartyMembers(object oCreature)
{
    if (!GetIsPC(oCreature)) return;
    int i = 0;
//    object oModule = GetModule();
    object oMember = GetFirstFactionMember(oCreature, FALSE);
    while (GetIsObjectValid(oMember))
    {
        i++;
        SetLocalObject(oCreature, "GN_SIDEKICK" + IntToString(i), oMember);
        oMember = GetNextFactionMember(oCreature, FALSE);
    }
}

void DLA_StoreNumPartyMembers(object oPC)
{
  SetLocalInt(oPC, nTeamMembers, DLA_GetNumMembersOnTeam(oPC));
}

//Current number of party members may change if the npc summons a creature, or if
//any of his summons is unsummoned. This will return the number stored when the fight started.
int DLA_GetNumPartyMembers(object oPC)
{
  return GetLocalInt(oPC, nTeamMembers);
}

string DLA_Retrieve_Current_Game_Date()
{
  string CurrTS = IntToString(GetCalendarYear()) + "-"
                + IntToString(GetCalendarMonth()) + "-"
                + IntToString(GetCalendarDay());
  return CurrTS;
}

void DLA_CountFightsToday(object oPC)
{
   SetLocalString(oPC,"DLA_mel_lastday", DLA_Retrieve_Current_Game_Date());
   SetLocalInt(oPC, "DLA_mel_timesday",  GetLocalInt(oPC, "DLA_mel_timesday")+1);
}

object DLA_CreateEnemy(int iPosition)
{
  return  CreateObject(OBJECT_TYPE_CREATURE,
                 "dla_mel_crea"+IntToString(iPosition),
                 GetLocation(GetObjectByTag("wp_mel_"+IntToString(iPosition))),
                 FALSE,
                 "dla_mel_c"+IntToString(iPosition));

}

object DLA_GetEnemy(int iPositionSpawned)
{
   return GetObjectByTag("dla_mel_c"+IntToString(iPositionSpawned));

}

void DLA_SpawnOpponents(object oPC, int iAmount = DLA_MEL_MAX_NUM_ENEMIES)
{
   int i, j;
   object oEnemy;
   for (i = DLA_GetNumMembersOnTeam(oPC); i<=iAmount; i++)
   {
       object oEnemy = DLA_CreateEnemy(i);
       AssignCommand(oEnemy, SetIsDestroyable(FALSE, FALSE, FALSE));
       AssignCommand(oEnemy, DetermineCombatRound());
   }

}

int DLA_GetNumIndividualKills(object oCreature)
{
    return GetLocalInt(oCreature, nMeleePKills);
}

int DLA_GetNumTeamKills(object oCreature)
{
   if (!GetIsObjectValid(GetMaster(oCreature)))
      return GetLocalInt(oCreature, nMeleeTKills);
   return DLA_GetNumTeamKills(GetMaster(oCreature));
}

void DLA_AddTeamKill(object oCreature)
{
   if (!GetIsObjectValid(GetMaster(oCreature)))
       SetLocalInt(oCreature, nMeleeTKills, DLA_GetNumTeamKills(oCreature)+1);
   else
       DLA_AddTeamKill(GetMaster(oCreature));
}

void DLA_AddKill(object oCreature)
{
   SetLocalInt(oCreature, nMeleePKills, DLA_GetNumIndividualKills(oCreature)+1);
   DLA_AddTeamKill(oCreature);
}

void DLA_ClearMeleeVars(object oCreature)
{
   DeleteLocalInt(oCreature, nTeamMembers);
   DeleteLocalInt(oCreature, nMeleeTKills);
   DeleteLocalInt(oCreature, nMeleePKills);
   DeleteLocalInt(oCreature, nLastManStand);
}

void DLA_CleanInventory(object oCreature)
{
   object oItem = GetFirstItemInInventory(oCreature);
   do
   {
      SetPlotFlag(oItem,FALSE);
      DestroyObject(oItem);
   }
   while (GetIsObjectValid(oItem = GetNextItemInInventory(oCreature)));
   TakeGoldFromCreature(GetGold(oCreature), oCreature , TRUE);
}

void DLA_CleanMeleeArena(object oPC, int nEnemy = DLA_MEL_MAX_NUM_ENEMIES)
{
    object oNPC; int i = DLA_GetNumPartyMembers(oPC);
    while (i <= nEnemy)
    {
        oNPC = DLA_GetEnemy(i);
        i++;
        DLA_CleanInventory(oNPC);
        AssignCommand(oNPC, SetIsDestroyable(TRUE, FALSE, FALSE));
        DestroyObject(oNPC);
    }
}

void DLA_StartMeleeFight(object oPC, int nEnemy = DLA_MEL_MAX_NUM_ENEMIES)
{
   DLA_ClearMeleeVars(oPC);
   BlackScreen(oPC);
   DLA_CleanMeleeArena(oPC, nEnemy); //just in case
   DLA_CountFightsToday(oPC);
   DLA_StorePartyMembers(oPC);
   DLA_StoreNumPartyMembers(oPC);
   DLA_MovePartyToLocation(oPC, GetLocation(GetWaypointByTag(WPStartFight)));
   DLA_SpawnOpponents(oPC, nEnemy);
   FadeFromBlack(oPC);
}

int DLA_CheckIfPCIsLastMan(object oPC, int nEnemy = DLA_MEL_MAX_NUM_ENEMIES)
{
    object oNPC; int i = DLA_GetNumPartyMembers(oPC);
    while (i <= nEnemy)
        if (GetIsObjectValid(oNPC = DLA_GetEnemy(++i)) && GetCurrentHitPoints(oNPC) >= 0)
            return FALSE;
    SetLocalInt(oPC, nLastManStand, 1);
    return TRUE;
}

//equal to Bio's raise, but can be included on other files
void DLA_Raise(object oPlayer)
{
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);
    effect eBad = GetFirstEffect(oPlayer);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPlayer);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer);

    //Search for negative effects
    int nType;
    while(GetIsEffectValid(eBad))
    {
        //gaoneng erick may 7, 2006:
        //Added variable to avoid calling GetEffectType multiple times
        nType = GetEffectType(eBad);
        if (nType == EFFECT_TYPE_ABILITY_DECREASE ||
            nType == EFFECT_TYPE_AC_DECREASE ||
            nType == EFFECT_TYPE_ATTACK_DECREASE ||
            nType == EFFECT_TYPE_DAMAGE_DECREASE ||
            nType == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            nType == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            nType == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            nType == EFFECT_TYPE_SKILL_DECREASE ||
            nType == EFFECT_TYPE_BLINDNESS ||
            nType == EFFECT_TYPE_DEAF ||
            nType == EFFECT_TYPE_PARALYZE ||
            nType == EFFECT_TYPE_NEGATIVELEVEL)
        {
            //Remove effect if it is negative.
            RemoveEffect(oPlayer, eBad);
        }
        eBad = GetNextEffect(oPlayer);
    }
        //Fire restoration VFX for the specified target
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPlayer);
}

void DLA_RaisePCTeam(object oPC)
{
    object oMember;
    string sVarName;
    int i;
//    object oModule = GetModule();
    int nPartyMembers = DLA_GetNumPartyMembers(oPC);
    for (i = 1; i <= nPartyMembers; i++)
    {
       //gaoneng erick may 7, 2006:
       // now retrieves members from local variables instead of looping through faction
        sVarName = "GN_SIDEKICK" + IntToString(i);
        oMember = GetLocalObject(oPC, sVarName);
        DLA_Raise(oMember);
        DeleteLocalObject(oPC, sVarName);
    }
}

void DLA_DistributeRemainingKills(object oPC, int nEnemy = DLA_MEL_MAX_NUM_ENEMIES)
{
   object oNPC, oFirstAlive;
   int nNPCAlive;
   int i = DLA_GetNumPartyMembers(oPC);
   while (i < nEnemy)
        if (GetIsObjectValid(oNPC = DLA_GetEnemy(++i)) && GetCurrentHitPoints(oNPC) >= 0)
           if (++nNPCAlive == 1)
               oFirstAlive = oNPC;
   i=0;
   while (++i < nNPCAlive)
       DLA_AddKill(oFirstAlive);
}

// added by : gaoneng erick
// added on : may 7, 2006
// compiled from DLA_MovePartyToLocation and DLA_RaisePCTeam
void DLA_RaiseAndJumpFaction(object oPC, object oWaypoint)
{
    object oMember;
    string sVarName;
    int i;
    int nPartyMembers = DLA_GetNumPartyMembers(oPC);
//    object oModule = GetModule();

    for (i = 1; i <= nPartyMembers; i++)
    {
        sVarName = "GN_SIDEKICK" + IntToString(i);
        oMember = GetLocalObject(oPC, sVarName);
        DLA_Raise(oMember);
        AssignCommand(oMember, ClearAllActions(TRUE));
        AssignCommand(oMember, DelayCommand(IntToFloat(i)*0.6, JumpToObject(oWaypoint, 0)));
        DeleteLocalObject(oPC, sVarName);
    }
}

// added by : gaoneng erick
// added on : may 7, 2006
// compiled from DLA_EndMeleeFightLose and Win, since both do exactly the same thing
// other than 1 SetLocalInt and 1 animation.
// record outcome, raise and heal party, jump to end waypoint and talk to melee master
void DLA_EndSequence(object pc, int outcome, int enemy)
{
    SetLocalInt(pc, nMeleeOutcome, outcome);
    SetLocalInt(pc, nMeleeJustFinish, 1);
    SetCutsceneMode(pc);

    AssignCommand(pc, SetCameraFacing(GetOppositeDirection(GetFacing(pc)), 10.0, -1.0 , CAMERA_TRANSITION_TYPE_SNAP));
    AssignCommand(pc, SetCameraFacing(GetOppositeDirection(GetFacing(pc)), 20.0, -1.0 , CAMERA_TRANSITION_TYPE_MEDIUM));

    string text = "You lose!";
    if (outcome == 2)
    {
        AssignCommand(pc, DelayCommand(0.5, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1)));
        text = "You won!";
    }
    DelayCommand(0.5, FloatingTextStringOnCreature(text, pc));
    DelayCommand(3.5, BlackScreen(pc));
    DelayCommand(3.7, DLA_CleanMeleeArena(pc, enemy));
    DelayCommand(3.8, DLA_RaiseAndJumpFaction(pc, GetWaypointByTag(WPEndFight)));

    DelayCommand(4.0, FadeFromBlack(pc));
    DelayCommand(4.1, SetCutsceneMode(pc, FALSE));
    DelayCommand(4.2, AssignCommand(pc, ActionStartConversation(GetObjectByTag("dla_mel_master"))));
}

// modified by : gaoneng erick
// modified on : may 7, 2006
void DLA_EndMeleeFightLose(object oPC, int nEnemy = DLA_MEL_MAX_NUM_ENEMIES)
{
    DLA_EndSequence(oPC, 1, nEnemy);

//   SetLocalInt(oPC, nMeleeOutcome, 1 );
//   SetLocalInt(oPC, nMeleeJustFinish, 1 );
//   SetCutsceneMode(oPC);
//   AssignCommand(oPC, SetCameraFacing(GetOppositeDirection(GetFacing(oPC)), 10.0, -1.0 , CAMERA_TRANSITION_TYPE_SNAP));
//   AssignCommand(oPC, SetCameraFacing(GetOppositeDirection(GetFacing(oPC)), 20.0, -1.0 , CAMERA_TRANSITION_TYPE_MEDIUM));
//   DelayCommand(0.5, FloatingTextStringOnCreature("You lose!", oPC));
//   DelayCommand(3.5, BlackScreen(oPC));
//   DelayCommand(3.7, DLA_CleanMeleeArena(oPC, nEnemy));

//   DelayCommand(3.8, gn_RaiseAndJumpFaction(oPC, GetWaypointByTag(WPEndFight)));
//   DelayCommand(3.8, DLA_RaisePCTeam(oPC));
//   DelayCommand(3.9, DLA_MovePartyToLocation(oPC, GetLocation(GetWaypointByTag(WPEndFight))));

//   DelayCommand(4.0, FadeFromBlack(oPC));
//   DelayCommand(4.0, SetCutsceneMode(oPC, FALSE));
//   DelayCommand(4.1, AssignCommand(oPC, ActionStartConversation(GetObjectByTag("dla_mel_master"))));
}


// modified by : gaoneng erick
// modified on : may 7, 2006
void DLA_EndMeleeFightWon(object oPC, int nEnemy = DLA_MEL_MAX_NUM_ENEMIES)
{
    DLA_EndSequence(oPC, 2, nEnemy);

//   SetLocalInt(oPC, nMeleeOutcome, 2 );
//   SetLocalInt(oPC, nMeleeJustFinish, 1 );
//   SetCutsceneMode(oPC);
//   AssignCommand(oPC, SetCameraFacing(GetOppositeDirection(GetFacing(oPC)), 10.0, -1.0 , CAMERA_TRANSITION_TYPE_SNAP));
//   AssignCommand(oPC, SetCameraFacing(GetOppositeDirection(GetFacing(oPC)), 20.0, -1.0 , CAMERA_TRANSITION_TYPE_MEDIUM));
//   DelayCommand(0.5, AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1)));
//   DelayCommand(0.5, FloatingTextStringOnCreature("You won!", oPC));
//   DelayCommand(3.5, BlackScreen(oPC));

//   DelayCommand(3.7, DLA_CleanMeleeArena(oPC, nEnemy));
//   DelayCommand(3.8, gn_RaiseAndJumpFaction(oPC, GetWaypointByTag(WPEndFight)));
//   DelayCommand(3.9, DLA_MovePartyToLocation(oPC, GetLocation(GetWaypointByTag(WPEndFight))));

//   DelayCommand(4.1, FadeFromBlack(oPC));
//   DelayCommand(4.2, SetCutsceneMode(oPC, FALSE));

//   DelayCommand(4.2, DLA_CleanMeleeArena(oPC, nEnemy));
//   DelayCommand(4.2, DLA_RaisePCTeam(oPC));

//   DelayCommand(4.2, AssignCommand(oPC, ActionStartConversation(GetObjectByTag("dla_mel_master"))));
}

object DLA_GetMeleeWinner(object oPC, int nEnemy = DLA_MEL_MAX_NUM_ENEMIES)
{

   int iMax, iKills;
   int i = DLA_GetNumPartyMembers(oPC);
   object oNPC, oWinner;

   while (i <= nEnemy)
   {
     if (iKills = DLA_GetNumTeamKills(oNPC = DLA_GetEnemy(++i)) > iMax)
     {
         oWinner = oNPC;
         iMax = iKills;
     }
   }

   if (DLA_GetNumTeamKills(oPC) > iMax)
       return oPC;
   else
       return oWinner;
}

void DLA_EndFight(object oPC, int nEnemy=15)
{
   DLA_DistributeRemainingKills(oPC, nEnemy);
   object oWinner = DLA_GetMeleeWinner(oPC, nEnemy);

   SetLocalString(oPC, "dla_mel_winname", GetName(oWinner));
   SetLocalInt(oPC, "dla_mel_winikill", DLA_GetNumIndividualKills(oWinner));
   SetLocalInt(oPC, "dla_mel_wintkill", DLA_GetNumTeamKills(oWinner));

   if (GetIsPC(oWinner))
       AssignCommand(GetArea(oPC), DLA_EndSequence(oPC, 2, nEnemy));
//gaoneng erick may 7, 2006: Changed to use new function DLA_EndSequence
//        DLA_EndMeleeFightWon(oPC, nEnemy);
   else
       AssignCommand(GetArea(oPC), DLA_EndSequence(oPC, 1, nEnemy));
//gaoneng erick may 7, 2006: Changed to use new function DLA_EndSequence
//        DLA_EndMeleeFightLose(oPC, nEnemy);
}

string DLA_GetLastFightWinnerName(object oPC)
{
  return GetLocalString(oPC, "dla_mel_winname");
}

int DLA_GetLastFightWinnerIKills(object oPC)
{
  return GetLocalInt(oPC, "dla_mel_winikill");
}

int DLA_GetLastFightWinnerTKills(object oPC)
{
  return GetLocalInt(oPC, "dla_mel_wintkill");
}

int DLA_GetWasLastManStanding(object oCreature)
{
   return GetLocalInt(oCreature, nLastManStand);
}
