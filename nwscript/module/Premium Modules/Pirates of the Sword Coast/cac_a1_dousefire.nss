//::///////////////////////////////////////////////
//:: cac_a1_dousefire
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Douse the troglodyte fire
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"
#include "inc_trogfight"

void main()
{
    object oModule = GetModule();
    object oPCSpeaker = GetPCSpeaker();
    object oFBucket = GetItemPossessedBy(oPCSpeaker, "a1_bucket_full");
    int iHostile = GetLocalInt(oModule, "A1_NATIVES");
    int iEXP = GetJournalQuestExperience("a1_natives");

    if (IsFireActive() == TRUE)
    {
        DeactivateFire();
        SlowTrogs();

        DestroyObject(oFBucket);
        CreateItemOnObject("a1_bucket_empty", oPCSpeaker);

        // if the trogs aren't already trying to kill you, they should :)
        if (iHostile < 110)
        {
            HandoutQuestXP(oPCSpeaker, 50);
            SetLocalInt(oModule, "A1_NATIVES", 110);
            AddJournalQuestEntry("a1_natives", 110, oPCSpeaker);

            ExecuteScript("exe_a1_troghosti", GetModule());
        }
    }
}
