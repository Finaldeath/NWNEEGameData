//::///////////////////////////////////////////////
//:: con_a2_kssblss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Player has been offered the Kiss of
    Blessing before.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();

    if(GetLocalInt(oModule, "cac_a2_blesskiss") == TRUE)
    {
        return TRUE;
    }

    return FALSE;

}
