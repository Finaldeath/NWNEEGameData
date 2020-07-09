//::///////////////////////////////////////////////
//:: aen_a0_docks
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Activate the cutscene on addition of a new
    player.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Dec, 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"
#include "inc_safepoint"

void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetEnteringObject();
    object oBRBFaction = GetObjectByTag("a0_spwnbnd");
    object oBLDFaction = GetObjectByTag("a0_spwnbld");

    int iBloodS = GetLocalInt(GetModule(), "A0_BLOODSAILOR_ALLY");
    int iBandit = GetLocalInt(GetModule(), "A0_BLACKRIVER_ALLY");

    int iDoOnce = GetLocalInt(oSelf, "aen_a0_docks");

    if (GetIsPCNotDM(oPC) == TRUE)
    {
        cs_AreaOnEnter(oPC);
        UpdateSafePoint();

        // Protection incase a player starts after the factions have been desided.
        if (iBloodS == TRUE)
        {
            AdjustReputation(oBRBFaction, oBLDFaction, -100);
            AdjustReputation(oBLDFaction, oBRBFaction, -100);

            AdjustReputation(oPC, oBLDFaction, 100);
            AdjustReputation(oPC, oBRBFaction, -100);
        }
        else if (iBandit == TRUE)
        {
            AdjustReputation(oBRBFaction, oBLDFaction, -100);
            AdjustReputation(oBLDFaction, oBRBFaction, -100);

            AdjustReputation(oPC, oBRBFaction, 100);
            AdjustReputation(oPC, oBLDFaction, -100);
        }

        if(iDoOnce == FALSE)
        {
            SetLocalInt(oSelf, "aen_a0_docks", TRUE);
            BlackScreen(oPC);
            cs_StartCutscene("cut_a0_pscintrob", "", 2.0f, FALSE, TRUE, 1, oSelf);
        }
        else
        {
            ExecuteScript("exe_autosave", GetModule());
        }
    }
}
