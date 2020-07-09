//::///////////////////////////////////////////////
//:: con_a1_polyfpit
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    is the nearest firepit from poly off?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oFirePit = GetNearestObjectByTag("a1_dcavepit");
    int iFire = GetLocalInt(oFirePit, "iFIREHEIGHT");
    int iResult = FALSE;

    if (iFire <= 0)
    {
        iResult = TRUE;
    }
    return iResult;
}
