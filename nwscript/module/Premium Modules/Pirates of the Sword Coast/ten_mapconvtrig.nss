//::///////////////////////////////////////////////
//:: ten_mapconvtrig
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This Trigger on Enter event will start the
    troglodyte conversation about the shape of the
    island. They are standing infrount of a make
    shift map in the sand.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////

const string STRING1 = "Island look like thisss!";
const string STRING2 = "No, village isss here and sssacred cave isss over here!";
const string STRING3 = "Then where is sssacred wood?";
const string STRING4 = "Sssacred wood and sssacred fire are inssside village!";
const string STRING5 = "Not in sssacred cave? That make no sssenssse...";
const string STRING6 = "Sssacred cave for old godsss, not for wood and fire.";
const string STRING7 = "Here, I call it sssacred village, then...";

// protect the cutscene from strangness if a comat ensues
void SpeakWrapper(object oSpeaker, string sLine, int iAnimation);

void main()
{
    object oPC = GetEnteringObject();
    object oTrog1 = GetObjectByTag("a1_trogmap01");
    object oTrog2 = GetObjectByTag("a1_trogmap02");

    int iDoOnce = GetLocalInt(OBJECT_SELF, "DOONCE");
    int iEXP = GetJournalQuestExperience("a1_natives");

    // Speak the lines and animate
    if ((GetIsPC(oPC) == TRUE)&& (iDoOnce == FALSE))
    {
        SetLocalInt(OBJECT_SELF, "DOONCE", TRUE);

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A1_NATIVES", 20);
        AddJournalQuestEntry("a1_natives", 20, oPC);

        DelayCommand(0.0, SpeakWrapper(oTrog1, STRING1, ANIMATION_LOOPING_GET_LOW));
        DelayCommand(4.5, SpeakWrapper(oTrog2, STRING2, ANIMATION_LOOPING_TALK_FORCEFUL));
        DelayCommand(7.5, SpeakWrapper(oTrog1, STRING3, ANIMATION_LOOPING_TALK_PLEADING));
        DelayCommand(10.5, SpeakWrapper(oTrog2, STRING4, ANIMATION_LOOPING_GET_LOW));
        DelayCommand(13.5, SpeakWrapper(oTrog1, STRING5, ANIMATION_LOOPING_TALK_LAUGHING));
        DelayCommand(16.5, SpeakWrapper(oTrog2, STRING6, ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        DelayCommand(19.5, SpeakWrapper(oTrog1, STRING7, ANIMATION_FIREFORGET_PAUSE_BORED));
    }
}

// Stop spewing lines if combat starts.
void SpeakWrapper(object oSpeaker, string sLine, int iAnimation)
{
    object oTrog1 = GetObjectByTag("a1_trogmap01");
    object oTrog2 = GetObjectByTag("a1_trogmap02");

    if ((GetIsInCombat(oTrog1)== FALSE) && (GetIsInCombat(oTrog2)== FALSE))
    {
        AssignCommand(oSpeaker, SpeakString(sLine, TALKVOLUME_SHOUT));
        AssignCommand(oSpeaker,
            ActionPlayAnimation(iAnimation, 1.0f, 3.0f));
    }
    else if (GetIsInCombat(oTrog1)== TRUE)
    {
        AssignCommand(oTrog2, ActionAttack(GetAttackTarget(oTrog1)));
    }
    else if (GetIsInCombat(oTrog2)== TRUE)
    {
        AssignCommand(oTrog1, ActionAttack(GetAttackTarget(oTrog2)));
    }
}
