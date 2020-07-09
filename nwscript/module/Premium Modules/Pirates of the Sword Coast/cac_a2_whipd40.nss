//::///////////////////////////////////////////////
//:: cac_a2_whipd40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Whipped willigan has recovered all of his
    items, Start the escape cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "inc_global"
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();
    object oWilligan = OBJECT_SELF;
    int iEXP = GetJournalQuestExperience("a2_whipd");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_WHIPD", 40);
    AddJournalQuestEntry("a2_whipd", 40, oPC);


    // set a variable on the lower floor area so it knows to start the cutscene
    object oNextArea = GetObjectByTag("SpindriftWilligansManor");
    SetLocalInt(oNextArea, l_n_A2_WILLIGAN_SUCCESS_CS_START, TRUE);

    // jump all pc's in the area into the next one
    object oArea = GetArea(OBJECT_SELF);
    object oWP = GetWaypointByTag(a2w_Willigan_Success_CS_Start);
    int nIndex = 0;
    oPC = GetPCInArea(oArea, nIndex);
    while(GetIsObjectValid(oPC))
    {
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionJumpToObject(oWP));
        nIndex++;
        oPC = GetPCInArea(oArea, nIndex);
    }
}
