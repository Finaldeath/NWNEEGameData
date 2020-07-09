////////////////////////////////////////////////////////////////////////////////
// dla_jt_joustcont
//
// DLA Wyvern Crown of Cormyr
////////////////////////////////////////////////////////////////////////////////
/*
   Plays the proper animations based on the outcome previously calculated
   also handles the end of the joust cutscene
*/
////////////////////////////////////////////////////////////////////////////////
// Created By: Takamura
// Created On: Oct 11, 2005
////////////////////////////////////////////////////////////////////////////////
/*
 Change History
 Date
 year/mm/dd | Author     | Change
 -----------+------------+------------------------------------------------------
 2006/01/16  Gale        : Moved outcome calculations to another script.
 2006/02/07  Gale        : Added wrapper function, DLA_EndJoustCutscene, to end
                            the jousting cutscene.
 2006/02/11  Takamura    : Added flag spawn function DLA_FlagSpawn.
 2006/02/25  Syrsnien    : Rewrote DLA_FlagSpawn.
                           Restructured/Modified DLA_EndJoustCutscene.
                           Moved ScoreKeep function to dla_cut_joust.nss
 2006/05/10  Syrsnein    : Added support code for joust color removal at the end
                            of the match.
 2006/05/17  Syrsnein    : Cutscene mode for PC moved to conversation dialogue
                            script when  match is completed.
                           Moved some code from from main and EndJoustCutscene
                            into a new function DLA_ScoreJoustCutscene.
 2006/05/25  Syrsnein    : Removed camera and sound code that was not needed.
 2006/05/28  Syrsnein    : Changed PlaySound calls and timing.
                           Moved some code from DLA_EndJoustCutscene to a new
                            function DLA_JoustResetTilt.
                           Added joust opponent remarks and function.
 2006/06/11  Syrsnein    : Moved some code from DLA_EndJoustCutscene to a new
                            function DLA_JoustEndTilt.
                           Removed some deprecated code from DLA_EndJoustCutscene.
 2006/06/13  Syrsnein    : Replaced DLA_GetOutcome() calls with DLA_GetStateIsSet().
 2006/06/14  Syrsnein    : Renamed DLA_EndJoustCutscene to DLA_JoustCutsceneEnd.
                           Renamed DLA_ScoreJoustCutscene to DLA_JoustCutsceneScoring.
                           Renamed DLA_FlagSpawn to DLA_JoustCutsceneScoreDisplay.
                           Renamed DLA_JoustRemarks to DLA_JoustCutsceneRemarks.
                           Renamed DLA_JoustEndTilt to DLA_JoustCutsceneTiltEnd.
                           Renamed DLA_JoustResetTilt to DLA_JoustCutsceneTiltReset.
 2006/06/15  Syrsnein    : Removed old sound calls and added new sound calls
                            using the new joust crowd sounds.
 2006/06/19  Syrsnein    : Removed setting of stun effects since we seem to be
                            having problems removing them when we want to.
 2006/06/25  Syrsnein    : Modified script to use delayed commands in some cases.
 2006/06/26  Syrsnein    : Moved flag destruction code into it's own function
                            DLA_JoustCutsceneScoreReset()
 2006/06/30  Syrsnein    : General fixing. Re-organized functions.
 2006/07/07  Syrsnein    : General fixing, re-organizing and timing changes.
 2006/07/12  Syrsnein    : Moved all functions into seperate scripts except for
                            DLA_CutsceneJoustRemarks()
 2006/07/23  Syrsnein    : Removed removal of helmet on head hits due to
                            limitations, of the game engine, to update appearances
                            properly.
 */

#include "dla_i0_joust"
//include "dla_i0_feats"
//include "x0_i0_position"
//include "dla_i0_cutscene"

// moved to dla_i0_const
// const string DLA_VAR_JOUST_RETURN = "dla_var_joust_return";

//Syrsnein, 17 May 2006
void DLA_JoustCutsceneScoring(object oPC, object oOP);
void DLA_JoustCutsceneRemarks(object oPC, object oOP);
void DLA_JoustCutsceneTiltEnd(object oPC, object oOP);
void DLA_JoustCutsceneTiltReset(object oPC, object oOP);
//Gale 7 Feb 2006: Wraper function to end the jousting cutscene
void DLA_JoustCutsceneEnd(object oPC, object oOP);

