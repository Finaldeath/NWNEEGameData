//::///////////////////////////////////////////////
//:: meq_potsc_dflt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Module Equip handler for PotSC.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void ActivateTorch(object oPC);

void main()
{
    object oItem = GetPCItemLastEquipped();
    object oPC = GetPCItemLastEquippedBy();

    // if the item is a torch, have it assign the AOE fear effect
    if ((GetTag(oItem) == "a1_torch") || (GetTag(oItem) == "a1_torch_long"))
    {
        AssignCommand(oItem, ActivateTorch(oPC));
    }
}

void ActivateTorch(object oPC)
{
    effect eTorch = EffectAreaOfEffect(AOE_PER_CUSTOM_AOE, "aen_a1_fearfire");

    eTorch = SupernaturalEffect(eTorch);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTorch, oPC);
}
