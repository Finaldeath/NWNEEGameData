//::///////////////////////////////////////////////
//:: con_a2_governorn
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC NOT entered the Govenor's manor?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iFlag = GetLocalInt(oModule, "aen_a2_governor");
    int iReturn = FALSE;

    if(iFlag == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;

}
