//::///////////////////////////////////////////////
//:: con_a1_poly_d1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Do once for greeting the player on the
    Trog Island.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iFlag = GetLocalInt(oModule, "cac_a1_poly_d1");
    int iResult = FALSE;

    if (iFlag == FALSE)
    {
        SetLocalInt(oModule, "cac_a1_poly_d1", TRUE);
        iResult = TRUE;
    }

    return iResult;
}
