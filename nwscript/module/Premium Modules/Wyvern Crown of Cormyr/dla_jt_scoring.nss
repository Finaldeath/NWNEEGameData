////////////////////////////////////////////////////////////////////////////////
// dla_jt_scoring
//
// DLA Wyvern Crown of Cormyr
////////////////////////////////////////////////////////////////////////////////
/*
   Display and announce tilt round score.
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

void DLA_JoustCutsceneScoreDisplay(object oPC, object oOP);

void main()
{
    object oPC = OBJECT_SELF;
    object oOP = GetLocalObject(oPC, DLA_VAR_JOUST_OPPONENT);
    int iPCScoreRound = DLA_GetScoreOnRound(oOP);
    int iOPScoreRound = DLA_GetScoreOnRound(oPC);
    float fCueTime = 0.0;

    if (!GetCutsceneMode(oPC))
        SetCutsceneMode(oPC);

    // Fade out, make the player invisible and jump to the center of the arena
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    object oCenterWP = GetWaypointByTag("DLA_ARENA_CENTER");
    DelayCommand(fCueTime+=0.1, FadeToBlack(oPC, FADE_SPEED_FASTEST));
    DelayCommand(fCueTime+=0.7, AssignCommand(oPC, ClearAllActions(TRUE)));
    DelayCommand(fCueTime+=0.1, AssignCommand(oPC, JumpToObject(oCenterWP)));
    DelayCommand(fCueTime+=0.01, AssignCommand(oOP, ClearAllActions(TRUE)));
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
    string sSpeak1 = "The bout is TIED!";
    string sSoundTag = "dla_snd_joust_champ";
    float fFacing = 0.0;
    int nAnimation = ANIMATION_FIREFORGET_TAUNT;

    if(iPCScoreRound>iOPScoreRound)
    {// Player won the round
        sSpeak1 = "The bout goes to " + GetName(oPC) + "!";
        fFacing = 90.0;
        nAnimation = ANIMATION_FIREFORGET_SALUTE;
    }// Player won the bout
    else if(iPCScoreRound<iOPScoreRound)
    {// Opponent won the bout
        sSpeak1 = "The bout goes to " + DLA_GetOpponentName(oPC) + "!";
        fFacing = 270.0;
        nAnimation = ANIMATION_FIREFORGET_SALUTE;
    }// Opponent won the bout
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
    DelayCommand(fCueTime+=0.2, ExecuteScript("dla_jt_tilt_end", oPC));
//    DelayCommand(fCueTime+=0.2, DLA_JoustCutsceneTiltEnd(oPC, oOP));
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