//Takamura 11 Feb 2006: Flag spawn
//Spawns appropriate flags for points accumulated thus far in round.
//Syrsnein: Display no more than 3 points, for either jouster, while the match
//  is tied with 3 or more points.  Display 4 flags for the tie breaking winner.
void DLA_JoustCutsceneScoreDisplay(object oPC, object oOP);
void DLA_JoustCutsceneScoreReset(object oPC, object oOP);

/* Syrsnein : 23 July 2006 - no longer needed since we don't remove helmets
void privateJoustCheckHelm(object oCreature)
{
    if (!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_HEAD, oCreature)))
    {// Re-equip the helmet
        object oHelm = GetLocalObject(oCreature, DLA_VAR_JOUST_HELMET);
        AssignCommand(oCreature, DLA_ForceEquip(oCreature, oHelm, INVENTORY_SLOT_HEAD));
    }// Re-equip the opponents helmet
}
 */

void main()
{
    object oPC = GetEnteringObject();

    // Cutscene timing cue
    float fCueTime = 0.0;
    if (!GetLocalInt(oPC, DLA_VAR_JOUST_ON))
    {// player is not ready to tilt
        if (GetLocalInt(oPC, DLA_VAR_JOUST_RETURN))
        {// player is returning from a tilt
            DLA_JoustCutsceneRemarks(oPC, GetLocalObject(oPC, DLA_VAR_JOUST_OPPONENT));
            return;
        }// player is returning from a tilt.  If we entered this, we should return.
        return;
    }// player is not ready to tilt.  If we entered this, we should return.

    if (!GetCutsceneMode(oPC))
        SetCutsceneMode(oPC);

    // Get the opponent
    object oOP = GetLocalObject(oPC, DLA_VAR_JOUST_OPPONENT);

    // Get the outcome results for both jousters
    int nOutcomePC = DLA_GetOutcomeVar(oPC);
    int nOutcomeOP = DLA_GetOutcomeVar(oOP);

    // Play sounds as the jousters clash
    SoundObjectPlay(GetObjectByTag("dla_snd_joust_champ"));

    //Gale 16 Jan 2006: Moved outcome calculation to when the PC chooses their
    //  aim/defensive strategy to avoid slowdown during animation.

    // Break the lances if the hit warrants it.
    if (DLA_GetStateIsSet(nOutcomePC, DLA_OUTCOME_BREAKLANCE) ||
        DLA_GetStateIsSet(nOutcomePC, DLA_OUTCOME_UNHORSED)   ||
        DLA_GetStateIsSet(nOutcomePC, DLA_OUTCOME_HELMKNOCKEDOFF))
    {// Break the opponents lance
        DelayCommand(fCueTime+=0.04, DLA_BreakLance(GetLocalObject(oOP, DLA_VAR_JOUST_LANCE)));
    }// Break the opponents lance
    if (DLA_GetStateIsSet(nOutcomeOP, DLA_OUTCOME_BREAKLANCE) ||
        DLA_GetStateIsSet(nOutcomeOP, DLA_OUTCOME_UNHORSED)   ||
        DLA_GetStateIsSet(nOutcomeOP, DLA_OUTCOME_HELMKNOCKEDOFF))
    {// Break the players lance
        DelayCommand(fCueTime+=0.01, DLA_BreakLance(GetLocalObject(oPC, DLA_VAR_JOUST_LANCE)));
    }// Break the players lance

/* Syrsnein: 23 July 2006 - No longer needed since we don't remove helmets anymore.
    // Knock off helmets where the hit warrants it.
    if (DLA_GetStateIsSet(nOutcomePC, DLA_OUTCOME_HELMKNOCKEDOFF))
    {// Remove the Players helmet
        DelayCommand(fCueTime+=0.01, DLA_UnhelmJouster(oPC));
    }// Remove the players helmet
    if (DLA_GetStateIsSet(nOutcomeOP, DLA_OUTCOME_HELMKNOCKEDOFF))
    {// Remove the opponents helmet
        DelayCommand(fCueTime+=0.01, DLA_UnhelmJouster(oOP));
    }// Remove the opponents helmet
 */

    // Play outcome animations
    DelayCommand(fCueTime+=0.01, DLA_PlayOutcomeAnimation(oPC));
    DelayCommand(fCueTime+=0.01, DLA_PlayOutcomeAnimation(oOP));

    //Syrsnein 25 Feb 2006: Moved ScoreKeep to dla_cut_joust after
    //  DoOutcome functions.
    //DLA_ScoreKeep(oPC, oOP);

    // Get the scores for the round
    int iPCScoreRound = DLA_GetScoreOnRound(oOP);
    int iOPScoreRound = DLA_GetScoreOnRound(oPC);

    // Set up booleans
    int bPCWasUnhorsed = DLA_GetStateIsSet(nOutcomePC, DLA_OUTCOME_UNHORSED );
    int bPCNoTaunt     = DLA_GetStateIsSet(nOutcomePC, DLA_OUTCOME_UNHORSED | DLA_OUTCOME_GLANCEOFF | DLA_OUTCOME_HELMKNOCKEDOFF);

    // Call out the medics!
    fCueTime+=0.7;
    if(DLA_GetStateIsSet(nOutcomePC, DLA_OUTCOME_INJURED) && bPCWasUnhorsed )
    {// Call a medic for the PC
        DelayCommand(fCueTime+=0.1, DLA_HealJouster(oPC));
    }// Call a medic for the PC
    if(DLA_GetStateIsSet(nOutcomeOP, DLA_OUTCOME_INJURED) && DLA_GetStateIsSet(nOutcomeOP, DLA_OUTCOME_UNHORSED))
    {// Call a medic for the opponent
        DelayCommand(fCueTime+=0.1, DLA_HealJouster(oOP));
    }// Call a medic for the opponent

    // Camera movement
    fCueTime = 1.0;
    if(bPCWasUnhorsed)
    {// Player was unhorsed, bring the camera directly above us
        DelayCommand(fCueTime, AssignCommand(oPC, SetCameraFacing(GetFacing(oPC), 20.0, 10.0, CAMERA_TRANSITION_TYPE_VERY_FAST)));
    }// Player was unhorsed
    else
    {// Continue moving the camera around us
        DelayCommand(fCueTime, AssignCommand(oPC, SetCameraFacing(GetOppositeDirection(GetFacing(oPC)), 20.0, 10.0, CAMERA_TRANSITION_TYPE_VERY_FAST)));
    }// Continue moving the camera

    /* Syrsnein 19 June 2006 - Removed this as we don't seem to be able to remove it later
    object oRef = GetObjectByTag("DLA_JOUST_REF");
    // If the PC is stunned, show it during the aim and defense convo
    if (DLA_GetStunCondition(oPC) >= DLA_JOUST_CONDITION_SHAKEN)
    {
        effect eStunned = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
        DelayCommand(fCueTime+=0.1, AssignCommand(oRef, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eStunned, oPC)));
    }
    else
    {
        DelayCommand(fCueTime+=0.1, RemoveEffectByCreator(oPC, oRef));
    }
    */

    //victory pose only if not unhorsed
    fCueTime = 2.5;
    if(!bPCWasUnhorsed && !bPCNoTaunt && (iPCScoreRound > iOPScoreRound))
    {// Player can perform victory salute
        float fAngle = GetFarLeftDirection(GetFacing(oPC));
        DelayCommand(fCueTime+=0.5, AssignCommand(oPC, SetCameraFacing(fAngle, 20.0, 45.0, CAMERA_TRANSITION_TYPE_VERY_FAST)));
        //play animation
        DelayCommand(fCueTime+=1.5, AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_TAUNT)));
        if(DLA_GetStateIsSet(nOutcomeOP, DLA_OUTCOME_INJURED))
        {// Opponent was injured.  Boos from the crowd
            object oBoos = GetObjectByTag("dla_snd_joust_boos");
            DelayCommand(fCueTime+=0.01, SoundObjectPlay(oBoos));
            DelayCommand(fCueTime+5.0, SoundObjectStop(oBoos));
        }// Opponent was injured.
        else
        {// Yays from the crowd
            object oYays = GetObjectByTag("dla_snd_joust_yays");
            DelayCommand(fCueTime+=0.01, SoundObjectPlay(oYays));
            DelayCommand(fCueTime+5.0, SoundObjectStop(oYays));
        }// Yays from the crowd
    }
    // Do the scoring
    fCueTime = 8.0;
    DelayCommand(fCueTime, MusicBattleStop(GetArea(oPC)));
    DelayCommand(fCueTime+=0.1, MusicBackgroundPlay(GetArea(oPC)));

    DelayCommand(fCueTime+=0.1, ExecuteScript("dla_jt_scoring", oPC));
