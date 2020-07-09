//::///////////////////////////////////////////////
//:: pds_a1sacredwood
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The on inventory disturbed event for the Wood
    pile on the troglodyte ship. Once the player takes
    the wood, all Trogs will go hostile.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Oct, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetLastDisturbed();
    int iEXP = GetJournalQuestExperience("a1_natives");

    if (GetIsPC(oPC) == TRUE)
    {
        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(GetModule(), "A1_NATIVES", 120);

        AddJournalQuestEntry("a1_natives", 120, oPC);
        ExecuteScript("exe_a1_troghosti", GetModule());
    }
}

