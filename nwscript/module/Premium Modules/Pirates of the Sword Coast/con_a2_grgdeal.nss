//::///////////////////////////////////////////////
//:: con_a2_grgdeal
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Return TRUE if player has NOT received special
    pricing from Grogbeard.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oGrogBeard = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    int iReturn = FALSE;

    if (GetLocalInt(oPC, "cac_a2_grgdeal") != TRUE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
