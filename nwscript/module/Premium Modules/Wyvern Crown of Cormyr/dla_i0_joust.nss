////////////////////////////////////////////////////////////////////////////////
// dla_i0_joust.nss
//
// DLA Wyvern Crown of Cormyr
////////////////////////////////////////////////////////////////////////////////
/*
   Include file of DLA Joust Minigame
*/
////////////////////////////////////////////////////////////////////////////////
// Created By: Takamura
// Created On: 11/10/2005
////////////////////////////////////////////////////////////////////////////////
/*
 Change History
 Date
 Year/mm/dd  Who     : Change
 -----------|-------------------------------------------------------------------
 2005/12/26  Gale    : Added phenotype change function.
 2006/01/16  Gale    : Added associates follow function.
 2006/01/17  Gale    : Added functions to equip the player for the joust.
                       Added joust outcome functions.
                       Added functions to set/get opponent data.
                       Added joust cutscene animation function.
                       Added function to spawn the opponent.
 2006/01/18  Gale    : Added score keeping functions.
 2006/01/20  Syrsnein: Added additional functions to equip the player.
 2006/02/02  Syrsnein: Added stun condition functions.
                       Added aim and defense strategy functions.
 2006/02/03  Gale    : Added training mode functions.
 2006/02/04  Gale    : Added functions to adjust the players infamy.
 2006/02/09  Syrsnein: Added debug functionality.
 2006/02/23  Syrsnein: Added get/set functions for tournament data.
 2006/02/25  Syrsnein: Added get/set functions for tilt round data.
 2006/02/28  Syrsnein: Added additional functions to set/get opponent data.
                       Rewrote DLA_SetOpponentNumber()
 2006/03/01  Syrsnein: Added Joust cutscene function DLA_JoustMatchEnd().
 2006/03/02  Syrsnein: Added Jonas creation (black knight).
 2006/03/06  Syrsnein: Added another set/get function for opponent data.
 2006/03/08  Syrsnein: Added get/set functions for match data.
 2006/03/09  Syrsnein: Added joust cutscene functions and lance selection cutscene
                         functions.
 2006/03/27  Syrsnein: Added lance selection routines.
                       Added functions to determine eligibility to joust.
                       Added functions to determine player status in the joust.
 2006/03/28  Syrsnein: Added generic bit-state functions.
 2006/04/15  Syrsnein: Added joust horse color selection functions.
 2006/06/13  Syrsnein: Cleaned up script.
                       Added change history from notes within the script.
                       Added prototyping for functions that were missing it.
 2006/06/25  Syrsnein: Added function to change a riders horse tail to one of
                         the joust colors tails.
 2006/06/30  Deva W. : Added DLA_ForceEquip function to insure equipping of
                         an item is completed.  Also added DLA_ForceUnequip2
                         which is the opposite.  Neither function uses
                         clearallactions.  They operate until complete or until
                         the item no longer exists or is in target creatures
                         possession. DLA_DestroyObject was also added to address
                         issues where items were not destroyed as they should be.
 2006/07/07  Syrsnein: Copied DLA_DestroyObject from dla_i1_battle to this script
                         and added Deva's delayed call at the end.
 2006/07/10  Syrsnein: Moved pheno change from mounted to joust to the start of
                         movement from the lance rack to the trumpet trigger.
 2006/07/12  Syrsnein: Moved lance rack functions into seperate scripts.
 2006/08/05  Syrsnein: Removed removal of helmet on head hits due to appearance
                         refresh issues with the game engine.
 2006/08/11  Deva W. : Modified DLA_GetFirstShieldAvailable as it was not letting a
                       person joust a second time with their own armor due to
                       shield being equipped.  Function was not checking shield
                       slot.  Was only checking unequipped inventory.
 Not added - 2006/08/14  BGPHughes : Added a poison variable if the PC is poisoned
 2006/08/14  Deva W. : Modified DLA_JoustMatchEnd and added set to 4 matches when
                       lost in tourney 2 occurs.  Trying to immediately force end
                       poison occurrence.
2006/08/15  B G P Hughes: Removed above workaround - found source and fixed in dialogue (dla_atjoustsefet)
 */

// Wyvern Crown Constants File
#include "dla_i0_const"
// Joust opponent constants and functions
#include "dla_i0_opponents"
// Wyvern Crown miscellaneous functions
#include "cu_functions"

//Prints a debug message if DLA_JOUST_DEBUG is TRUE
const int DLA_JOUST_DEBUG = TRUE;
void DLA_JoustDebug(string sMessage, int bForce=FALSE)
{
     if (!DLA_JOUST_DEBUG && !bForce) return;
     DLA_Debug("[DLA JOUST DEBUG] " + sMessage);
}

// Returns the first shield found on oPC inventory
// NOTE: Don't check for equiped items, as shields can't be used while mounted
object DLA_GetFirstShieldAvailable(object oPC);

// Returns the first armor that has total AC > 5 or OBJECT_INVALID
//  if nothing was found.
// Check Equiped items first, then items on oPC inventory
object DLA_GetFirstArmorAvailable(object oPC);

// Returns the first helmet equiped by or on oPC inventory;
object DLA_GetFirstHelmetAvailable(object oPC);

// Sets the infamy score of oCreature to nValue.
void DLA_SetInfamy(object oCreature, int nValue);

// Gets the infamy score of oCreature.
int DLA_GetInfamy(object oCreature);

// Adjust the infamy score of oCreature by nValue.
void DLA_AdjustInfamy(object oCreature, int nValue);

// Return a DLA_JOUST_CONDITION_* constant to represent oCreature's Stun Condition
// * Return value if oCreature is not a valid creature: DLA_JOUST_CONDITION_NORMAL
int DLA_GetStunCondition(object oCreature);

// Set a DLA_JOUST_CONDITION_* if the oCreature fails a check.
// If bForce is TRUE, force the condition to be set/incremented
void DLA_SetStunCondition(object oCreature, int bForce = FALSE);

// Remove any stun condition set on oCreature.
void DLA_RemoveStunCondition(object oCreature);

// -nAimPos: DLA_JOUST_ATK_*
// -nDefPos: DLA_JOUST_DEF_*
// -nStunCondition: DLA_JOUST_CONDITION_*
// Returns TRUE if the combination of nAimPos and nDefPos is valid, taking
//  in account nStunCondition and the restrictions to Defensive Position
//  applied by taking nAimPos as Aim Position
int DLA_GetIsDefPosValid(int nAimPos, int nDefPos, int nStunCondition);

// -nAimPos: DLA_JOUST_ATK_*
// Sets the Aim Position to be used for oCreature during the next jousting
// round
void DLA_SetAimPos(object oCreature, int nAimPos);

// Return a DLA_JOUST_ATK_* constant to represent oCreature's Aim Position
// choosen to next jousting round
// * Return value if oCreature is not a valid creature: DLA_JOUST_ATK_INVALID
int DLA_GetAimPos(object oCreature);

// Resets the Aim Position of oCreature to DLA_JOUST_ATK_INVALID
void DLA_DeleteAimPos(object oCreature);

// -nDefPos: DLA_JOUST_DEF_*
// Sets the Defensive Position to be used for oCreature during the next jousting round
void DLA_SetDefPos(object oCreature, int nDefPos);

// Return an DLA_JOUST_DEF_* constant to represent oCreature's Defensive Position
// choosen to next jousting round
// * Return value if oCreature is not a valid creature: DLA_JOUST_DEF_INVALID
int DLA_GetDefPos(object oCreature);

// Resets the Defensive Position of oCreature to DLA_JOUST_DEF_INVALID
void DLA_DeleteDefPos(object oCreature);

// -nOutCome: DLA_OUTCOME_*
// Set if the outcome nOutCome happenend on this jousting round
// Bitwise SET operation, to avoid using many local ints to store booleans
// Possible to use | (bitwise "or") on nOutCome parameter to set more than one bit at same time
void DLA_SetOutcome(object oCreature, int nOutCome, int bValue = TRUE);

// -nOutCome: DLA_OUTCOME_*
// Return if the outcome nOutCome happenend on this jousting round
// Bitwise GET operation function, to avoid using many local ints to store booleans
int DLA_GetOutcome(object oCreature, int nOutCome);

// Reequips the items owned by oPC that had been removed during joust mini-game
void DLA_ReequipOwnItems(object oPC);

// -nJoustTail: The joust horse tail to use for oPC
// Sets a local int on oPC to tell us what joust colors they are currently using.
void DLA_JoustSetColors(object oPC, int nJoustTail);

// Returns the joust colors that oPC is currently using.
int DLA_JoustGetColors(object oPC);

// -nLance: The lance index number being used in relation to the lance rack.
// Sets a local in on oPC to tell us what lance they are using for the joust.
void DLA_JoustSetLanceColor(object oPC, int nLance);

// Gets the current lance index that oPC is using for the joust.
int DLA_JoustGetLanceColor(object oPC);

// Removes the lance from oPC
void DLA_JoustRemoveLance(object oPC);

// Check PC for the needed items for a joust round.
// If PC don't have the item, create it and equip.
// Borrowed items will be destroyed when round is finished
void DLA_EquipJoustingItems(object oPC, int nEquip = DLA_EQUIP_ALL);

// Returns the string containing the name of PC's current opponent on jousting
//  as defined on dla_joust_opp script
string DLA_GetOpponentName(object oPC);

// Ranges from 1 to X, where X is the first empty name string constant on dla_joust_opp
// Returns 1 on error
int DLA_GetOpponentNumber(object oPC);

// Returns the string containing the resref of PC's current opponent on jousting
//  as defined on dla_joust_opp script
string DLA_GetOpponentResref(object oPC);

// -nIndex: The opponent index to be set locally on oPC
void DLA_SetOpponentNumber(object oPC, int nIndex);

// -sName: The opponent name to be set locally on oPC
void DLA_SetOpponentName(object oPC, string sName);

// -sResref: The opponent resref string to be set locally on oPC
void DLA_SetOpponentResref(object oPC, string sResref);

// -nOppNumber: The opponent number to check against
// Return TRUE if the currently assigned opponent number
//  for oPC is the same as nOppNumber
int DLA_GetIsOpponentNumber(object oPC, int nOppNumber);

// -nIndex: The opponent number to be referenced
// -bTraining: Indicates if oPC is in training mode.
// Copy all opponent data to local variables on oPC
void DLA_SetJoustOpponent(object oPC, int nIndex, int bTraining=FALSE);

// - bTraining: Indicates if oPC is in training mode.
// Advances the number representing the next opponent of oPC by one.
void DLA_SetNextOpponent(object oPC, int nTraining=FALSE);

// -nTourney: The tournament the PC is participating in.
// Return true if the tourney instance == nTourney
int DLA_GetIsTourney(object oPC, int nTourney);

// Jousting matrix function calls, for this function just choose an aim point
//  for the opponent. returns an aim number. Pick integers 0-100 for percent Pick
//  1-8 for aim*/
int DLA_AimChance(int iAim, int iPercent);

// Jousting matrix function calls, for this function just choose a seat point
//  for the opponent. returns a seat number Pick integers 0-100 for percent do
//  not pick seats that are not available for certain aims.
int DLA_SeatChance(int iAim, int iSeat, int iPercent, int nStunCondition);

// Basic function to change to jousting pheno.
// Creature should be already on one mounted pheno.
// This is needed to give access to jousting animations.
// Defaults to JOUSTING_NORMAL pheno
void DLA_ChangeToJoustingPheno(object oCreature);

// Change to mounted pheno
// Assumes oCreature is currently in a jousting pheno.
// Defaults to MOUNTED_NORMAL pheno
void DLA_ChangeToMountedPheno(object oCreature);

// Calculates and play the outcome animation based on oPC seat option, and oOP aim option
// It should be called again, inverting parameters to play the animation also for oOP
void DLA_DoOutcome(object oPC, object oOP);

