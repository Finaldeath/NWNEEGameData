//::///////////////////////////////////////////////
//:: con_a3_seige10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has left the island of the dead and
    has been awoken aboard the Skull and Bones
    as it is sailed to the Rose by Gyllum.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A3_SEIGE");

    if(iPlot >= 10)
    {
        return TRUE;
    }

    return FALSE;

}
