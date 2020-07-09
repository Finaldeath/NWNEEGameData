////////////////////////////////////////////////////////////////////////////////
// dla_jt_cutsc_end
//
// DLA Wyvern Crown of Cormyr
////////////////////////////////////////////////////////////////////////////////
/*
   End the jousting cutscene by returning us to the npc that gave us the joust
   match.
*/
////////////////////////////////////////////////////////////////////////////////
// Created By: Dave Musser (Syrsnein)
// Created On: 12 July 2006
////////////////////////////////////////////////////////////////////////////////
/*
 Change History
 Date
 year/mm/dd | Author     | Change
 -----------+------------+------------------------------------------------------
 */

#include "dla_i0_joust"
#include "dla_i0_feats"
#include "dla_i0_cutscene"

void DLA_JoustCutsceneScoreReset(object oPC, object oOP);

// 11 June 2006, Sysrnein, Removed deprecated code from this function
void main()
{
    object oPC = OBJECT_SELF;
    object oOP = GetLocalObject(oPC, DLA_VAR_JOUST_OPPONENT);
    // set variables
    int nWins         = DLA_GetTourneyWins(oPC);
    int nMatches      = DLA_GetTourneyMatches(oPC);
    int bTraining     = DLA_GetIsOnTraining(oPC);
    int iPCScoreMatch = DLA_GetScoreOnMatch(oPC, FALSE);
    int iOPScoreMatch = DLA_GetScoreOnMatch(oPC, TRUE);
//    object oHurim     = GetObjectByTag("HurimJoust1");
    object oAgent     = bTraining?GetObjectByTag("Mareth"):GetObjectByTag("HurimJoust1");
//    location lWaypoint;
    float fCueTime    = 0.0;
    // for loop index
    int i;

    if (!GetCutsceneMode(oPC))
        SetCutsceneMode(oPC);

    // Stop battle music and start normal music
    DLA_JoustDebug("   Changing from battle to normal music.");
    MusicBattleStop(GetArea(oPC));
    MusicBackgroundPlay(GetArea(oPC));
    DLA_JoustDebug("   Music changed");

    // Clear all actions
    AssignCommand(oPC, ClearAllActions(TRUE));

    // Clear the score flags
    DLA_JoustDebug("   Clearing score flags.");
    DLA_JoustCutsceneScoreReset(oPC, oOP);
    DLA_JoustDebug("   Score flags Cleared.");

    // Clean up some PC local vars
    DLA_JoustDebug("   PC variable cleanup.");
    DeleteLocalObject(oPC, DLA_VAR_JOUST_OPPONENT);
    DeleteLocalInt(oPC, DLA_VAR_JOUST_ON);
    DeleteLocalInt(oPC, DLA_OUTCOME_MASTER_VAR);
    DeleteLocalInt(oPC, DLA_VAR_JOUST_RETURN);

    // Clear PC Joust variables
    DLA_DeleteAimPos(oPC);
    DLA_DeleteDefPos(oPC);

    /* Get the proper person to talk to after the match
    if (bTraining)
    {// Mareth
        lWaypoint = GetLocation(GetWaypointByTag("WP_JOUSTING_MARETH"));
    }// Mareth
    else
    {// Thiodor
        lWaypoint = GetLocation(GetWaypointByTag("DLA_JOUSTING_AREA_WPT"));
    }// Thiodor
    */
    // Destroy the opponent
    DLA_JoustDebug("   Destroying opponent.");
    AssignCommand(oOP, SetIsDestroyable(TRUE));
    DLA_DestroyObject(oOP);
    DLA_JoustDebug("   Opponent destroyed.");

    // Remove joust tail
    // Syrsnein 10 May 2006: The player should always have joust colors .. but
    // Remove the Lance
    DLA_JoustRemoveLance(oPC);
    // Remove joust tail
    DLA_RemoveJoustTail(oPC);
    // Jump to the person we wish to talk to
    DelayCommand(fCueTime+=0.1, DLA_JoustReturnToAgent(oPC));
    // Gather our henchmen and horses
    DelayCommand(fCueTime+=0.1, DLA_SetAssociatesFollow(oPC));
    // Change back to mounted phenotype
    DelayCommand(fCueTime+=0.1, DLA_ChangeToMountedPheno(oPC));
    // Dismount
    DelayCommand(fCueTime+=0.3, DLA_Dismount(oPC, FALSE));
    // Fade in
    DelayCommand(fCueTime+=1.2, FadeFromBlack(oPC));
    // Talk to someone
    DelayCommand(fCueTime+=1.5, AssignCommand(oPC, ActionStartConversation(oAgent)));
}


void DLA_JoustCutsceneScoreReset(object oPC, object oOP)
{
    // for loop index
    int i;
    int nPCFlags = GetLocalInt(oPC, "dla_flag_counter");
    int nOPFlags = GetLocalInt(oOP, "dla_flag_counter");
    for (i=0;i<nPCFlags;i++)
    {// Destroy player scoring flags
        string sTag = "JOUSTPCFLAG" + IntToString(i);
        DLA_DestroyObject(GetObjectByTag(sTag));
    }// Destroy player scoring flags
    for (i=0;i<nOPFlags;i++)
    {// Destroy opponent scoring flags
        string sTag = "JOUSTOPFLAG" + IntToString(i);
        DLA_DestroyObject(GetObjectByTag(sTag));
    }// Destroy opponent scoring flags
    // Clear the players flag counter
    DeleteLocalInt(oPC, "dla_flag_counter");
}
