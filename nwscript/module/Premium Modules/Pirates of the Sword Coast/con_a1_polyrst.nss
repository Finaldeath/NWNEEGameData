//::///////////////////////////////////////////////
//:: con_a1_polyrst
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Poly initiates with a one-liner after the PC
    emerges finds the resting cave.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
const string sConvIndex = "A1_POLYAFTER_REST";

int StartingConditional()
{
    string sVar = GetLocalString(OBJECT_SELF, "CONV_INDEX");
    int iResult = FALSE;

    if (sVar == sConvIndex)
    {
        iResult = TRUE;
    }

    return iResult;
}
