//::///////////////////////////////////////////////
//:: con_nisar_hench
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is Nisar an active Henchmen?
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

    // Cycle through the party and look for Nisar.
    while (GetIsObjectValid(oHench) == TRUE)
    {
        if (GetTag(oHench) == "a2_hench_nisar")
        {
            iResult = TRUE;
        }

        oHench = GetHenchman(oPC, ++iCounter);
    }

    return iResult;
}
