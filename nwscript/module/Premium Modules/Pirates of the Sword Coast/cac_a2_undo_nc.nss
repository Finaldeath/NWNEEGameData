//::///////////////////////////////////////////////
//:: cac_a2_undo_nc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Clear the roster flags and the roster counter.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();

    SetLocalInt(oModule, "POTSC_CREW_ROASTER", 0);
    SetLocalInt(oModule, "POTSC_CREW_BLOODS", FALSE);
    SetLocalInt(oModule, "POTSC_CREW_BLACKR", FALSE);
    SetLocalInt(oModule, "POTSC_CREW_VANTAB", FALSE);
    SetLocalInt(oModule, "POTSC_CREW_WILLIGAN", FALSE);
    SetLocalInt(oModule, "POTSC_CREW_PEGLEG", FALSE);
    SetLocalInt(oModule, "POTSC_CREW_SWEET", FALSE);
    SetLocalInt(oModule, "POTSC_CREW_SHAKEY", FALSE);
    SetLocalInt(oModule, "POTSC_CREW_REDTIP", FALSE);
    SetLocalInt(oModule, "POTSC_CREW_FRANCIS", FALSE);
    SetLocalInt(oModule, "POTSC_CREW_LANGER", FALSE);
}
