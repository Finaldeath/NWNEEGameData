//::///////////////////////////////////////////////
//:: con_a2_nkssblss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Player has not been offered the Kiss of
    Blessing before.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();

    if(GetLocalInt(oModule, "cac_a2_blesskiss") == FALSE)
    {
        return TRUE;
    }

    return FALSE;

}