// This plays the outcome previously calculated using the DLA_DoOutcome function
// Showed be called one time for each participant of the joust
void DLA_PlayOutcomeAnimation(object oTarget);

// Spawns the next opponent of oPC, using the function DLA_GetOpponentResref
// Sets the tag as the same as the creature resref
object DLA_SpawnOpponent(object oPC);

// Returns how many points the opponent of oCreature should earned
// this jousting round.
int DLA_GetScoreOnRound(object oCreature);

// if bOpponent is set to TRUE, then return the score of the opponent of oPC on
// last jousting round. Otherwise, return the score of oPC itself.
int DLA_GetScoreOnMatch(object oPC, int bOpponent=FALSE);

// if bOpponent is set to TRUE, then set the score of the opponent of oPC on
// last jousting round. Otherwise, set the score of oPC itself.
void DLA_SetScoreOnMatch(object oPC, int bOpponent=FALSE, int nScore = 0);

// Calculate and store the jousting score of both oPC and oOpponent.
// Should be called after each round. (Wraps the real calculation / storage)
void DLA_ScoreKeep(object oPC, object oOpponent);

// Returns TRUE if the PC is meets the requirements to
//  set up a joust match
int DLA_JoustGetCanJoust(object oPC);

// Get the number of rounds tilted in the current match
int DLA_GetTiltRounds(object oPC);

// -nRounds: The number of tilt rounds oPC has completed
// Set the number of rounds tilted in the current match.
void DLA_SetTiltRounds(object oPC, int nRounds);

// Get the number of matches that oPC has done on nDay
//  of the Joust Tourney
int DLA_GetTourneyMatches(object oPC);

// -nMatches: The number of matches that oPC has completed.
// Set the number of matches that oPC has done
//  in the Joust Tourney
void DLA_SetTourneyMatches(object oPC, int nMatches);

// Get the number of matches that oPC has won on.
//  nDay of the Joust Tourney
int DLA_GetTourneyWins(object oPC);

// -nWins: The number of matches that oPC has won.
// Set the number of matches that oPC has won
void DLA_SetTourneyWins(object oPC, int nWins);

// Return TRUE if the PC has a match set up but hasn't
//  completed it.
int DLA_GetHasJoustMatch(object oPC);

// -bMatch: Boolean value to be set.
// Set a variable to tell us that oPC has a joust match
void DLA_SetHasJoustMatch(object oPC, int bMatch=TRUE);

// Delete the JoustMatch boolean
void DLA_RemoveHasJoustMatch(object oPC);

// Returns if oPC is on a training match
int DLA_GetIsOnTraining(object oPC);

// TO DO Comment
void DLA_SetIsOnTraining(object oPC, int bOnTraining = TRUE);

// Returns TRUE if oPC is currently jousting a tournament
int DLA_GetIsEnteredInLists(object oPC);

// -nTournament: The tournament we want to check against.
// Returns TRUE if oPC won nTournament
int DLA_GetIsJoustChampion(object oPC, int nTournament);

// -nTournament: The tournament we want to set oPC as having won.
// Set oPC as the champion of nTournament
void DLA_SetIsJoustChampion(object oPC, int nTournament);

// Determine winner of the match, set conversation tokens
//  increment local variables and then cleanup.
void DLA_JoustMatchEnd(object oPC);

// Jonas Stuff
// Create the Jonas NPC and his horse, for jousting.
object DLA_JoustCreateJonas(object oPC);

// -nCheck: The state to compare against nMaster.
// Return TRUE if nCheck is set in nMaster
int DLA_GetStateIsSet(int nMaster, int nCheck);

// -nState: The state to set.
// Set a state in oPC's Joust State
void DLA_SetJoustState(object oPC, int nState);

// Get the current Joust State for oPC
int DLA_GetJoustState(object oPC);

// -nState: The state to remove.
// Remove a state from oPCs Joust State
void DLA_RemoveJoustState(object oPC, int nState);

// Get the base armor value of oObject
int DLA_GetBaseArmorValue(object oObject);

// Get the Outcome varaible on oCreature
int DLA_GetOutcomeVar(object oCreature);

// -nLance: The lance index to check against
// Return TRUE if oLanceRack still has nLance
int DLA_GetRackHasLance(object oLanceRack, int nLance);

// -nTourney: The tournament to check against.
// Return TRUE if oPC is the champion of nTourney
int DLA_GetTourneyChamp(object oPC, int nTourney);

// Do lance rack cleanup.
void DLA_CheckLanceRacks();

// -nTourney: The tournament to set oPC as the champion of.
// Set oPC as the champion of nTourney
void DLA_SetTourneyChamp(object oPC, int nTourney);

// Setup the opponent to be used against oPC in the next tilt.
void DLA_SetupOpponent(object oPC);

// Change the tail of oPC to the joust colors they have chosen or to a default
// joust-tail color.
void DLA_ChangeToJoustColors(object oPC);

// Check oPC for proper armor, shield and helmet in order to joust
int DLA_JoustGetIsEquipped(object oPC);

// Return oPC to the person that gave them the match.
void DLA_JoustReturnToAgent(object oPC);

// FILE: dla_i0_joust
// This function makes sure that oWearer equips oItem in slot
// nSlot and does not assume it happens.  It will keep trying
// until it succeeds.
void DLA_ForceEquip(object oWearer,object oItem,int nSlot);

// FILE: dla_i0_joust
// This function makes sure that oWearer unequips oItem if
// it is in slot nSlot.
void DLA_ForceUnequip2(object oWearer,object oItem,int nSlot);

// FILE: dla_i0_joust
// This function insures that oObject is destroyed.
void DLA_DestroyObject(object oObject);

// Prototype Cutscene Functions ////////////////////////////////////////////////
void DLA_HealJouster            (object oJouster);

// Remove the tip of the lance
void DLA_BreakLance             (object oLance);

void DLA_UnhelmJouster          (object oPC);

// Add the appropriate property to the lance in order to
//  make it whole again.
void DLA_ResetLance             (object oLance);

// Refill the lance rack
void DLA_ResetLanceRack         (object oLanceRack);

// Lance Rack Cutscene functions
void DLA_JoustSetupJousters     (object oPC, object oOP);
void DLA_RemoveFromLanceRack    (object oPC, int nLance);
void DLA_EquipLanceFromRack     (object oPC, int nLance);
void DLA_SelectLance            (object oPC, int nLance);
void DLA_EndCutsceneLanceRack   (object oPC);
void DLA_PlayLanceRackCutscene  (object oPC, int nLance);
void DLA_CutsceneLanceRack      (object oPC);



// Function Definitions ////////////////////////////////////////////////////////

int DLA_AimChance(int iAim, int iPercent)
{
    if(Random(100)+1 <= iPercent)
        return iAim;

    // Percentage chance failed, return a differnt aim point
    int iComp = iAim;
    do
    {
        iAim = Random(8)+1;
    }while(iAim == iComp);

    return iAim;
}

int DLA_SeatChance(int iAim, int iSeat, int iPercent, int nStunCondition)
{
    //this considers aim point and then only random picks seats based on
    //aim point
    if(Random(100)+1 <= iPercent
      && DLA_GetIsDefPosValid(iAim, iSeat, nStunCondition))
         return iSeat;

    //Gale 3 Feb 2006: Changed to use the new function GetIsDefPosValid
    //also fixed the wrong random for percentage
    int iComp = iSeat;
    do
    {
        iSeat = Random(8)+1;
    }while(iSeat == iComp || !DLA_GetIsDefPosValid(iAim, iSeat, nStunCondition));

    return iSeat;
}

//Syrsnein 2 Feb 2006:
void DLA_SetInfamy(object oCreature, int nValue)
{

    if (nValue>0)
    {
        if (GetIsPC(oCreature) && nValue >= 8)
            GiveKnightReputation(oCreature, "the Unchivalrous");
        SetLocalInt(oCreature, DLA_VAR_INFAMY, nValue);
    }
    else
        DeleteLocalInt(oCreature, DLA_VAR_INFAMY);
}

//Syrsnein 2 Feb 2006:
int DLA_GetInfamy(object oCreature)
{
    return GetLocalInt(oCreature, DLA_VAR_INFAMY);
}

//Syrsnein 2 Feb 2006:
void DLA_AdjustInfamy(object oCreature, int nValue)
{
    if (GetIsPC(oCreature) && DLA_GetIsOnTraining(oCreature)) return;

    int nNewValue = DLA_GetInfamy(oCreature) + nValue;
    if (GetIsPC(oCreature) && nNewValue >= 6)
    {
        GiveKnightReputation(oCreature, "the Unchivalrous");
    }
    SetLocalInt(oCreature, DLA_VAR_INFAMY, nNewValue);
}

//Syrsnein 2 Feb 2006:
int DLA_GetStunCondition(object oCreature)
{
    return GetLocalInt(oCreature, DLA_VAR_STUN_CONDITION);
}

//Syrsnein 2 Feb 2006:
void DLA_SetStunCondition(object oCreature, int bForce = FALSE)
{
    int nCondition = DLA_GetStunCondition(oCreature);
    int nInfamy;
    if (!bForce)
        nInfamy = DLA_GetInfamy(oCreature);

    if (bForce || !FortitudeSave(oCreature, DLA_GLANCE_SAVE + nInfamy))
    {
        nCondition++;
        if (nCondition > DLA_JOUST_CONDITION_STUNNED)
                nCondition = DLA_JOUST_CONDITION_STUNNED;
        SetLocalInt(oCreature, DLA_VAR_STUN_CONDITION, nCondition);
    }
}

//Syrsnein 27 Feb 2006:
void DLA_RemoveStunCondition(object oCreature)
{
    DeleteLocalInt(oCreature, DLA_VAR_STUN_CONDITION);
}

//Syrsnein 2 Feb 2006:
void DLA_SetAimPos(object oCreature, int nAimPos)
{
    SetLocalInt(oCreature, DLA_VAR_AIM_POS, nAimPos);
}
//Syrsnein 2 Feb 2006:
int DLA_GetAimPos(object oCreature)
{
    return GetLocalInt(oCreature, DLA_VAR_AIM_POS);
}

//Syrsnein 2 Feb 2006:
void DLA_DeleteAimPos(object oCreature)
{
    DeleteLocalInt(oCreature, DLA_VAR_AIM_POS);
}

//Syrsnein 2 Feb 2006:
void DLA_SetDefPos(object oCreature, int nDefPos)
{
    SetLocalInt(oCreature, DLA_VAR_DEF_POS, nDefPos);
}

//Syrsnein 2 Feb 2006:
int DLA_GetDefPos(object oCreature)
{
    return GetLocalInt(oCreature, DLA_VAR_DEF_POS);
}

//Syrsnein 2 Feb 2006:
void DLA_DeleteDefPos(object oCreature)
{
    DeleteLocalInt(oCreature, DLA_VAR_DEF_POS);
}

//Syrsnein 2 Feb 2006:
int DLA_GetIsDefPosValid(int nAimPos, int nDefPos, int nStunCondition)
{
    int bStunned = nStunCondition >= DLA_JOUST_CONDITION_STUNNED;
    int bShaken = nStunCondition >= DLA_JOUST_CONDITION_SHAKEN;

    switch (nDefPos)
    {
        case DLA_JOUST_DEF_HELM:
            return (!bShaken &&
                    (nAimPos == DLA_JOUST_ATK_DC ||
                     nAimPos == DLA_JOUST_ATK_SF ||
                     nAimPos == DLA_JOUST_ATK_BASE));
        case DLA_JOUST_DEF_RIGHT:
            return (!bShaken &&
                    (nAimPos == DLA_JOUST_ATK_SC ||
                     nAimPos == DLA_JOUST_ATK_SF ||
                     nAimPos == DLA_JOUST_ATK_BASE));
        case DLA_JOUST_DEF_LEFT:
            return (!bShaken &&
                    (nAimPos == DLA_JOUST_ATK_DC ||
                     nAimPos == DLA_JOUST_ATK_CP ||
                     nAimPos == DLA_JOUST_ATK_DF ||
                     nAimPos == DLA_JOUST_ATK_SF ));
        case DLA_JOUST_DEF_STEADY:
            return TRUE;
        case DLA_JOUST_DEF_HIGH:
            return (!bStunned);
        case DLA_JOUST_DEF_LOW:
            return (!bStunned);
    }
    return FALSE;
}

