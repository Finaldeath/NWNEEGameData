//::///////////////////////////////////////////////
//:: con_a2_france70
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check if the Player Tricked the ring away
    from Pete.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oModule = GetModule();
    int iReturn = FALSE;

    if (GetLocalInt(oModule, "cac_a2_franc70") == TRUE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}
