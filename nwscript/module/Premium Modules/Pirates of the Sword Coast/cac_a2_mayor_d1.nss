//::///////////////////////////////////////////////
//:: cac_a2_mayor_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to They Mayor
    atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oModule = GetModule();
    object oMayor = OBJECT_SELF;

    SetLocalInt(oModule, "cac_a2_mayor_d1", TRUE);
    ExecuteScript("ww_abil_init", oMayor);
}
