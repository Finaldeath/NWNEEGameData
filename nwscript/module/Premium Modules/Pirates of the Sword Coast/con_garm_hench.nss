//::///////////////////////////////////////////////
//:: con_garm_hench
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is Garm an active Henchmen?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHench = GetHenchman(oPC, 1);
    int iCounter = 1;
    int iResult = FALSE;

    // Cycle through the party and look for Garm.
    while (GetIsObjectValid(oHench) == TRUE)
    {
        if (GetTag(oHench) == "a2_hench_garm")
        {
            iResult = TRUE;
        }

        oHench = GetHenchman(oPC, ++iCounter);
    }

    return iResult;
}