int DLA_GetOutcomeVar(object oCreature)
{
    return GetLocalInt(oCreature, DLA_OUTCOME_MASTER_VAR);
}

int DLA_GetOutcome(object oCreature, int nOutCome)
{
    int nStored = GetLocalInt(oCreature, DLA_OUTCOME_MASTER_VAR);
    return nStored & nOutCome;
}

void DLA_SetOutcome(object oCreature, int nOutCome, int bValue = TRUE)
{
    int nStored = GetLocalInt(oCreature, DLA_OUTCOME_MASTER_VAR);
    if(bValue == TRUE)
    {
        nStored |= nOutCome;  //sets the bit specified by nOutCome to TRUE
                              //using bitwise "or"
        SetLocalInt(oCreature,DLA_OUTCOME_MASTER_VAR, nStored);
    }
    else if (bValue == FALSE)
    {
        nStored &= ~nOutCome; //sets the bit specified by nOutCome to FALSE
                              //using bitwise "and" and bitwise inversor
        SetLocalInt(oCreature, DLA_OUTCOME_MASTER_VAR, nStored);
    }
}

void DLA_PlayOutcomeAnimation(object oTarget)
{
    int nOutcomeVar = DLA_GetOutcomeVar(oTarget);

    // Syrsnein 9 May 2006: Run animations AFTER all effects have been applied
    //  We weren't seeing some of the effects due to animation actions happening
    //  first.
    if(DLA_GetStateIsSet(nOutcomeVar, DLA_OUTCOME_BREAKLANCE))
    {
        DLA_JoustDebug(GetName(oTarget) + " was hit for a broken lance.");
        int nVFX = VFX_FNF_DLA_WOOD_SHATTER;
        switch (d3())
        {
            case 2: nVFX = VFX_FNF_DLA_WOOD_SHATTER_A;
            case 3: nVFX = VFX_FNF_DLA_WOOD_SHATTER_B;
        }
        // Plot integration for "Fall of Jonas" poisoning of the PC
        if (GetIsPC(oTarget) && DLA_GetOpponentNumber(oTarget)==9 && DLA_GetTiltRounds(oTarget)==1)
        {
//            AllParty("nPoisonedByBK",oTarget,1);
            effect ePoison = EffectVisualEffect(VFX_IMP_POISON_L);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePoison, oTarget);
        }
        effect eBreakLance = EffectVisualEffect(nVFX);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBreakLance, oTarget);
    }

    if(DLA_GetStateIsSet(nOutcomeVar, DLA_OUTCOME_HELMKNOCKEDOFF))
    {
        effect eImpact = EffectVisualEffect(VFX_IMP_SONIC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
        effect eSound = EffectVisualEffect(SFX_IMP_LANCEHIT);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eSound, oTarget);
        // Syrsnein 9 May 2006: Added Stunned visual effect for a short time.
//        AssignCommand(oTarget, DLA_ForceUnequip2(oTarget,GetLocalObject(oTarget, "dla_joust_helmet"),INVENTORY_SLOT_HEAD));
    }

    if(DLA_GetStateIsSet(nOutcomeVar, DLA_OUTCOME_GLANCEOFF))
    {
        effect eSound = EffectVisualEffect(SFX_IMP_LANCEHIT);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eSound, oTarget);
    }

    if(DLA_GetStateIsSet(nOutcomeVar, DLA_OUTCOME_INJURED))
    {
        effect eBlood = EffectVisualEffect(VFX_COM_BLOOD_SPARK_MEDIUM);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBlood, oTarget);
    }

    // Syrsnein 9 May 2006: Play animations now that effects have been done.

    // Syrsnein 27 Feb 2006: Moved this above knocked off so that helm off
    // happens first if the outcome so indicates a helm knocked off/unhorsed
    if(DLA_GetStateIsSet(nOutcomeVar, DLA_OUTCOME_HELMKNOCKEDOFF))
    {
        DLA_JoustDebug(GetName(oTarget) + " took a hit that unhelmed them.");

        // Syrsnein 7 Feb 2006: If there is no unhorse, show glancing animation
        if (!DLA_GetStateIsSet(nOutcomeVar, DLA_OUTCOME_UNHORSED))
        {
            AssignCommand(oTarget, PlayAnimation(ANIMATION_DLA_LOOPING_JOUST_HELMOFF,1.0,30.0));
        }
    }

    //Syrsnein 7 Feb 2006: Changed so that violent fall is done on an
    //  injure/unhorse (was doing this on any injury)
    if(DLA_GetStateIsSet(nOutcomeVar, DLA_OUTCOME_UNHORSED))
    {
        DLA_JoustDebug(GetName(oTarget)+" took a hit that unhorsed them.");
        if (DLA_GetStateIsSet(nOutcomeVar, DLA_OUTCOME_INJURED))
        {
            DLA_JoustDebug(GetName(oTarget) + " was injured in the unhorsing.");
            AssignCommand(oTarget, PlayAnimation(ANIMATION_DLA_LOOPING_JOUST_VIOLENT_FALL, 1.0, 30.0));
        }
        else
        {
            AssignCommand(oTarget, PlayAnimation(ANIMATION_DLA_LOOPING_JOUST_FALL, 1.0, 30.0));
        }
        effect eSound = EffectVisualEffect(SFX_IMP_JOUSTFALL);
        DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSound, GetLocation(oTarget)));
    }

    if(DLA_GetStateIsSet(nOutcomeVar, DLA_OUTCOME_GLANCEOFF))
    {
        DLA_JoustDebug(GetName(oTarget) + " took a glancing blow.");
        AssignCommand(oTarget, PlayAnimation(ANIMATION_DLA_LOOPING_JOUST_GLANCE,1.0,99.0));
    }
}