//    DelayCommand(fCueTime, DLA_JoustCutsceneScoring(oPC, oOP));
}
/*
void DLA_JoustCutsceneScoring(object oPC, object oOP)
{
    int iPCScoreRound = DLA_GetScoreOnRound(oOP);
    int iOPScoreRound = DLA_GetScoreOnRound(oPC);
    float fCueTime = 0.0;

    // Fade out, make the player invisible and jump to the center of the arena
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    object oCenterWP = GetWaypointByTag("DLA_ARENA_CENTER");
    DelayCommand(fCueTime+=0.1, FadeToBlack(oPC, FADE_SPEED_FASTEST));
    DelayCommand(fCueTime+=0.7, AssignCommand(oPC, ClearAllActions(TRUE)));
    DelayCommand(fCueTime+=0.1, AssignCommand(oPC, JumpToObject(oCenterWP)));
    DelayCommand(fCueTime+=0.1, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oPC));
    DelayCommand(fCueTime+=0.1, DLA_JoustCutsceneScoreDisplay(oPC, oOP));

    // Move the camera about to face the kings scoreboard
    DelayCommand(fCueTime+=0.1, AssignCommand(oPC, SetCameraFacing(GetFacing(oCenterWP), 20.0, 50.0, CAMERA_TRANSITION_TYPE_SNAP)));

    // Fade in
    DelayCommand(fCueTime+=0.2, FadeFromBlack(oPC));

    // Setup the announcement
    object oJoustRef = GetObjectByTag("DLA_JOUST_REF");
    DLA_JoustDebug("PC Score: " + IntToString(iPCScoreRound));
    DLA_JoustDebug("OP Score: " + IntToString(iOPScoreRound));
    string sSpeak1 = "The round is TIED!";
    string sSoundTag = "dla_snd_joust_champ";
    float fFacing = 0.0;
    int nAnimation = ANIMATION_FIREFORGET_TAUNT;

    if(iPCScoreRound>iOPScoreRound)
    {// Player won the round
        sSpeak1 = "The bout goes to " + GetName(oPC) + "!";
        fFacing = 90.0;
        nAnimation = ANIMATION_FIREFORGET_SALUTE;
    }// Player won the round
    else if(iPCScoreRound<iOPScoreRound)
    {// Opponent won the round
        sSpeak1 = "The bout goes to " + DLA_GetOpponentName(oPC) + "!";
        fFacing = 270.0;
        nAnimation = ANIMATION_FIREFORGET_SALUTE;
    }// Opponent won the round
    else if (iPCScoreRound+iOPScoreRound == 0)
    {// No score on the round
        sSpeak1 = "No Score!";
        sSoundTag = "dla_snd_joust_boos2";
    }// no score on the round

    object oSound = GetObjectByTag(sSoundTag);
    // Announce the score
    DelayCommand(fCueTime+=1.5, AssignCommand(oJoustRef, SetFacing(fFacing)));
    DelayCommand(fCueTime+=0.1, SoundObjectPlay(oSound));
    DelayCommand(fCueTime+5.0, SoundObjectStop(oSound));
    DelayCommand(fCueTime+=0.8, AssignCommand(oJoustRef, PlayAnimation(nAnimation)));
    DelayCommand(fCueTime+=0.2, AssignCommand(oJoustRef, SpeakString(sSpeak1)));

    // Fade out remove invisibility and reset the announcer
    DelayCommand(fCueTime+=2.0, FadeToBlack(oPC, FADE_SPEED_FAST));
    DelayCommand(fCueTime+=1.1, RemoveEffect(oPC, eInvis));
    DelayCommand(fCueTime+=0.2, AssignCommand(oJoustRef, SetFacing(0.0)));
    // End the tilt
    DelayCommand(fCueTime+=0.2, DLA_JoustCutsceneTiltEnd(oPC, oOP));
}

//Syrsnein, 11 June 2006: Moved code to this function to end the current tilt.
void DLA_JoustCutsceneTiltEnd(object oPC, object oOP)
{
    float fCueTime = 0.0;

    // Check for match end.  If the match is over, end the cutscene
    int iPCScoreMatch = DLA_GetScoreOnMatch(oPC, FALSE);
    int iOPScoreMatch = DLA_GetScoreOnMatch(oPC, TRUE);
    if((iPCScoreMatch >= 3 || iOPScoreMatch >= 3) && (iPCScoreMatch != iOPScoreMatch))
    {// Match is over
        DelayCommand(fCueTime+=0.1, DLA_JoustCutsceneEnd(oPC, oOP));
        return;
    }// Match is over
    else
    {// Clear any old passing remarks and return the jousters to their starting points
        DeleteLocalInt(oOP, "nJoustRemarkIndex");
        DeleteLocalInt(oOP, "nJoustRemarkGENeutral");
        DeleteLocalInt(oOP, "nJoustRemarkLCNeutral");
        // Set the player as returning to starting point
        DeleteLocalInt(oPC, DLA_VAR_JOUST_ON);
        SetLocalInt(oPC, DLA_VAR_JOUST_RETURN, TRUE);

        // Lets jump to our end points and walk back to each other to exchange
        // a word or two.
        AssignCommand(oOP, ClearAllActions(TRUE));
        AssignCommand(oPC, ClearAllActions(TRUE));
        DelayCommand(fCueTime, AssignCommand(oOP, ActionJumpToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_OP_WPT2")))));
        DelayCommand(fCueTime+=0.01, AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_PC_WPT2")))));
        DelayCommand(fCueTime+=0.1, AssignCommand(oOP, ActionMoveToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_OP_WPT1")), FALSE)));
        DelayCommand(fCueTime+=0.01, AssignCommand(oPC, ActionMoveToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_PC_WPT1")), FALSE)));
        DelayCommand(fCueTime+=2.0, FadeFromBlack(oPC, FADE_SPEED_MEDIUM));
        if (DLA_GetOutcome(oOP, DLA_OUTCOME_INJURED))
        {// Let the player know their hit was unchivalrous
            DelayCommand(fCueTime+=0.5, SendMessageToPC(oPC, "Your hit was unchivalrous!  Your reputation may have been damaged!"));
        }// Let the player know their hit was unchivalrous
    }// Clear any old passing remarks and return the jousters to their starting points
}
 */
