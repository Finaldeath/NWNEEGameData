//::///////////////////////////////////////////////
//:: cac_a0_cargo90
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The plot is resolved. Rahmna has received and
    levitated the statue into the box. The PC must
    now return to the Midnight Rose to collect
    his reward.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();
    object oBook = GetItemPossessedBy(oPC, "a0_rahmansbook");
    int iEXP = GetJournalQuestExperience("a0_cargo");
    iEXP = ConvertPercent(iEXP, 0.20f);

    if (GetIsObjectValid(oBook) == TRUE)
    {
        DestroyObject(oBook);
        HandoutQuestXP(oPC, iEXP);

        SetLocalInt(oModule, "A0_CARGO", 90);
        AddJournalQuestEntry("a0_cargo", 90, oPC);
        SetLocalInt(oModule, "A0_CARGOPLOTDONE", TRUE);
    }
}
