//::///////////////////////////////////////////////
//:: ndt_a1_gntspdr
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Once all the Giant spiders are dead, mark the
    new spawn point.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_safepoint"

void main()
{
    object oModule = GetModule();
    object oArea = GetArea(OBJECT_SELF);
    object oKiller = GetLastKiller();
    int iKills = GetLocalInt(oModule, "A1_DEAD_SPIDERS") + 1;
    int iEXP = GetJournalQuestExperience("a0_escort");

    // If all the bandits are dead forward the plot.
    if (iKills >= 2 )
    {
        if (GetObjectType(oKiller) == OBJECT_TYPE_AREA_OF_EFFECT)
        {
            oKiller = GetAreaOfEffectCreator();
        }
        else if (GetAssociateType(oKiller) != ASSOCIATE_TYPE_NONE)
        {
            oKiller = GetMaster(oKiller);
        }

        AssignCommand(oModule, UpdateSafePoint(oArea));
    }

    SetLocalInt(oModule, "A1_DEAD_SPIDERS", iKills);
}
