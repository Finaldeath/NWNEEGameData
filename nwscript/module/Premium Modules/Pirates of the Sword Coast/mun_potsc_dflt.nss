//::///////////////////////////////////////////////
//:: mun_potsc_dflt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Module Un-Equip handler for PotSC.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oItem = GetPCItemLastUnequipped();
    string sItem = GetTag(oItem);
    object oPC = GetPCItemLastUnequippedBy();
    object oArea = GetArea(oPC);
    string sArea = GetTag(oArea);
    effect eTorch;
    string sUniformWarning = "Captain Allendry expects you to be in uniform while at sea.";

    //Handling the Survival Torch
    if ((sItem == "a1_torch") || (sItem == "a1_torch_long"))
    {
        eTorch = GetFirstEffect(oPC);
        while (GetIsEffectValid(eTorch) == TRUE)
        {
            if(GetEffectCreator(eTorch) == oItem)
            {
                RemoveEffect(oPC, eTorch);
            }

            eTorch = GetNextEffect(oPC);
        }
    }

    //Handling the Sailor's Uniform while aboard the Midnight Rose.
    if (sItem == "a0_sailorsuniform" &&
        (sArea == "BelowDeck_MidnightRose_AtSea" ||
         sArea == "TopDeck_MidnightRose_AtSea"))
    {
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_CHEST));
        FloatingTextStringOnCreature(sUniformWarning, oPC, FALSE);
    }
}