//Gale 17 Jan 2006:
//Calculates and play the outcome animation based on oPC seat option, and oOP aim option
//It should be called again, inverting parameters to play the animation also for oOP
void DLA_DoOutcome(object oPC, object oOP)
{
    // This function sets stun condition before the actual ACTION of the joust
    //  but after the opponent and the player have chosen their strategies.

    //stores aim and seat of PC
    int iAim    = DLA_GetAimPos(oOP);
    int iPCSeat = DLA_GetDefPos(oPC);

    //automatic when jousting against jonas.  Regardless of seating posture
    if (GetIsPC(oPC) && GetTag(oOP)==DLA_TAG_JONAS)
        DLA_SetOutcome(oPC, DLA_OUTCOME_INJURED | DLA_OUTCOME_BREAKLANCE);

    //what happens to the PC is stated here and will play possible animations
    if (iPCSeat == DLA_JOUST_DEF_HELM)
    {
        switch (iAim)
        {
            //miss
            case DLA_JOUST_ATK_HELM:
                DLA_SetOutcome(oPC, DLA_OUTCOME_MISS);
                break;
            //unhorsed
            case DLA_JOUST_ATK_DC:
                DLA_SetOutcome(oPC, DLA_OUTCOME_UNHORSED);
                break;
            //break lance, unhorsed, injured
            case DLA_JOUST_ATK_CP:
                DLA_SetOutcome(oPC, DLA_OUTCOME_UNHORSED |
                                    DLA_OUTCOME_INJURED  |
                                    DLA_OUTCOME_BREAKLANCE);
                break;
            //glances off
            case DLA_JOUST_ATK_SC:
                DLA_SetOutcome(oPC, DLA_OUTCOME_GLANCEOFF);
                break;
            //break lance
            case DLA_JOUST_ATK_DF:
                DLA_SetOutcome(oPC, DLA_OUTCOME_BREAKLANCE);
                break;
            //miss
            case DLA_JOUST_ATK_FP:
                DLA_SetOutcome(oPC, DLA_OUTCOME_MISS);
                break;
            //Glances off
            case DLA_JOUST_ATK_SF:
                DLA_SetOutcome(oPC, DLA_OUTCOME_GLANCEOFF);
                break;
            //Glances off
            case DLA_JOUST_ATK_BASE:
                DLA_SetOutcome(oPC, DLA_OUTCOME_GLANCEOFF);
                break;
            default:
                break;
        }
    }
    else if (iPCSeat == DLA_JOUST_DEF_RIGHT)
    {
        switch (iAim)
        {
            //miss
            case DLA_JOUST_ATK_HELM:
                DLA_SetOutcome(oPC, DLA_OUTCOME_MISS);
                break;
            //glances off
            case DLA_JOUST_ATK_DC:
                DLA_SetOutcome(oPC, DLA_OUTCOME_GLANCEOFF);
                break;
            //break lance
            case DLA_JOUST_ATK_CP:
                DLA_SetOutcome(oPC, DLA_OUTCOME_BREAKLANCE);
                break;
            //miss
            case DLA_JOUST_ATK_SC:
                DLA_SetOutcome(oPC, DLA_OUTCOME_MISS);
                break;
            //break lance, unhorsed
            case DLA_JOUST_ATK_DF:
                DLA_SetOutcome(oPC, DLA_OUTCOME_BREAKLANCE |
                                    DLA_OUTCOME_UNHORSED);
                break;
            //glances off
            case DLA_JOUST_ATK_FP:
                DLA_SetOutcome(oPC, DLA_OUTCOME_GLANCEOFF);
                break;
            //break lance
            case DLA_JOUST_ATK_SF:
                DLA_SetOutcome(oPC, DLA_OUTCOME_BREAKLANCE);
                break;
            //miss
            case DLA_JOUST_ATK_BASE:
                DLA_SetOutcome(oPC, DLA_OUTCOME_MISS);
                break;
            default:
                break;
        }
    }
    else if (iPCSeat == DLA_JOUST_DEF_LEFT)
    {
        switch (iAim)
        {
            //miss
            case DLA_JOUST_ATK_HELM:
                DLA_SetOutcome(oPC, DLA_OUTCOME_MISS);
                break;
            //miss
            case DLA_JOUST_ATK_DC:
                DLA_SetOutcome(oPC, DLA_OUTCOME_MISS);
                break;
            //miss
            case DLA_JOUST_ATK_CP:
                DLA_SetOutcome(oPC, DLA_OUTCOME_MISS);
                break;
            //helm off
            case DLA_JOUST_ATK_SC:
                DLA_SetOutcome(oPC, DLA_OUTCOME_HELMKNOCKEDOFF);
                break;
            //miss
            case DLA_JOUST_ATK_DF:
                DLA_SetOutcome(oPC, DLA_OUTCOME_MISS);
                break;
            //break lance
            case DLA_JOUST_ATK_FP:
                DLA_SetOutcome(oPC, DLA_OUTCOME_BREAKLANCE);
                break;
            //break lance, unhorsed
            case DLA_JOUST_ATK_SF:
                DLA_SetOutcome(oPC, DLA_OUTCOME_BREAKLANCE |
                                    DLA_OUTCOME_UNHORSED);
                break;
            //miss
            case DLA_JOUST_ATK_BASE:
                DLA_SetOutcome(oPC, DLA_OUTCOME_MISS);
                break;
            default:
                break;
        }
    }
    else if (iPCSeat == DLA_JOUST_DEF_STEADY)
    {
        switch (iAim)
        {
            //helm off
            case DLA_JOUST_ATK_HELM:
                DLA_SetOutcome(oPC, DLA_OUTCOME_HELMKNOCKEDOFF);
                break;
            //break lance
            case DLA_JOUST_ATK_DC:
                DLA_SetOutcome(oPC, DLA_OUTCOME_BREAKLANCE);
                break;
            //break lance, injured
            case DLA_JOUST_ATK_CP:
                DLA_SetOutcome(oPC, DLA_OUTCOME_BREAKLANCE |
                                    DLA_OUTCOME_INJURED);
                break;
            //glances off
            case DLA_JOUST_ATK_SC:
                DLA_SetOutcome(oPC, DLA_OUTCOME_GLANCEOFF);
                break;
            //break lance
            case DLA_JOUST_ATK_DF:
                DLA_SetOutcome(oPC, DLA_OUTCOME_BREAKLANCE);
                break;
            //break lance, unhorsed
            case DLA_JOUST_ATK_FP:
                DLA_SetOutcome(oPC, DLA_OUTCOME_BREAKLANCE |
                                    DLA_OUTCOME_UNHORSED);
                break;
            //glances off
            case DLA_JOUST_ATK_SF:
                DLA_SetOutcome(oPC, DLA_OUTCOME_GLANCEOFF);
                break;
            //break lance
            case DLA_JOUST_ATK_BASE:
                DLA_SetOutcome(oPC, DLA_OUTCOME_BREAKLANCE);
                break;
            default: break;
        }
    }
    else if (iPCSeat == DLA_JOUST_DEF_HIGH)
    {
        switch (iAim)
        {
            //unhorsed
            case DLA_JOUST_ATK_HELM:
                DLA_SetOutcome(oPC, DLA_OUTCOME_UNHORSED);
                break;
            //break lance
            case DLA_JOUST_ATK_DC:
                DLA_SetOutcome(oPC, DLA_OUTCOME_BREAKLANCE);
                break;
            //glances off
            case DLA_JOUST_ATK_CP:
                DLA_SetOutcome(oPC, DLA_OUTCOME_GLANCEOFF);
                break;
            //glances off
            case DLA_JOUST_ATK_SC:
                DLA_SetOutcome(oPC, DLA_OUTCOME_GLANCEOFF);
                break;
            //miss
            case DLA_JOUST_ATK_DF:
                DLA_SetOutcome(oPC, DLA_OUTCOME_MISS);
                break;
            //break lance, unhorsed, injured
            case DLA_JOUST_ATK_FP:
                DLA_SetOutcome(oPC, DLA_OUTCOME_UNHORSED |
                                    DLA_OUTCOME_INJURED  |
                                    DLA_OUTCOME_BREAKLANCE);
                break;
            //glances off
            case DLA_JOUST_ATK_SF:
                DLA_SetOutcome(oPC, DLA_OUTCOME_GLANCEOFF);
                break;
            //unhorsed, injured
            case DLA_JOUST_ATK_BASE:
                DLA_SetOutcome(oPC, DLA_OUTCOME_UNHORSED |
                                    DLA_OUTCOME_INJURED);
                break;
            default:
                break;
        }
    }
    else if (iPCSeat == DLA_JOUST_DEF_LOW)
    {
        switch (iAim)
        {
            //helm off, injured
            case DLA_JOUST_ATK_HELM:
                DLA_SetOutcome(oPC, DLA_OUTCOME_HELMKNOCKEDOFF |
                                    DLA_OUTCOME_INJURED);
                break;
            //miss
            case DLA_JOUST_ATK_DC:
                DLA_SetOutcome(oPC, DLA_OUTCOME_MISS);
                break;
            //unhorsed, injured
            case DLA_JOUST_ATK_CP:
                DLA_SetOutcome(oPC, DLA_OUTCOME_UNHORSED |
                                    DLA_OUTCOME_INJURED);
                break;
            //unhorsed
            case DLA_JOUST_ATK_SC:
                DLA_SetOutcome(oPC, DLA_OUTCOME_UNHORSED);
                break;
            //glances off
            case DLA_JOUST_ATK_DF:
                DLA_SetOutcome(oPC, DLA_OUTCOME_GLANCEOFF);
                break;
            //miss
            case DLA_JOUST_ATK_FP:
                DLA_SetOutcome(oPC, DLA_OUTCOME_MISS);
                break;
            //break lance
            case DLA_JOUST_ATK_SF:
                DLA_SetOutcome(oPC, DLA_OUTCOME_BREAKLANCE);
                break;
            //break lance
            case DLA_JOUST_ATK_BASE:
                DLA_SetOutcome(oPC, DLA_OUTCOME_BREAKLANCE);
                break;
            default:
            break;
        }
    }
    else
        //this can not happen or you picked something out of range
        DLA_JoustDebug(GetName(oPC) + " has picked an invalid aim...report bug.");

    int isPC = GetIsPC(oPC);
    // Get the master outcome variable
    int nOutcome = DLA_GetOutcomeVar(oPC);
//Syrsnein 13 June 2006, replaced DLA_GetOutcome() calls with DLA_GetIsStateSet()
//    if (DLA_GetOutcome(oPC, DLA_OUTCOME_INJURED))
    if (DLA_GetStateIsSet(nOutcome, DLA_OUTCOME_INJURED))
        DLA_AdjustInfamy(oPC, 2);

    // If a stun outcome exists, stun the bugger, else remove any stun conditions
//    if (DLA_GetOutcome(oPC, DLA_OUTCOME_GLANCEOFF) ||
//        DLA_GetOutcome(oPC, DLA_OUTCOME_HELMKNOCKEDOFF) ||
//        DLA_GetOutcome(oPC, DLA_OUTCOME_INJURED))
    if (DLA_GetStateIsSet(nOutcome, DLA_OUTCOME_GLANCEOFF) ||
        DLA_GetStateIsSet(nOutcome, DLA_OUTCOME_HELMKNOCKEDOFF) ||
        DLA_GetStateIsSet(nOutcome, DLA_OUTCOME_INJURED))
    {
        DLA_SetStunCondition(oPC);
    }
    else DLA_RemoveStunCondition(oPC);
}

object DLA_SpawnOpponent(object oPC)
{
    string sResref = DLA_GetOpponentResref(oPC);
    DLA_JoustDebug("<DLA_SpawnOpponent> ResRef: " + sResref);
    object oOP = OBJECT_INVALID;
    int nIndex = DLA_GetOpponentNumber(oPC);
    if (nIndex < 9)
    {
        oOP = CreateObject(OBJECT_TYPE_CREATURE, sResref, GetLocation(GetWaypointByTag("DLA_WRACK_OP")), FALSE, sResref);
        //Syrsnein 23 Feb 2006: Assumes that the only item in the opponents inventory is a jousting helmet
        SetLocalObject(oOP, DLA_VAR_JOUST_HELMET, GetFirstItemInInventory(oOP));
    }
    else
    {
        oOP = DLA_JoustCreateJonas(oPC);
        object oHelmet = CreateItemOnObject(DLA_TAG_JONAS_HELMET, oOP);
        object oLance = CreateItemOnObject(DLA_TAG_JONAS_LANCE, oOP);
        object oArmor = CreateItemOnObject(DLA_TAG_JONAS_ARMOR, oOP);
        object oShield = CreateItemOnObject(DLA_TAG_JONAS_SHIELD, oOP);
        AssignCommand(oOP, DLA_ForceEquip(oOP,oArmor, INVENTORY_SLOT_CHEST));
        AssignCommand(oOP, DLA_ForceEquip(oOP,oHelmet, INVENTORY_SLOT_HEAD));
        AssignCommand(oOP, DLA_ForceEquip(oOP,oLance, INVENTORY_SLOT_RIGHTHAND));
        SetLocalObject(oOP, DLA_VAR_JOUST_HELMET, oHelmet);
        SetLocalObject(oOP, DLA_VAR_JOUST_SHIELD, oShield);
        SetLocalObject(oOP, DLA_VAR_JOUST_LANCE, oLance);
        SetLocalInt(oOP, DLA_VAR_JOUST_LANCE_COLOR, DLA_LANCE_BK);
    }
    return oOP;
}

void DLA_SetupOpponent(object oPC)
{
    // is oPC on training
    int bTraining = DLA_GetIsOnTraining(oPC);

    // The opponent should already be spawned, lets set him up now.
    object oOP = GetLocalObject(oPC, DLA_VAR_JOUST_OPPONENT);
    int nStunCondition = DLA_GetStunCondition(oOP);
    int iAim;
    int iSeat; //<--stores aim and seat of opponent

    int nOpponent = DLA_GetOpponentNumber(oPC);

    //Determine which opponent is on the field facing oPC and what strategies
    //they will use.
    //To determine enemies strategy use DLA_AimChance to specify a certain
    //  percentage on where the opponent will aim.
    //Then use use DLA_SeatChance to determine where the opponent will seat
    //  and what percent of the time.
    //NOTE: You MUST provide an aim point first by calling DLA_AimChance
    //  and then sending it as the first parameter in DLA_SeatChance since
    //  defense depend on what aim you picked.
    //  Refer to the matrix, It will not be explain further here.
    switch (nOpponent)
    {
        case 1: //1 Sir Azar Truesilver - Helm
        {       //1 Bandobras Tolman (Halfling)
            if (bTraining)
                iAim  = DLA_AimChance(DLA_JOUST_ATK_HELM, 100);
            else
                iAim  = DLA_AimChance(DLA_JOUST_ATK_HELM, 70);

            iSeat = DLA_SeatChance(iAim, DLA_JOUST_DEF_HIGH, 16, nStunCondition);
        }; break;

        case 2: //2 Sir Drake Huntcrown - Base
        {       //2 Baldo Tolman (Halfling)
            if (bTraining)
                iAim  = DLA_AimChance(DLA_JOUST_ATK_DC, 100);
            else
                iAim  = DLA_AimChance(DLA_JOUST_ATK_BASE, 70);

            iSeat = DLA_SeatChance(iAim, DLA_JOUST_DEF_HIGH, 16, nStunCondition);
        }; break;

        case 3: //3 Sir Reginald Huntsilver - Sinister Fess (lower left)
        {       //3 Stren Sternhelm (Dwarf)
            if (bTraining)
                iAim  = DLA_AimChance(DLA_JOUST_ATK_CP, 100);
            else
                iAim  = DLA_AimChance(DLA_JOUST_ATK_SF, 70);

            iSeat = DLA_SeatChance(iAim, DLA_JOUST_DEF_HIGH, 16, nStunCondition);
        }; break;

        case 4: //4 Sir Baradin Hawklin - Helm
        {       //4 Hathnor Thunderbrow (Dwarf)
            if (bTraining)
                iAim  = DLA_AimChance(DLA_JOUST_ATK_SC, 100);
            else
                iAim  = DLA_AimChance(DLA_JOUST_ATK_HELM, 50);

            iSeat = DLA_SeatChance(iAim, DLA_JOUST_DEF_HIGH, 16, nStunCondition);
        }; break;

        case 5: //5 Lady Morgana Wyvernspur - Dexter Chief (Upper right)
        {       //5 Rose Greenwood (F Halfling)
            if (bTraining)
                iAim  = DLA_AimChance(DLA_JOUST_ATK_DF, 100);
            else
                iAim = DLA_AimChance(DLA_JOUST_ATK_DC, 70);

            iSeat = DLA_SeatChance(iAim, DLA_JOUST_DEF_HIGH, 16, nStunCondition);
        }; break;

        case 6: //6 Sir Blakeney Hawklin - Pale Chief (upper centre)
        {       //6 Inuman Insar (Gnome)
            if (bTraining)
                iAim  = DLA_AimChance(DLA_JOUST_ATK_FP, 100);
            else
                iAim  = DLA_AimChance(DLA_JOUST_ATK_CP, 70);

            iSeat = DLA_SeatChance(iAim, DLA_JOUST_DEF_HIGH, 16, nStunCondition);
        }; break;

        case 7: //7 Lady Arianne FitzCormaeril - Dexter Fess
        {       //7 As above but she's a halfling.
            if (bTraining)
                iAim  = DLA_AimChance(DLA_JOUST_ATK_SF, 100);
            else
                iAim  = DLA_AimChance(DLA_JOUST_ATK_DF, 70);

            iSeat = DLA_SeatChance(iAim, DLA_JOUST_DEF_HIGH, 16, nStunCondition);
        }; break;

        case 8: //8 Sir Giolin Wyvernspur - Base
        {       //8 Millas Hoffin (Halfling)
            if (bTraining)
                iAim  = DLA_AimChance(DLA_JOUST_ATK_BASE, 100);
            else
                iAim  = DLA_AimChance(DLA_JOUST_ATK_BASE, 70);

            iSeat = DLA_SeatChance(iAim, DLA_JOUST_DEF_HIGH, 16, nStunCondition);
        }; break;

        case 9: //9 Jonas - Specific Aim, random seat
        {
            iAim  = DLA_AimChance(DLA_JOUST_ATK_CP, 100);
            iSeat = DLA_SeatChance(iAim, DLA_JOUST_DEF_HIGH, 16, nStunCondition);
        }; break;

        default://default behaviour, just random Aim / Seat
        {
            if (bTraining)
                iAim  = DLA_AimChance(DLA_JOUST_ATK_HELM, 100);
            else
                iAim  = DLA_AimChance(DLA_JOUST_ATK_HELM, 12);

            iSeat = DLA_SeatChance(iAim, DLA_JOUST_DEF_HELM, 16, nStunCondition);
        }
    }

    DLA_JoustDebug("<DLA_SetupOpponent> " + GetName(oOP) + "[" + GetResRef(oOP) + "]");
    DLA_JoustDebug("<DLA_SetupOpponent>     Aim  = " + IntToString(iAim));
    DLA_JoustDebug("<DLA_SetupOpponent>     Seat = " + IntToString(iSeat));
    DLA_SetAimPos(oOP, iAim);
    DLA_SetDefPos(oOP, iSeat);

    int nRound = DLA_GetTiltRounds(oPC);

    //keep track of joust rounds
    //Gale 15 Jan 2005: Now really the number stored is the round number
    DLA_SetTiltRounds(oPC, nRound+1);

    //Gale 15 Jan 2005: Opening jousting grounds, so need to keep track of who is on jousting
    SetLocalInt(oPC, DLA_VAR_JOUST_ON, TRUE);
}



