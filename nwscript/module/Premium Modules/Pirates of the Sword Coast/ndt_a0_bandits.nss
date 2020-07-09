//::///////////////////////////////////////////////
//:: ndt_a0_bandits
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is the on_death_event for the bandits trying
    to gain access to Tasina room in the golden
    apple.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_safepoint"
#include "_inc_experience"

void main()
{
    object oModule = GetModule();
    object oArea = GetArea(OBJECT_SELF);
    object oKiller = GetLastKiller();
    int iKills = GetLocalInt(oModule, "DEAD_BANDITS") + 1;
    int iEXP = GetJournalQuestExperience("a0_escort");

    SetLocalInt(oModule, "DEAD_BANDITS", iKills);

    // If all the bandits are dead forward the plot.
    if (GetLocalInt(oModule, "DEAD_BANDITS") >= 5 )
    {
        if (GetObjectType(oKiller) == OBJECT_TYPE_AREA_OF_EFFECT)
        {
            oKiller = GetAreaOfEffectCreator();
        }
        else if (GetAssociateType(oKiller) != ASSOCIATE_TYPE_NONE)
        {
            oKiller = GetMaster(oKiller);
        }

        //HandoutQuestXP(oKiller, iEXP);

        UpdateSafePoint(oArea);
        SetLocalInt(GetModule(), "A0_ESCORT", 30);
        AddJournalQuestEntry("a0_escort", 30, oKiller);
    }
}
