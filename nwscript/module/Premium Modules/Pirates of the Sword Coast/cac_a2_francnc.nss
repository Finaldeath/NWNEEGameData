//::///////////////////////////////////////////////
//:: cac_a2_francnc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Add Sir Francis to the Skull and Bones
    Roster and increment the Poster Counter.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    int iRoster = GetLocalInt(oModule, "POTSC_CREW_ROASTER") + 1;

    SetLocalString(oModule, "NPC_CREW" + IntToString(iRoster), "a3_francis");
    SetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iRoster), "a3_francis_dead");
    SetLocalInt(oModule, "POTSC_CREW_ROASTER", (iRoster));
    SetLocalInt(oModule, "POTSC_CREW_FRANCIS", TRUE);
}
