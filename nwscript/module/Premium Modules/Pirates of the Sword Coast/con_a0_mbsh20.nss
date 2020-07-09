//::///////////////////////////////////////////////
//:: con_a0_mbsh20
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Dela has reacted in a friendly way to the
    PC and will retail mechandise to the party.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iDelaPlot = GetLocalInt(GetModule(), "A0_AMBUSH");
    int iResult = FALSE;

    if (iDelaPlot == 20)
    {
        iResult = TRUE;
    }

    return iResult;
}
