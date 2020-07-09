//::///////////////////////////////////////////////
//:: aen_a0_gaupstair
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Starts the cutscene with the Thugs attacking
    Tasina's door in the Golden Apple.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"
#include "inc_balance"

void SpeakWrapper(float fDelay, object oSpeaker, string sLine);
void FireDialog();

void main()
{
    object oPC = GetEnteringObject();
    object oArea = OBJECT_SELF;
    object oBoss = GetObjectByTag("a0_door_leader");
    object oMutch = GetObjectByTag("a0_mutch");
    object oTarg;

    int iDoOnce = GetLocalInt(oArea, "aen_a0_gaupstair");
    int iHitDice;

    cs_AreaOnEnter(oPC);

    if ((GetIsPCNotDM(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oArea, "aen_a0_gaupstair", TRUE);
        FireDialog();

        iHitDice = GetFactionAverageLevel(oPC);
        oTarg = GetFirstFactionMember(oBoss, FALSE);

        while (GetIsObjectValid(oTarg) == TRUE)
        {
            if(GetArea(oTarg)==oArea)
           {
                LevelUpNPC(oTarg);
                ForceRest(oTarg);
            }
            oTarg = GetNextFactionMember(oBoss, FALSE);
        }
        ActionUseSkill(SKILL_HIDE, oMutch);

        cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);
        cs_StartCutscene("cut_a0_tasthug", "", 1.0f, FALSE, TRUE, 1, OBJECT_SELF);
    }
}

void FireDialog()
{
    object oDoor = GetObjectByTag("a0_doortasina");
    object oDoorThug = GetObjectByTag("a0_door_leader");

    AssignCommand(oDoorThug, ActionAttack(oDoor));

    DelayCommand(5.5, AssignCommand(oDoorThug,
        SpeakString("We got you to port, just as we promised!")));

    DelayCommand(9.5, AssignCommand(oDoor,
        SpeakString("You got me to port; Your orders were to get me to sea!")));

    DelayCommand(13.5, AssignCommand(oDoorThug,
        SpeakString("You can see it from your window, witch! Now, pay up!")));

    DelayCommand(17.5, AssignCommand(oDoor,
        SpeakString("I don't have any money. It's all gone, so leave me alone!")));

    DelayCommand(21.5, AssignCommand(oDoorThug,
        SpeakString("You can't hide in there all night, woman!")));

    DelayCommand(25.5, AssignCommand(oDoor,
        SpeakString("Oh yes, I can! Just watch me!")));
}

void SpeakWrapper(float fDelay, object oSpeaker, string sLine)
{
    object oThug1 = GetObjectByTag("a0_corridor_thug");

    if (GetIsInCombat(oThug1)== FALSE)
    {
        DelayCommand(fDelay, AssignCommand(oSpeaker, SpeakString(sLine)));
    }
}

