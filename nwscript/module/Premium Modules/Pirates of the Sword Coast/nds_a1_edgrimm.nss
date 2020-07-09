//::///////////////////////////////////////////////
//:: Name nds_a1_edgrimm
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDisturbed script for Edgrimm
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////

void main()
{
    object oDisturber = GetLastDisturbed();
    object oItem = GetInventoryDisturbItem();
    object oSelf = OBJECT_SELF;
    object oModule = GetModule();
    int iHostile = GetLocalInt(oModule, "A1_DWARF");

    // if the attacker was a player update the plot and attack
    if (((GetIsPC(oDisturber) == TRUE) || (GetIsPC(GetMaster(oDisturber)) == TRUE))
      && (iHostile < 70))
    {
        ExecuteScript("exe_a1_dwarf70", oSelf);
    }

    return;
}
