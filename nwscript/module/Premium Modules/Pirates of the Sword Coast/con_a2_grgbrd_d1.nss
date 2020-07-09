//::///////////////////////////////////////////////
//:: con_a2_grgbrd_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to GrogBeard
    atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oGrogBeard = OBJECT_SELF;
    int iReturn = FALSE;

    if (GetLocalInt(oGrogBeard, "cac_a2_grgbrd_d1") == TRUE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
