//::///////////////////////////////////////////////
//:: Name ncs_a1_edgrimm
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Spell Cast at script for Edgrimm
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////

void main()
{
    object oCaster = GetLastSpellCaster();
    object oModule = GetModule();
    object oSelf = OBJECT_SELF;
    int iHarmful = GetLastSpellHarmful();
    int iHostile = GetLocalInt(oModule, "A1_DWARF");

    // if the spell is hostile start the system
    if ((iHarmful == TRUE) && (iHostile < 70))
    {
        // if the attacker was a player update the plot and attack
        if ((GetIsPC(oCaster) == TRUE) || (GetIsPC(GetMaster(oCaster)) == TRUE))
        {
            ExecuteScript("exe_a1_dwarf70", oSelf);
        }
    }

    return;
}