//Gale 26 Dec 2005: Basic function to change to jousting pheno.
//Creature should be already on one mounted pheno.
//This is needed to give access to jousting animations.
void DLA_ChangeToJoustingPheno(object oCreature)
{
    int nPheno = GetPhenoType(oCreature)==PHENOTYPE_DLA_MOUNTED_BIG
                ? PHENOTYPE_DLA_JOUSTING_BIG : PHENOTYPE_DLA_JOUSTING_NORMAL;

    DLA_JoustDebug(GetName(oCreature) + " expected pheno type = " + IntToString(nPheno));
    SetPhenoType(nPheno, oCreature);
    nPheno = GetPhenoType(oCreature);
    DLA_JoustDebug(GetName(oCreature) + " actual pheno type = " + IntToString(nPheno));
    if (nPheno!=PHENOTYPE_DLA_JOUSTING_BIG && nPheno!=PHENOTYPE_DLA_JOUSTING_NORMAL)
        DelayCommand(0.1, AssignCommand(oCreature, DLA_ChangeToJoustingPheno(oCreature)));
}

void DLA_ChangeToMountedPheno(object oCreature)
{// Assumes we are in jousting pheno.
    DLA_JoustDebug("   Change to mounted pheno.");

    int nPheno = GetPhenoType(oCreature)==PHENOTYPE_DLA_JOUSTING_BIG
                ? PHENOTYPE_DLA_MOUNTED_BIG : PHENOTYPE_DLA_MOUNTED_NORMAL;

    DLA_JoustDebug(GetName(oCreature) + " expected pheno type = " + IntToString(nPheno));
    SetPhenoType(nPheno, oCreature);
    nPheno = GetPhenoType(oCreature);
    DLA_JoustDebug(GetName(oCreature) + " actual pheno type = " + IntToString(nPheno));
    if (nPheno!=PHENOTYPE_DLA_MOUNTED_BIG && nPheno!=PHENOTYPE_DLA_MOUNTED_NORMAL)
        DelayCommand(0.1, AssignCommand(oCreature, DLA_ChangeToMountedPheno(oCreature)));
}

//Gale 18 Jan 2006: Returns how many points the opponent of oCreature should earned
//this jousting round.
int DLA_GetScoreOnRound(object oCreature)
{
    // 13 June 2006, Syrsnein: Replaced DLA_DoOutcome() calls with
    //  DLA_GetStateIsSet()
    int iScore;
    // Get the master outcome variable
    int nOutcome = DLA_GetOutcomeVar(oCreature);

    if (DLA_GetStateIsSet(nOutcome, DLA_OUTCOME_UNHORSED))
       iScore += 3;
    else if (DLA_GetStateIsSet(nOutcome, DLA_OUTCOME_HELMKNOCKEDOFF))
       iScore += 2;
    else if (DLA_GetStateIsSet(nOutcome, DLA_OUTCOME_BREAKLANCE))
       iScore += 1;
    return iScore;
}

//Gale 18 Jan 2006:
//if bOpponent is set to TRUE, then return the score of the opponent of oPC on
//last jousting round. Otherwise, return the score of oPC itself.
//Return 0 on error.
int DLA_GetScoreOnMatch(object oPC, int bOpponent=FALSE)
{
    string sVar = bOpponent ? DLA_VAR_JOUST_OPP_SCORE : DLA_VAR_JOUST_PC_SCORE;
    return GetLocalInt(oPC, sVar);
}

//Gale 18 Jan 2006:
//if bOpponent is set to TRUE, then set the score of the opponent of oPC on
//last jousting round. Otherwise, set the score of oPC itself.
void DLA_SetScoreOnMatch(object oPC, int bOpponent=FALSE, int nScore = 0)
{
    string sVar = bOpponent ? DLA_VAR_JOUST_OPP_SCORE : DLA_VAR_JOUST_PC_SCORE;
    if (!nScore)
        DeleteLocalInt(oPC, sVar);
    else
        SetLocalInt(oPC, sVar, nScore);
}

//Gale 18 Jan 2006:
//Changed implementation to use the new wraper functions, encapsulating
//access to local vars
void DLA_ScoreKeep(object oPC, object oOpponent)
{

    //Get how many points PC scored on last jousting round
    int iScoreOnRound = DLA_GetScoreOnRound(oOpponent);
    int iScoreOnMatch = DLA_GetScoreOnMatch(oPC);
    //Store PC points
    DLA_SetScoreOnMatch(oPC, FALSE, iScoreOnMatch + iScoreOnRound);

    //Now do the same for PC's Opponent
    iScoreOnRound = DLA_GetScoreOnRound(oPC);
    iScoreOnMatch = DLA_GetScoreOnMatch(oPC, TRUE);
    //Store Opponent points
    DLA_SetScoreOnMatch(oPC, TRUE, iScoreOnMatch + iScoreOnRound);
}

int DLA_JoustGetCanJoust(object oPC)
{
    return (DLA_GetHasWarHorse(oPC) && DLA_JoustGetIsEquipped(oPC));
}

int DLA_GetTiltRounds(object oPC)
{
    return GetLocalInt(oPC, DLA_VAR_JOUST_ROUND);
}

void DLA_SetTiltRounds(object oPC, int nRounds)
{
    SetLocalInt(oPC, DLA_VAR_JOUST_ROUND, nRounds);
}

int DLA_GetTourneyMatches(object oPC)
{
    return GetLocalInt(oPC, DLA_VAR_JOUST_MATCHES);
}

void DLA_SetTourneyMatches(object oPC, int nMatches)
{
    SetLocalInt(oPC, DLA_VAR_JOUST_MATCHES, nMatches);
}

int DLA_GetTourneyWins(object oPC)
{
    return GetLocalInt(oPC, DLA_VAR_JOUST_WINS);
}

void DLA_SetTourneyWins(object oPC, int nWins)
{
    SetLocalInt(oPC, DLA_VAR_JOUST_WINS, nWins);
}

int DLA_GetHasJoustMatch(object oPC)
{
    return GetLocalInt(oPC, DLA_VAR_JOUST_MATCH_SET);
}

void DLA_SetHasJoustMatch(object oPC, int bMatch=TRUE)
{
    SetLocalInt(oPC, DLA_VAR_JOUST_MATCH_SET, bMatch);
}

void DLA_RemoveHasJoustMatch(object oPC)
{
    DeleteLocalInt(oPC, DLA_VAR_JOUST_MATCH_SET);
}

int DLA_GetIsEnteredInLists(object oPC)
{
    int nMatches = DLA_GetTourneyMatches(oPC);
    int nWins    = DLA_GetTourneyWins(oPC);
    if (nMatches>0 && nMatches==nWins) return TRUE;
    return FALSE;
}

int DLA_GetIsJoustChampion(object oPC, int nTournament)
{
    return ((GetLocalInt(oPC, DLA_TOURNEY_CHAMP) & nTournament) > 0);
}

void DLA_SetIsJoustChampion(object oPC, int nTournament)
{
    int nTemp = GetLocalInt(oPC, DLA_TOURNEY_CHAMP) & nTournament;
    SetLocalInt(oPC, DLA_TOURNEY_CHAMP, nTemp);
}

void DLA_ReequipOwnItems(object oPC)
{
    int i;
    float fCueTime = 0.0;
    object oStored;
    object oEquipped;
    DLA_JoustDebug("<DLA_ReequipOwnItems>");
    DLA_JoustDebug("   Re-equipping PC items");
    // Destroy the lance
    if (GetIsObjectValid(oEquipped=GetLocalObject(oPC, DLA_VAR_JOUST_LANCE)))
    {
        DLA_JoustDebug("    Removing/destroying lance");
        AssignCommand(oPC, ActionUnequipItem(oEquipped));
        DLA_DestroyObject(oEquipped);
    }
    if (GetLocalInt(oPC, DLA_VAR_BORROWED_SHIELD))
    {
        DLA_JoustDebug("    Removing/destroying shield");
        oEquipped=GetLocalObject(oPC, DLA_VAR_JOUST_SHIELD);
        AssignCommand(oPC, ActionUnequipItem(oEquipped));
        DLA_DestroyObject(oEquipped);
    }
    if (GetLocalInt(oPC, DLA_VAR_BORROWED_ARMOR))
    {
        DLA_JoustDebug("    Removing/destroying armor");
        oEquipped=GetLocalObject(oPC, DLA_VAR_JOUST_ARMOR);
        AssignCommand(oPC, ActionUnequipItem(oEquipped));
        DLA_DestroyObject(oEquipped);
        oStored = GetLocalObject(oPC, DLA_VAR_OWN_ARMOR);
        AssignCommand(oPC, DLA_ForceEquip(oPC,oStored, INVENTORY_SLOT_CHEST));
    }
    if (GetLocalInt(oPC, DLA_VAR_BORROWED_HELMET))
    {
        DLA_JoustDebug("    Removing/destroying helmet");
        oEquipped=GetLocalObject(oPC, DLA_VAR_JOUST_HELMET);
        AssignCommand(oPC, ActionUnequipItem(oEquipped));
        DLA_DestroyObject(oEquipped);
    }
    DeleteLocalInt(oPC, DLA_VAR_BORROWED_SHIELD);
    DeleteLocalInt(oPC, DLA_VAR_BORROWED_ARMOR);
    DeleteLocalInt(oPC, DLA_VAR_BORROWED_HELMET);
    DeleteLocalObject(oPC, DLA_VAR_JOUST_SHIELD);
    DeleteLocalObject(oPC, DLA_VAR_JOUST_ARMOR);
    DeleteLocalObject(oPC, DLA_VAR_JOUST_HELMET);
    DeleteLocalObject(oPC, DLA_VAR_JOUST_LANCE);
    DeleteLocalObject(oPC, DLA_VAR_OWN_SHIELD);
    DeleteLocalObject(oPC, DLA_VAR_OWN_ARMOR);
    DeleteLocalObject(oPC, DLA_VAR_OWN_HELMET);

    DLA_JoustDebug("   PC re-equipped.");
}