// May 2006, Syrsnein: Have the jousters exchange words
void DLA_JoustCutsceneRemarks(object oPC, object oOP)
{
    // Cutscene timing cue
    float fCueTime = 0.0;

    // Set up passing remarks
    int nAlignGE = GetAlignmentGoodEvil(oOP);
    int nAlignLC = GetAlignmentLawChaos(oOP);
    SetLocalInt(oOP, "nJoustRemarkIndex", d4());
    if ((nAlignGE==ALIGNMENT_NEUTRAL && (d20()%2)>0) || nAlignGE==ALIGNMENT_EVIL)
        SetLocalInt(oOP, "bJoustRemarkEvil", TRUE);
    else if ((nAlignLC==ALIGNMENT_NEUTRAL && (d20()%2)>0) || nAlignLC==ALIGNMENT_CHAOTIC)
        SetLocalInt(oOP, "bJoustRemarkChaotic", TRUE);

    // Clear our return indicator
    DeleteLocalInt(oPC, DLA_VAR_JOUST_RETURN);

    // Stop and exchange remarks
    AssignCommand(oOP, ClearAllActions(TRUE));
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oOP, SpeakOneLinerConversation("dla_joust_remark", oPC));

    // Move on to the start positions
    DelayCommand(fCueTime+=2.0, AssignCommand(oOP, ActionMoveToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_OP_WPT1")), FALSE)));
    DelayCommand(fCueTime+=0.1, AssignCommand(oPC, ActionMoveToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_PC_WPT1")), FALSE)));
    DelayCommand(fCueTime+=1.9, FadeToBlack(oPC, FADE_SPEED_FAST));

    // Reset the tilt
//    DelayCommand(fCueTime+=1.2, DLA_JoustCutsceneTiltReset(oPC, oOP));
    DelayCommand(fCueTime+=1.2, ExecuteScript("dla_jt_tilt_res", oPC));
}
/*
//Syrsnein, 17 May 2006: Moved code to this function to reset for the next joust once
//   the opponents have exchanged words.
void DLA_JoustCutsceneTiltReset(object oPC, object oOP)
{
    float fCueTime = 0.0;

    // Clear opponent joust variables
    DLA_DeleteAimPos(oOP);
    DLA_DeleteDefPos(oOP);
    DeleteLocalInt(oOP, DLA_OUTCOME_MASTER_VAR);

    // Clear player joust variables
    DLA_DeleteAimPos(oPC);
    DLA_DeleteDefPos(oPC);
    DeleteLocalInt(oPC, DLA_OUTCOME_MASTER_VAR);

    AssignCommand(oOP, ClearAllActions(TRUE));
    AssignCommand(oPC, ClearAllActions(TRUE));

    DelayCommand(fCueTime+=0.1, privateJoustCheckHelm(oOP));
    DelayCommand(fCueTime+=0.1, privateJoustCheckHelm(oPC));
/*
    if (!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_HEAD, oOP)))
    {// Re-equip the opponents helmet
        object oHelm = GetLocalObject(oOP, DLA_VAR_JOUST_HELMET);
        DelayCommand(fCueTime+=0.01, AssignCommand(oOP, DLA_ForceEquip(oOP,oHelm, INVENTORY_SLOT_HEAD)));
    }// Re-equip the opponents helmet

    // Have the PC requip their helmet
    if (!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC)))
    {// Re-equip the players helmet
        object oHelm = GetLocalObject(oPC, DLA_VAR_JOUST_HELMET);
        DelayCommand(fCueTime+=0.01, AssignCommand(oPC, DLA_ForceEquip(oPC, oHelm, INVENTORY_SLOT_HEAD)));
    }// re-equpi the players helmet
 *end old comment block/
    // Reset the lances
    DelayCommand(fCueTime+=0.1, AssignCommand(oPC, DLA_ResetLance(GetLocalObject(oPC, DLA_VAR_JOUST_LANCE))));
    DelayCommand(fCueTime+=0.01, AssignCommand(oOP, DLA_ResetLance(GetLocalObject(oOP, DLA_VAR_JOUST_LANCE))));

    // Set up the opponent for the next tilt
    DelayCommand(fCueTime+=0.1, AssignCommand(oOP, DLA_SetupOpponent(oPC)));

    //jump the participants to joust starting points
    DelayCommand(fCueTime+=0.1, AssignCommand(oOP, ActionJumpToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_OP_WPT1")))));
    DelayCommand(fCueTime+=0.1, AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_PC_WPT1")))));
}

// 11 June 2006, Sysrnein, Removed deprecated code from this function
void DLA_JoustCutsceneEnd(object oPC, object oOP)
{
    // set variables
    int nWins         = DLA_GetTourneyWins(oPC);
    int nMatches      = DLA_GetTourneyMatches(oPC);
    int bTraining     = DLA_GetIsOnTraining(oPC);
    int iPCScoreMatch = DLA_GetScoreOnMatch(oPC, FALSE);
    int iOPScoreMatch = DLA_GetScoreOnMatch(oPC, TRUE);
    object oHurim     = GetObjectByTag("HurimJoust1");
    object oAgent     = bTraining?GetObjectByTag("Mareth"):oHurim;
    location lWaypoint;
    float fCueTime    = 0.0;
    // for loop index
    int i;

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

    // Clear PC Joust variables
    DLA_DeleteAimPos(oPC);
    DLA_DeleteDefPos(oPC);

    // Get the proper person to talk to after the match
    if (bTraining)
    {// Mareth
        lWaypoint = GetLocation(GetWaypointByTag("WP_JOUSTING_MARETH"));
    }// Mareth
    else
    {// Thiodor
        lWaypoint = GetLocation(GetWaypointByTag("DLA_JOUSTING_AREA_WPT"));
    }// Thiodor

    // Destroy the opponent
    DLA_JoustDebug("   Destroying opponent.");
    AssignCommand(oOP, SetIsDestroyable(TRUE));
    DLA_DestroyObject(oOP);
    DLA_JoustDebug("   Opponent destroyed.");

    // Remove joust tail
    // Syrsnein 10 May 2006: The player should always have joust colors .. but
    // Jump to the person we wish to talk to
    DelayCommand(fCueTime+=0.1, AssignCommand(oPC, ActionJumpToLocation(lWaypoint)));
    // Gather our henchmen and horses
    DelayCommand(fCueTime+=0.1, DLA_SetAssociatesFollow(oPC));
    // do a check anway.
    DelayCommand(fCueTime+=0.1, DLA_RemoveJoustTail(oPC));
    // Change back to mounted phenotype
    DelayCommand(fCueTime+=0.2, DLA_ChangeToMountedPheno(oPC));
    // Dismount
    DelayCommand(fCueTime+=0.2, DLA_Dismount(oPC, FALSE));
    // Remove any borrowed armor and re-equip our own.
    DelayCommand(fCueTime+=0.5, DLA_ReequipOwnItems(oPC));
    // Remove borrowed feats
    DelayCommand(fCueTime+=0.2, DLA_TakeFeat(oPC, IP_CONST_FEAT_ARMOR_PROF_HEAVY));
    DelayCommand(fCueTime+=0.1, DLA_TakeFeat(oPC, IP_CONST_FEAT_SHIELD_PROFICIENCY));
    // Remove strength bonus
    DelayCommand(fCueTime+=0.1, RemoveEffectByCreator(oPC, oHurim));
    // Fade in
    DelayCommand(fCueTime+=1.2, FadeFromBlack(oPC));
    // Talk to someone
    DelayCommand(fCueTime+=1.5, AssignCommand(oPC, ActionStartConversation(oAgent)));
}

//Syrsnein - Rewrote function to correctly display flags
void DLA_JoustCutsceneScoreDisplay(object oPC, object oOP)
{
    int iPCScoreMatch = DLA_GetScoreOnMatch(oPC, FALSE);
    int iOPScoreMatch = DLA_GetScoreOnMatch(oPC, TRUE);
    // while loop index
    int i;

    // adjust score for displaying purposes only
    if (iPCScoreMatch == iOPScoreMatch)
    {
        if (iPCScoreMatch>3) iPCScoreMatch = 3;
        if (iOPScoreMatch>3) iOPScoreMatch = 3;
    }
    else if (iPCScoreMatch>iOPScoreMatch)
    {
        if (iPCScoreMatch>4) iPCScoreMatch = 4;
        if (iOPScoreMatch>3) iOPScoreMatch = 3;
    }
    else
    {
        if (iOPScoreMatch>4) iOPScoreMatch = 4;
        if (iPCScoreMatch>3) iPCScoreMatch = 3;
    }
    // adjust score for display purposes only

    i = GetLocalInt(oPC, "dla_flag_counter");
    while (i < iPCScoreMatch)
    {// Create player scoring flags
        string sI = IntToString(i);
        string sPCFlagTag = "JOUSTPCFLAG" + sI;
        string sPCWPTag = "DLA_PCFLAG_00" + sI;
        object oPCWPTag = GetObjectByTag(sPCWPTag);
        CreateObject(OBJECT_TYPE_PLACEABLE, "dlajflagpc", GetLocation(oPCWPTag), FALSE, sPCFlagTag);
        i++;
    }// Create player scoring flags

    // Set player flag counter
    SetLocalInt(oPC, "dla_flag_counter", iPCScoreMatch);

    i = GetLocalInt(oOP, "dla_flag_counter");
    while(i < iOPScoreMatch)
    {// Create opponent scoring flags
        string sI = IntToString(i);
        string sOPFlagTag = "JOUSTOPFLAG" + sI;
        string sOPWPTag = "DLA_OPFLAG_00" + sI;
        object oOPWPTag = GetObjectByTag(sOPWPTag);
        CreateObject(OBJECT_TYPE_PLACEABLE, "dlajflagop", GetLocation(oOPWPTag), FALSE, sOPFlagTag);
        i++;
    }// Create opponent scoring flags

    // Set opponent flag counter
    SetLocalInt(oOP, "dla_flag_counter", iOPScoreMatch);
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
 */
