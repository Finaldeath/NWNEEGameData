//::///////////////////////////////////////////////
//:: Name nat_a1_edgrimm
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Edgrimm was physiclly attacked
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////

void main()
{
    object oAttacker = GetLastAttacker();
    object oModule = GetModule();
    object oSelf = OBJECT_SELF;
    int iHostile = GetLocalInt(oModule, "A1_DWARF");

    // If the plot says that Edgrim isn't attacking update it.
    if (iHostile < 70)
    {
        // if the attacker was a player update the plot and attack
        if ((GetIsPC(oAttacker) == TRUE) || (GetIsPC(GetMaster(oAttacker)) == TRUE))
        {
            ExecuteScript("exe_a1_dwarf70", oSelf);
        }
    }

    return;
}
