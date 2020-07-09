//::///////////////////////////////////////////////
//:: con_a2_nclrcshp
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Player has not been offered the cleric shop
    before.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();

    if(GetLocalInt(oModule, "cac_a2_clrcshp") == FALSE)
    {
        return TRUE;
    }

    return FALSE;

}