//Syrsnein
// Gets the base AC value of the object
// Loops through all properties in the event that AC bonus has been given twice
//  and uses the best value to subtract from nAC.
int DLA_GetBaseArmorValue(object oObject)
{
    int nAC      = GetItemACValue(oObject);
    int nACBonus = 0;

    if (GetItemHasItemProperty(oObject, ITEM_PROPERTY_AC_BONUS))
    {
        itemproperty ipObject = GetFirstItemProperty(oObject);
        while (GetIsItemPropertyValid(ipObject))
        {
            if (GetItemPropertyType(ipObject) == ITEM_PROPERTY_AC_BONUS)
            {
                int nACTemp = GetItemPropertyCostTableValue(ipObject);
                if (nACTemp > nACBonus) nACBonus = nACTemp;
            }
            ipObject = GetNextItemProperty(oObject);
        }
    }

    return (nAC - nACBonus);
}

//Gale 17 Jan 2006:
//Returns the first shield found on oPC inventory
//NOTE: Don't check for equiped items, as shields can't be used while mounted
//Modified by: Deva B. Winblood.  8/11/2006 - not checking for equipped caused
// some instances joust would not allow person to joust.
object DLA_GetFirstShieldAvailable(object oPC)
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
    if (GetBaseItemType(oItem)==BASE_ITEM_LARGESHIELD && GetIdentified(oItem)) return oItem;
    oItem=GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        if (GetBaseItemType(oItem)==BASE_ITEM_LARGESHIELD && GetIdentified(oItem))
            break;
        oItem = GetNextItemInInventory(oPC);
    }
    return oItem;
}

//Syrsnein
// Returns the first armor that meets our requirements or OBJECT_INVALID
// Check Equiped items first
object DLA_GetFirstArmorAvailable(object oPC)
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    if (GetIsObjectValid(oItem) && DLA_GetBaseArmorValue(oItem)>5)
        return oItem;

    oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        if (GetBaseItemType(oItem)==BASE_ITEM_ARMOR && GetIdentified(oItem) &&
            DLA_GetBaseArmorValue(oItem)>5)
            break;
        oItem = GetNextItemInInventory(oPC);
    }
    return oItem;
}

//Syrsnein
// Returns the first helmet in the PC's inventory or OBJECT_INVALID
// Check Equiped items first
object DLA_GetFirstHelmetAvailable(object oPC)
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
    if (GetIsObjectValid(oItem) && GetBaseItemType(oItem) == BASE_ITEM_HELMET)
        return oItem;

    oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        if (GetBaseItemType(oItem)==BASE_ITEM_HELMET && GetIdentified(oItem))
            break;
        oItem = GetNextItemInInventory(oPC);
    }
    return oItem;
}

//Gale 17 Jan 2006:
//Check PC for the needed items for a joust round.
//If PC don't have the item, create it and equip.
//Borrowed items will be destroyed when round is finished
void DLA_EquipJoustingItems(object oPC, int nEquip = DLA_EQUIP_ALL)
{
    object oObject = OBJECT_INVALID;

    // Find or Create Shield
    if (nEquip==DLA_EQUIP_SHIELD || nEquip==DLA_EQUIP_ALL)
    {
        object oObject = DLA_GetFirstShieldAvailable(oPC);
        if (!GetIsObjectValid(oObject))
        {
            int nIndex = DLA_JoustGetColors(oPC);
            oObject = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
            if (GetIsObjectValid(oObject))
                SetLocalObject(oPC, DLA_VAR_OWN_SHIELD, oObject);
            oObject = CreateItemOnObject(DLA_TAG_JOUST_SHIELD, oPC);
            SetLocalInt(oPC, DLA_VAR_BORROWED_SHIELD, TRUE);
        }
        //force equip shield
        SetLocalObject(oPC, DLA_VAR_JOUST_SHIELD, oObject);
        AssignCommand(oPC, DLA_ForceEquip(oPC,oObject, INVENTORY_SLOT_LEFTHAND));
    }

    // Find or Create Armor
    if (nEquip==DLA_EQUIP_ARMOR || nEquip==DLA_EQUIP_ALL)
    {
//       effect eStrBonus = EffectAbilityIncrease(ABILITY_STRENGTH, 12);
//       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStrBonus, oPC, 30.0);
        oObject = DLA_GetFirstArmorAvailable(oPC);
        if (!GetIsObjectValid(oObject))
        {
            int nIndex = DLA_JoustGetColors(oPC);
            oObject = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
            if (GetIsObjectValid(oObject))
                SetLocalObject(oPC, DLA_VAR_OWN_ARMOR, oObject);
            oObject = CreateItemOnObject(DLA_TAG_JOUST_ARMOR, oPC);
            SetLocalInt(oPC, DLA_VAR_BORROWED_ARMOR, TRUE);
        }

        //force equip armor
        SetLocalObject(oPC, DLA_VAR_JOUST_ARMOR, oObject);
        AssignCommand(oPC, DLA_ForceEquip(oPC,oObject, INVENTORY_SLOT_CHEST));
    }

    // Find or Create Helmet
    if (nEquip==DLA_EQUIP_HELM || nEquip==DLA_EQUIP_ALL)
    {
        object oObject = DLA_GetFirstHelmetAvailable(oPC);
        if (!GetIsObjectValid(oObject))
        {
            int nIndex = DLA_JoustGetColors(oPC);
            oObject=GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
            if (GetIsObjectValid(oObject))
                SetLocalObject(oPC, DLA_VAR_OWN_HELMET, oObject);
            oObject = CreateItemOnObject(DLA_TAG_JOUST_HELMET, oPC);
            SetLocalInt(oPC, DLA_VAR_BORROWED_HELMET, TRUE);
        }

        //force equip helmet
        SetLocalObject(oPC, DLA_VAR_JOUST_HELMET, oObject);
        AssignCommand(oPC, DLA_ForceEquip(oPC,oObject, INVENTORY_SLOT_HEAD));
    }
}

void DLA_JoustRemoveLance(object oPC)
{
    object oLance = GetLocalObject(oPC, DLA_VAR_JOUST_LANCE);
    AssignCommand(oPC, ActionUnequipItem(oLance));
    DLA_DestroyObject(oLance);
}

void DLA_JoustSetColors(object oPC, int nJoustTail)
{
    SetLocalInt(oPC, DLA_VAR_JOUST_COLORS, nJoustTail);
}

int DLA_JoustGetColors(object oPC)
{
    return GetLocalInt(oPC, DLA_VAR_JOUST_COLORS);
}

void DLA_JoustSetLanceColor(object oPC, int nLance)
{
    SetLocalInt(oPC,  DLA_VAR_JOUST_LANCE_COLOR, nLance);
}

int DLA_JoustGetLanceColor(object oPC)
{
    return GetLocalInt(oPC, DLA_VAR_JOUST_LANCE_COLOR);
}

string DLA_GetOpponentName(object oPC)
{
    return GetLocalString(oPC, DLA_VAR_JOUST_OPP_NAME);
}

string DLA_GetOpponentResref(object oPC)
{
    return GetLocalString(oPC, DLA_VAR_JOUST_OPP_RESREF);
}

int DLA_GetOpponentNumber(object oPC)
{
    return GetLocalInt(oPC, DLA_VAR_JOUST_OPP_NUM);
}

void DLA_SetOpponentNumber(object oPC, int nIndex)
{
    SetLocalInt(oPC, DLA_VAR_JOUST_OPP_NUM, nIndex);
}

void DLA_SetOpponentName(object oPC, string sName)
{
    SetLocalString(oPC, DLA_VAR_JOUST_OPP_NAME, sName);
}

void DLA_SetOpponentResref(object oPC, string sResref)
{
    SetLocalString(oPC, DLA_VAR_JOUST_OPP_RESREF, sResref);
}

int DLA_GetIsOpponentNumber(object oPC, int nOppNumber)
{
    return (DLA_GetOpponentNumber(oPC) == nOppNumber);
}

void DLA_SetJoustOpponent(object oPC, int nIndex, int bTraining=FALSE)
{
    DLA_SetOpponentNumber(oPC, nIndex);
    DLA_SetOpponentName  (oPC, DLA_FindOpponentName(oPC, nIndex, bTraining));
    DLA_SetOpponentResref(oPC, DLA_FindOpponentResref(oPC, nIndex, bTraining));
}

int DLA_GetIsTourney(object oPC, int nTourney)
{
    int bT2Started = DLA_GetStateIsSet(DLA_GetJoustState(oPC), DLA_JOUSTSTATE_T2_STARTED);
    if (nTourney==2 && bT2Started)
        return TRUE;
    int bT1Started = DLA_GetStateIsSet(DLA_GetJoustState(oPC), DLA_JOUSTSTATE_T1_STARTED);
    if (nTourney==1 && !bT2Started && bT1Started)
        return TRUE;
    return FALSE;
}

int DLA_GetTourneyChamp(object oPC, int nTourney)
{
    return (nTourney & GetLocalInt(oPC, DLA_TOURNEY_CHAMP));
}

void DLA_SetTourneyChamp(object oPC, int nTourney)
{
    int nState = 0;
    switch (nTourney)
    {
        case 1: nState = DLA_JOUSTSTATE_T1_CHAMP; break;
        case 2: nState = DLA_JOUSTSTATE_T2_CHAMP; break;
    }
    if (nState > 0) DLA_SetJoustState(oPC, nState);
}

