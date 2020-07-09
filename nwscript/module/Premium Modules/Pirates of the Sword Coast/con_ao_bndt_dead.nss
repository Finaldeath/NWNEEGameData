//::///////////////////////////////////////////////
//:: con_ao_bndt_dead
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Are all of the Bandits in the Upstairs Golden
    Apple dead?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iResult = FALSE;

    if (GetLocalInt(oModule, "DEAD_BANDITS") < 5 )
    {
        iResult = TRUE;
    }

    return iResult;
}
