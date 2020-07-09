//::////////////////////////////////////////////////////////////////////////////
//:: itm_id1_anttot
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Item Event handler for Antoine's Totem. When activated this item will
    provide the player with a speed increase.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Jan 18, 2006
//::////////////////////////////////////////////////////////////////////////////

#include "x2_inc_switches"
#include "inc_id1_debug"

void main()
{
//    int nEvent = GetUserDefinedItemEventNumber();
    int nType;
    object oPC;

//    if (nEvent == X2_ITEM_EVENT_ACTIVATE) // Activate event; item activated.
//    {
        oPC = GetItemActivator();

        effect eSpeed = EffectMovementSpeedIncrease(50);
        effect eVFX = EffectVisualEffect(VFX_IMP_HASTE);

        eSpeed = SupernaturalEffect(eSpeed);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeed, oPC);

        SetLocalInt(oPC, "bUsedAntoineTotem", TRUE);
//    }
//    else // Error: unrecognized item event.
//    {
//        DebugMessage("itm_id1_anttot::main() nEvent != X2_ITEM_EVENT_ACTIVATE");
//    }
}