void DLA_JoustMatchEnd(object oPC)
{
    int nPCScore        = DLA_GetScoreOnMatch(oPC, FALSE);
    int nNPCScore       = DLA_GetScoreOnMatch(oPC, TRUE );
    int nRound          = DLA_GetTiltRounds(oPC);
    int bTraining       = DLA_GetIsOnTraining(oPC);
    int nJoustState     = DLA_GetJoustState(oPC);
    int nNewJoustState  = 0;
    int nTourney        = DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_STARTED) ? 2:1;
    int bT1Done         = FALSE;
    int bT2Done         = FALSE;
    int bCleanAll       = FALSE;
    // Tokens used in Thidor's conversation
    SetCustomToken(2006, IntToString(nPCScore));
    SetCustomToken(2007, IntToString(nNPCScore));
    SetCustomToken(2008, IntToString(nRound));
    SetCustomToken(2009, DLA_GetOpponentName(oPC));

    DLA_JoustDebug("<DLA_JoustMatchEnd>");
    DLA_JoustDebug("   bTraining: " + IntToString(bTraining));
    if (!bTraining)
    {// The match was a tournament match
        DLA_JoustDebug("   Joust clean up tournament match");
        int bWin = (nPCScore > nNPCScore);
        DLA_SetTourneyMatches(oPC, DLA_GetTourneyMatches(oPC)+1);
        DLA_JoustDebug("   Tournament " + IntToString(nTourney));
        DLA_JoustDebug("   Match " + IntToString(DLA_GetTourneyMatches(oPC)));
        if (bWin)
        {// The PC won a tournament match
            DLA_JoustDebug("   Tournament match resulted in a win");
            // Get tourney wins BEFORE this match
            int nWins = DLA_GetTourneyWins(oPC);
            // Set new tourney wins data
            DLA_SetTourneyWins(oPC, nWins+1);
            // Current winning state
            int nWinState = nTourney==2 ? DLA_JOUSTSTATE_T2_1 : DLA_JOUSTSTATE_T1_1;
            // New winning state
            nWinState = nWinState << nWins;
            // Set the new joust state
            DLA_SetJoustState(oPC, nWinState);
            // set champion status if needed and clear variables
            if (nWinState == DLA_JOUSTSTATE_T1_4)
            {// Tourney 1 champion
                DLA_JoustDebug("   Setting PC as champion for tourney 1");
                bCleanAll = TRUE;
                bT1Done = TRUE;
                DLA_SetTourneyChamp(oPC, 1);
            }// Tourney 1 champion
            //***uncommented BGP 15th Aug********
            else if (nWinState == DLA_JOUSTSTATE_T2_4)
            //***commented BGP 15th Aug********
            //else if (DLA_GetIsTourney(oPC, 2))
            {// Tourney 2 champion
                DLA_JoustDebug("   Setting PC as champion for tourney 2");
                bCleanAll = TRUE;
                bT2Done = TRUE;
                DLA_SetTourneyChamp(oPC, 2);
            }// Tourney 2 champion
            // New joust state
        }// The PC won a tournament match
        else
        {// The PC lost a tournament match
            DLA_JoustDebug("   Tourney match resulted in a loss!");
            int bT2Lost = DLA_GetStateIsSet(nJoustState, DLA_JOUSTSTATE_T2_STARTED);
            if (bT2Lost)
            {// Lost 2nd tourney
                DLA_JoustDebug("   Setting tourney 2 as lost");
                DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T2_LOST);
                DLA_SetTourneyMatches(oPC, 4); // we want this to not think it needs another match
                bT2Done = TRUE;
                bCleanAll = TRUE;
            }// Lost 2nd tourney
            else
            {// Lost 1st tourney
                DLA_JoustDebug("   Setting tourney 1 as lost");
                DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_LOST);
                bT1Done = TRUE;
                bCleanAll = TRUE;
            }// Lost 1st tourney
        }// The PC lost a tournament match
    }// The match was a tournament match

    if (bT1Done)
    {// Tournament 1 is over
        DLA_JoustDebug("   Setting tourney 1 as done");
        DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_DONE);
    }// Tournament 1 is over
    if (bT2Done)
    {// Tournament 2 is over
        DLA_JoustDebug("   Setting tourney 2 as done");
        DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T2_DONE);
    }// Tournament 2 is over

    // Cleanup
    DLA_SetIsOnTraining(oPC, FALSE); // Removes training variable as well
    DLA_SetScoreOnMatch(oPC, FALSE, 0);
    DLA_SetScoreOnMatch(oPC, TRUE , 0);
    DLA_RemoveStunCondition(oPC);
    DLA_SetTiltRounds(oPC, 0);
    if (bCleanAll)
    {// Clear all tournament data
        DLA_JoustDebug("   Clearing tourney data");
        DLA_SetTourneyMatches(oPC, 0);
        DLA_SetTourneyWins(oPC, 0);
    }// Clear all tournament data

    DLA_JoustDebug("   Joust state (before): " + IntToHexString(nJoustState));
    DLA_JoustDebug("   Joust state (after) : " + IntToHexString(DLA_GetJoustState(oPC)));
    DLA_JoustDebug("   Tourney matches are set to  " + IntToString(DLA_GetTourneyMatches(oPC)));
    DLA_JoustDebug("   Tourney wins are set to " + IntToString(DLA_GetTourneyWins(oPC)));
    // PLOT INTEGRATION
    // End the Cutscene
    // DO NOT End the cutscene if tourney 2 is completed.
    if (!bT2Done) SetCutsceneMode(oPC, FALSE);
    DLA_JoustDebug("-- DLA_JoustMatchEnd -------------");
}

//Gale 17 Jan 2006:
//Advances the number representing the next opponent of oPC by one.
void DLA_SetNextOpponent(object oPC, int bTraining=FALSE)
{
  //Gale 22 Jan 2006:
  //Changed to use the new SetOpponentNumber, to add versatility to the list of
  //opponents
  int nIndex = DLA_GetOpponentNumber(oPC)+1;
  if (nIndex > 8) nIndex = 1;
  DLA_SetJoustOpponent(oPC, nIndex , bTraining);
}

int DLA_GetIsOnTraining(object oPC)
{
    int bTraining = GetLocalInt(oPC, DLA_VAR_JOUST_TRAINING);
    DLA_JoustDebug("Getting joust training variable of " + IntToString(bTraining));
    return bTraining;
}

void DLA_SetIsOnTraining(object oPC, int bOnTraining=TRUE)
{
    if (bOnTraining)
    {
        SetLocalInt(oPC, DLA_VAR_JOUST_TRAINING, TRUE);
    }
    else
    {
        DeleteLocalInt(oPC, DLA_VAR_JOUST_TRAINING);
    }
    DLA_JoustDebug("Joust training variable has been set to " + IntToString(bOnTraining));
}

int DLA_GetStateIsSet(int nMaster, int nCheck)
{
    return ((nMaster & nCheck) > 0);
}

void DLA_SetJoustState(object oPC, int nState)
{
    int nJoustState = DLA_GetJoustState(oPC) | nState;
    SetLocalInt(oPC, DLA_VAR_JOUST_STATE, nJoustState);
}

int DLA_GetJoustState(object oPC)
{
    return GetLocalInt(oPC, DLA_VAR_JOUST_STATE);
}

void DLA_RemoveJoustState(object oPC, int nState)
{
    int nJoustState = DLA_GetJoustState(oPC);
    if (DLA_GetStateIsSet(nJoustState,  nState))
        nJoustState &= ~nState;
    SetLocalInt(oPC, DLA_VAR_JOUST_STATE, nJoustState);
}

void DLA_ChangeToJoustColors(object oPC)
{
    //Syrsnein 10 May 2006: Give the player a default jousting color if they
    // have not selected one.
    int nColors = DLA_JoustGetColors(oPC);
    if (DLA_JoustGetColors(oPC) == 0)
    {
        nColors = DLA_HORSEJ_TAIL_WHITE;
        DLA_JoustSetColors(oPC, nColors);
    }

    //Change to joust colors
    SetLocalInt(oPC, "dla_myhorse_tail", GetCreatureTailType(oPC));
    SetCreatureTailType(nColors, oPC);
}

void DLA_RemoveJoustTail(object oPC)
{
    DLA_JoustDebug("   Removing PC joust tail.");
    int nColors = DLA_JoustGetColors(oPC);
    if (nColors > 0)
    {// Joust colors exist
        int nTail = GetLocalInt(oPC, "dla_myhorse_tail");
        SetCreatureTailType(nTail, oPC);
    }// Joust colors exist
    if (GetCreatureTailType(oPC)==nColors)
    {
        DelayCommand(0.1, DLA_RemoveJoustTail(oPC));
    }
    else
    {
        DLA_JoustDebug("   PC joust tail removed.");
    }
}

void DLA_JoustReturnToAgent(object oPC)
{
    location lWaypoint;
    // Get the proper person to talk to after the match
    if (DLA_GetIsOnTraining(oPC))
    {// Mareth
        lWaypoint = GetLocation(GetWaypointByTag("WP_JOUSTING_MARETH"));
    }// Mareth
    else
    {// Thiodor
        lWaypoint = GetLocation(GetWaypointByTag("DLA_JOUSTING_AREA_WPT"));
    }// Thiodor

    DLA_JoustDebug("   Jumping to location: " + LocationToString(lWaypoint));
    AssignCommand(oPC, ActionJumpToLocation(lWaypoint));;
}

int DLA_JoustGetIsEquipped(object oPC)
{
    int bArmor  = FALSE;
    int bHelmet = FALSE;
    int bShield = FALSE;

    object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    if (GetIsObjectValid(oArmor))
    {
        if (DLA_GetBaseArmorValue(oArmor)>5)
        {
            bArmor = TRUE;
        }
    }
    object oHelmet = GetLocalObject(oPC, DLA_VAR_BORROWED_HELMET);
    if (GetItemPossessor(oHelmet)!=oPC)
    {
        oHelmet = DLA_GetFirstHelmetAvailable(oPC);
        if (GetIsObjectValid(oHelmet))
        {
            bHelmet = TRUE;
        }
    }
    else
    {
        bHelmet = TRUE;
    }

    object oShield = GetLocalObject(oPC, DLA_VAR_BORROWED_SHIELD);
    if (GetItemPossessor(oShield)!=oPC)
    {
        oShield = DLA_GetFirstShieldAvailable(oPC);
        if (GetIsObjectValid(oShield))
        {
            if (GetBaseItemType(oShield) == BASE_ITEM_LARGESHIELD)
            {
                bShield = TRUE;
            }
        }
    }
    else
    {
        bShield = TRUE;
    }
    if (bArmor && bHelmet && bShield)
    {
        SetLocalObject(oPC, DLA_VAR_JOUST_ARMOR,  oArmor);
        SetLocalObject(oPC, DLA_VAR_JOUST_HELMET, oHelmet);
        SetLocalObject(oPC, DLA_VAR_JOUST_SHIELD, oShield);
        return TRUE;
    }

    return FALSE;
}

///////////////////////////////////
// Lance Rack Cutscene           //
///////////////////////////////////

// Implement Cutscene Functions ////////////////////////////////////////////////

//Syrsnein 9 Feb 2006: Brings in a cleric to heal fallen jousters.  There is no
// actual healing at this time.  Just an animation of the cleric kneeling by
// the jouster and a white glow on the jouster.
void DLA_HealJouster(object oJouster)
{
    float fCueTime = 0.0;
    DLA_JoustDebug("<dla_i0_joust> Sending in the Cleric for " + GetName(oJouster));

    object oWaypoint;
    if (GetIsPC(oJouster))
    {// spawn point for PC
        oWaypoint = GetObjectByTag("DLA_JOUST_CLERIC_PC");
    }// spawn point for PC
    else
    {// spawn point for OP
        oWaypoint = GetObjectByTag("DLA_JOUST_CLERIC_OP");
    }// spawn point for OP

    // Spawn cleric
    object oCleric = CreateObject(OBJECT_TYPE_CREATURE, "dla_npc_healer",
                                  GetLocation(oWaypoint));
    DLA_JoustDebug("<dla_i0_joust> Cleric " + GetTag(oCleric) + " created");

    // All hail the mighty cleric
    float fDir = GetFacing(oJouster);
    float fAngle = GetHalfRightDirection(fDir);
    location lLoc = GenerateNewLocationFromLocation(GenerateNewLocation(oJouster, 2.3, fDir, fDir),
        1.3, fAngle, fDir);
    AssignCommand(oCleric, ActionMoveToLocation(lLoc, TRUE));
    DelayCommand(fCueTime+=3.0, AssignCommand(oCleric, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 20.0)));
    effect eVFX = EffectVisualEffect(VFX_DUR_GLOW_WHITE);
    DelayCommand(fCueTime+=1.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oJouster, 9.0));
    DelayCommand(fCueTime+=5.0, DLA_DestroyObject(oCleric));
}

void DLA_BreakLance(object oLance)
{
    itemproperty ipTip = GetFirstItemProperty(oLance);
    if (GetIsItemPropertyValid(ipTip)) RemoveItemProperty(oLance, ipTip);
}

void DLA_UnhelmJouster(object oPC)
{
    object oBox    = GetObjectByTag(DLA_TAG_JOUST_HELMET_BOX);
    object oHelmet = GetLocalObject(oPC, DLA_VAR_JOUST_HELMET);
    AssignCommand(oBox, ActionTakeItem(oHelmet, oPC));
    DelayCommand(5.0, AssignCommand(oBox, ActionGiveItem(oHelmet, oPC)));
}

