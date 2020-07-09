//:://////////////////////////////////////////////
//:: cac_poly_trsr
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set the custom token for the current number
    of treasure's found.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    int iTrsrCount = GetLocalInt(oModule, "POTSC_TREASURECOUNT");

    // 10 possible buried treasures.
    SetCustomToken(1503, IntToString(iTrsrCount));
}
