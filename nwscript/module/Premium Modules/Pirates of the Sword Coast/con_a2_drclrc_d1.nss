//::///////////////////////////////////////////////
//:: con_a2_drclrc_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to the door cleric
    atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oDoorCleric = OBJECT_SELF;
    int iReturn = FALSE;

    if (GetLocalInt(oDoorCleric, "cac_a2_drclrc_d1") == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
