//::///////////////////////////////////////////////
//:: cac_a2_necro10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Captain of the Skull and Bones is looking
    for a crew. During Tasina's exodus from
    Spindrift a scuffle broke out among the
    crew of the Skull and Bones and the Umberline
    Clergy. The Captain will take you out after
    Tasina and the Midnight Rose, if you can fill
    his roster.

    HAYWARD TO DO - Is the above description
    still relevant?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a2_necro");
    iEXP = ConvertPercent(iEXP, 0.30f);

    HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_NECRO", 10);
    AddJournalQuestEntry("a2_necro", 10, oPC);
}
