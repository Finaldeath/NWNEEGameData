//::///////////////////////////////////////////////
//:: aen_a2_undertmpl
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    On enter script for "Beneath Temple" area.

    Runs cutscene area on enter function.

    First time sets up some arrays which are
    used later by other scripts.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 17/05
//:://////////////////////////////////////////////
#include "_inc_experience"
#include "inc_balance"
#include "inc_global"

void main()
{
    object oModule = GetModule();
    object oEnter = GetEnteringObject();
    object oArea = OBJECT_SELF;
    object oCursor = OBJECT_INVALID;
    int iEXP = GetJournalQuestExperience("a2_spndrf");
    iEXP = ConvertPercent(iEXP, 0.20f);

    cs_AreaOnEnter_Poly(oEnter);

    if((GetIsPC(oEnter) == TRUE) && // can be DM, doesn't matter
        (GetLocalInt(OBJECT_SELF, "aen_a2_undertmpl_d1") == FALSE))
    {
        // reward the player for sucessfully infiltrating the temple
        SetLocalInt(oEnter, "aen_a2_spndrf60", TRUE);
        HandoutQuestXP(oEnter, iEXP);
        SetLocalInt(oModule, "A2_SPNDRF", 60);
        AddJournalQuestEntry("a2_spndrf", 60, oEnter);

        // Level-up Key NPC's in the area.
        oCursor = GetFirstObjectInArea(oArea);
        while (GetIsObjectValid(oCursor) == TRUE)
        {
            if ((GetTag(oCursor) == "a2_umbpriestess")
              || (GetTag(oCursor) == "a2_sahauguard")
              || (GetTag(oCursor) == "a2_sahaucleric"))
            {
                LevelUpNPC(oCursor);
            }
            oCursor = GetNextObjectInArea(oArea);
        }

        SetLocalInt(OBJECT_SELF, "aen_a2_undertmpl_d1", TRUE);
        A2UnderTempleArraySetup(OBJECT_SELF);
    }
}
