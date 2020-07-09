//:://////////////////////////////////////////////
//:: cac_trsr_inccntr
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Increment the treasures found counter.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

// script has been cut and this functionality has
// been added to script "con_iop_trsrlast"
void main()
{
    object oModule = GetModule();
    int iTrsrCount = GetLocalInt(oModule, "POTSC_TREASURECOUNT");

    SetLocalInt(oModule, "POTSC_TREASURECOUNT", iTrsrCount + 1);
}

