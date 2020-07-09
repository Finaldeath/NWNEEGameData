//::///////////////////////////////////////////////
//:: con_a2_clrcshp
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Player has been offered the cleric shop
    before.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();

    if(GetLocalInt(oModule, "cac_a2_clrcshp") == TRUE)
    {
        return TRUE;
    }

    return FALSE;

}