void DLA_ResetLance(object oLance)
{
    object oOwner = GetItemPossessor(oLance);
    int nLance = DLA_JoustGetLanceColor(oOwner);
    int nVFX = ITEM_VISUAL_SONIC;  // Default Lance is Red = Sonic
    switch (nLance)
    {
        case DLA_LANCE_YELLOW  : nVFX = ITEM_VISUAL_COLD;       break;
        case DLA_LANCE_BLUE    : nVFX = ITEM_VISUAL_ELECTRICAL; break;
        case DLA_LANCE_BLACK   : nVFX = ITEM_VISUAL_ACID;       break;
        case DLA_LANCE_BARE    : nVFX = ITEM_VISUAL_SONIC;      break;
        case DLA_LANCE_BK      : nVFX = ITEM_VISUAL_EVIL;       break;
    }
    itemproperty ipLance = ItemPropertyVisualEffect(nVFX);
    AddItemProperty(DURATION_TYPE_PERMANENT, ipLance, oLance);

/*    string sResRef = GetResRef(oLance);
    DLA_DestroyObject(oLance);
    oLance = CreateItemOnObject(sResRef, oOwner);
    SetLocalObject(oOwner, DLA_VAR_JOUST_LANCE, oLance);
    //force equip lance
    AssignCommand(oOwner, DLA_ForceEquip(oOwner,oLance, INVENTORY_SLOT_RIGHTHAND));
*/
}
/*
int DLA_GetRackHasLance(object oLanceRack, int nLance)
{
    string sLance = IntToString(nLance);
    return !GetLocalInt(oLanceRack, "dla_lance_used"+sLance);
}

void DLA_ResetLanceRack(object oLanceRack)
{
    int i;
    for (i=1;i<5;i++)
    {
        DeleteLocalInt(oLanceRack, "dla_lance_used"+IntToString(i));
    }
    DeleteLocalInt(oLanceRack, "dla_lances_used");
    DelayCommand(10.0, AssignCommand(oLanceRack, ActionPlayAnimation(ANIMATION_LANCERACK_FULL)));
}

void DLA_CheckLanceRacks()
{
    object oLanceRack = GetNearestObjectByTag("dla_lancerack");
//    if (GetLocalInt(oLanceRack, "dla_lances_used")>=4)
        DLA_ResetLanceRack(oLanceRack);
/*
    oLanceRack = GetNearestObjectByTag("dla_lancerack2");
    if (GetLocalInt(oLanceRack, "dla_lances_used")>=0)
        DLA_ResetLanceRack(oLanceRack);
*-/
}

void DLA_JoustSetupJousters(object oPC, object oOP)
{
    float fCueTime = 0.0;

    DLA_JoustDebug("Player Setup Name: " + GetName(oPC));
    DLA_JoustDebug("Opp Setup Name: " + GetName(oOP));

    //Setup the Jousters
    if (DLA_GetOpponentNumber(oPC)>8)
        DelayCommand(fCueTime+=0.1, DLA_ForceEquip(oOP,GetLocalObject(oOP, DLA_VAR_JOUST_SHIELD), INVENTORY_SLOT_LEFTHAND));
    DelayCommand(fCueTime+=0.1, DLA_EquipJoustingItems(oPC, DLA_EQUIP_SHIELD));
    DelayCommand(fCueTime+=0.2, DLA_EquipJoustingItems(oPC, DLA_EQUIP_HELM));
    object oHelm = GetLocalObject(oOP, "dla_joust_helmet");
    DelayCommand(fCueTime+=0.1, DLA_ForceEquip(oOP,GetLocalObject(oOP, DLA_VAR_JOUST_HELMET), INVENTORY_SLOT_HEAD));

    //jumps pc to joust starting point

    DelayCommand(fCueTime+=0.2, AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_PC_WPT1")))));
    DelayCommand(fCueTime+=0.01, AssignCommand(oOP, ActionJumpToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_OP_WPT1")))));
//    DelayCommand(2.0, FadeFromBlack(oPC));
}

void DLA_RemoveFromLanceRack(object oLanceRack, int nLance)
{
    int nAnim = 0;
    switch(nLance)
    {
        case DLA_LANCE_YELLOW: nAnim = ANIMATION_LANCERACK_REM_YELLOW; break;
        case DLA_LANCE_BLUE  : nAnim = ANIMATION_LANCERACK_REM_BLUE;   break;
        case DLA_LANCE_BLACK : nAnim = ANIMATION_LANCERACK_REM_BLACK;  break;
        case DLA_LANCE_BARE  : nAnim = ANIMATION_LANCERACK_REM_BARE;   break;
    }
    SetLocalInt(oLanceRack, "dla_lances_used", GetLocalInt(oLanceRack, "dla_lances_used")+1);
    SetLocalInt(oLanceRack, "dla_lance_used"+IntToString(nLance), TRUE);
    AssignCommand(oLanceRack, ActionPlayAnimation(nAnim));
}

void DLA_EquipLanceFromRack(object oPC, int nLance)
{
    object oLance = CreateItemOnObject(DLA_TAG_JOUST_LANCE+IntToString(nLance), oPC);
    SetLocalObject(oPC, DLA_VAR_JOUST_LANCE, oLance);
    //force equip lance
    AssignCommand(oPC, DLA_ForceEquip(oPC,oLance, INVENTORY_SLOT_RIGHTHAND));
}

void DLA_SelectLance(object oPC, int nLance)
{
// Yellow = 1 = Activate
// Blue   = 2 = Open
// Black  = 3 = Close
// Bare   = 4 = DeActivate
    float fCueTime = 0.0;
    object oLanceRack = GetObjectByTag(DLA_TAG_JOUST_LANCERACK);
    if (!GetIsPC(oPC))
    {
        int nLanceOpp = 1+Random(4);
        if (nLance==DLA_LANCE_YELLOW && DLA_GetRackHasLance(oLanceRack, DLA_LANCE_BARE))
            nLanceOpp = DLA_LANCE_BARE;
        else if (nLance==DLA_LANCE_BLUE && DLA_GetRackHasLance(oLanceRack, DLA_LANCE_BLACK))
            nLanceOpp = DLA_LANCE_BLACK;
        else while (!DLA_GetRackHasLance(oLanceRack, nLanceOpp))
        {
            nLanceOpp = 1+Random(4);
        }
        nLance = nLanceOpp;
    }

    DelayCommand(fCueTime+=0.2, AssignCommand(oPC, ActionMoveToObject(oLanceRack)));
    DelayCommand(fCueTime+=0.8, AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0, 1.0)));
    DelayCommand(fCueTime+=0.2, DLA_RemoveFromLanceRack(oLanceRack, nLance));
    DelayCommand(fCueTime+=0.01, DLA_EquipLanceFromRack(oPC, nLance));
}

void DLA_EndCutsceneLanceRack(object oPC)
{
    float fCueTime = 0.0;
    object oOP = GetLocalObject(oPC, DLA_VAR_JOUST_OPPONENT);
    DLA_JoustDebug("<DLA_EndCutsceneLanceRack> Start");
    DelayCommand(fCueTime+=0.3, DLA_ChangeToJoustingPheno(oPC));
    DelayCommand(fCueTime+=0.01, DLA_ChangeToJoustingPheno(oOP));
    DelayCommand(fCueTime+=0.1, AssignCommand(oPC, ActionMoveToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_PC_ENTER")))));
//    if (DLA_GetOpponentNumber(oPC) < DLA_JOUST_OPPONENT_JONAS)
    DelayCommand(fCueTime+=0.01, AssignCommand(oOP, ActionMoveToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_OP_ENTER")))));
    DelayCommand(fCueTime+=7.0, FadeToBlack(oPC,FADE_SPEED_FAST));
    DelayCommand(fCueTime+=1.0, DLA_JoustSetupJousters(oPC, oOP));
    DelayCommand(fCueTime+=5.0, DLA_CheckLanceRacks());
}

void DLA_PlayLanceRackCutscene(object oPC, int nLance)
{
    float fCueTime = 0.0;
    object oOP = GetLocalObject(oPC, DLA_VAR_JOUST_OPPONENT);

    DLA_JoustSetLanceColor(oPC, nLance);
    // Have oPC get the lance from the rack
    DelayCommand(fCueTime+=0.1, DLA_SelectLance(oPC, nLance));
    // Get the lance for the opponent unless the opponent is Jonas
    if (DLA_GetOpponentNumber(oPC) < DLA_JOUST_OPPONENT_JONAS)
    {
        DelayCommand(fCueTime+=1.9, DLA_SelectLance(oOP, nLance));
    }
    DelayCommand(fCueTime+=3.0, DLA_EndCutsceneLanceRack(oPC));
}

void DLA_CutsceneLanceRack(object oPC)
{
    float fCueTime = 0.0;
    if (!GetCutsceneMode(oPC)) SetCutsceneMode(oPC);
    AssignCommand(oPC, ClearAllActions(TRUE));
    DelayCommand(fCueTime+=0.01, AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetWaypointByTag("DLA_WRACK_PC")))));
    DelayCommand(fCueTime+=1.0, FadeFromBlack(oPC, FADE_SPEED_FAST));
    if (DLA_JoustGetLanceColor(oPC) > 0)
    {
        DelayCommand(fCueTime+=1.2, DLA_PlayLanceRackCutscene(oPC, DLA_JoustGetLanceColor(oPC)));
    }
    else
    {
        object oInvis = GetObjectByTag("lance_rackinv");
        DelayCommand(fCueTime+=1.2, AssignCommand(oPC, ActionStartConversation(oInvis, "dla_lancech", TRUE, FALSE)));
    }
}
*/
//Jonas Stuff
object DLA_JoustCreateJonas(object oPC)
{
    string sResref = DLA_GetOpponentResref(oPC);
//    object oWP = GetWaypointByTag("DLA_JONAS");
    object oWP = GetWaypointByTag("DLA_WRACK_OP");
    object oJonas = CreateObject(OBJECT_TYPE_CREATURE, sResref, GetLocation(oWP), FALSE, "Black_Knight");
    DLA_Mount(oJonas, OBJECT_INVALID, FALSE, DLA_HORSEJ_TAIL_BLACK);

    return oJonas;
}

void DLA_ForceEquip(object oWearer,object oItem,int nSlot)
{ // PURPOSE: To make sure equipping occurs
  // Deva Winblood    6/30/2006   - NWN engine does not always equip when
  // assume it does.   This is to make sure it happens.

    if (GetIsObjectValid(oItem)&&GetItemInSlot(nSlot,oWearer)!=oItem&&GetItemPossessor(oItem)==oWearer)
    { // force equip

        AssignCommand(oWearer,ActionEquipItem(oItem,nSlot));
        DelayCommand(0.3,DLA_ForceEquip(oWearer,oItem,nSlot));

    } // force equip

} // DLA_ForceEquip()


void DLA_ForceUnequip2(object oWearer,object oItem,int nSlot)
{ // PURPOSE: To make sure unequipping occurs
  // Deva Winblood    6/30/2006   - NWN engine does not always unequip when
  // assume it does.   This is to make sure it happens.

    if (GetIsObjectValid(oItem) && GetItemInSlot(nSlot,oWearer)==oItem)
    { // force equip

        AssignCommand(oWearer,ActionUnequipItem(oItem));
        DelayCommand(0.3,DLA_ForceUnequip2(oWearer,oItem,nSlot));

    } // force equip

} // DLA_ForceUnequip2()

void DLA_DestroyObject(object oObject)
{// Purpose: To ensure all child objects of oObject are destroyed when oObject
 //            is destroyed
 // Deva Winblood, 6/30/2006, Recall this funtion on oObject after a short delay
 //            to ensure the object is destroyed rather than assuming it is.

    // No object, return.
    if (!GetIsObjectValid(oObject)) return;

    // remove the plot flag so the object can be destroyed
    SetPlotFlag(oObject, FALSE);

    // Destroy the object
    DLA_JoustDebug("   Destroying " + GetTag(oObject));
    DestroyObject(oObject);

    // Make sure the object is destroyed
    if (GetIsObjectValid(oObject))
    {// oObject was not destroyed
        DelayCommand(0.1,DLA_DestroyObject(oObject));
    }// oObject was not destroyed
}

// Uncomment only to test compile
// void main() {}
