//::///////////////////////////////////////////////
//:: con_a2_rand_ppsm
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Random check if the PC has yet to gain Pegleg
    Pete or Sweet Marie as a crewman?
    (GrogBeard's hints)
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iSweet = GetLocalInt(GetModule(), "A2_SWEET");
    int iPegLeg = GetLocalInt(GetModule(), "A2_PEGLEG");
    int iResult = FALSE;

    if ((Random(4) == 0) && (iSweet < 30) && (iPegLeg < 30))
    {
        iResult = TRUE;
    }
    return iResult;
}
