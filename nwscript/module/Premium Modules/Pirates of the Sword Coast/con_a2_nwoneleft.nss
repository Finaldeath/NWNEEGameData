//::///////////////////////////////////////////////
//:: con_a2_nwoneleft
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    How many Items are left on the list?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    // What are the states of the plots?
    int iAmulet = GetLocalInt(GetModule(), "A2_NWAMLT");
    int iCutless = GetLocalInt(GetModule(), "A2_NWCTLS");
    int iScepter = GetLocalInt(GetModule(), "A2_NWSCPT");
    int iResult, iCounter = 0;

    // count the number of Items left
    if (iAmulet >= 30)
        iCounter++;
    if (iAmulet >= 30)
        iCounter++;
    if (iAmulet >= 30)
        iCounter++;

    // Tally and set the result
    iResult = FALSE;
    if (iCounter >= 1)
    {
        iResult = TRUE;
    }

    return iResult;
}
