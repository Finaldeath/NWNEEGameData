//::///////////////////////////////////////////////
//:: cac_a1_edgrim_ww
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Initializes the default variables for the
     WW Ability Check system on the NPC Edgrimm
     in Act 1
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Dec 2004
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    //Edit these on a per NPC basis if you wish
    //to change the default values.
    object oModule = GetModule();
    string sCheckType = "WW_CHECK_TYPE_ALL";
    int bTrackResultPerCreature = TRUE;
    int bAllowRetries = TRUE;
    int iDCIncreaseOnFailure = 5;
    int bTrackDCPerCreature = TRUE;
    int bAutoDC = TRUE;
    int iAutoDCModifier = 0;

    int iDoOnce = GetLocalInt(oModule, "cac_a1_edgrim_ww");

    //Initialize the system one time using the above variables.
    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a1_edgrim_ww", TRUE);

        WW_InitializeAbility(sCheckType, bTrackResultPerCreature, bAllowRetries,
            iDCIncreaseOnFailure, bTrackDCPerCreature, bAutoDC, iAutoDCModifier);
    }
}
