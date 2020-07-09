//::///////////////////////////////////////////////
//:: con_a2_redtip_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC not talked to Red Tip
    atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oRedTip = OBJECT_SELF;
    int iReturn = FALSE;

    if (GetLocalInt(oRedTip, "cac_a2_redtip_d1") == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
