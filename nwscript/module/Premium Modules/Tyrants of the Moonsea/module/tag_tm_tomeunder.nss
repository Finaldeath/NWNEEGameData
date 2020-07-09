// item event script for Tome of Understanding
// on use: raise player's WIS by one and destroy self

#include "x2_inc_switches"

// returns the skin's existing wisdom bonus, or zero if none
int getExistingWisdomBonus(object oSkin)
{
    itemproperty ip = GetFirstItemProperty(oSkin);
    while (GetIsItemPropertyValid(ip))
    {
        if ((GetItemPropertyType(ip) == ITEM_PROPERTY_ABILITY_BONUS))
        {
             if (GetItemPropertySubType(ip) == ABILITY_WISDOM)
             {
                if (GetItemPropertyDurationType(ip) == DURATION_TYPE_PERMANENT)
                {
                    return 1;
                }
            }
        }
        ip = GetNextItemProperty(oSkin);
    }
    return 0;
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();

    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
    {
        object oPC = GetItemActivator();
        object oItem = GetItemActivated();
        if (GetIsPC(oPC))
        {
            object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
            if (GetIsObjectValid(oSkin))
            {
                // add an item property to the player's hide
                int nBonus = getExistingWisdomBonus(oSkin) + 1;
                itemproperty iBonus = ItemPropertyAbilityBonus(ABILITY_WISDOM, nBonus);
                AddItemProperty(DURATION_TYPE_PERMANENT, iBonus, oSkin);
            }
            else
            {
                // no hide on the player, so apply a persistent effect
                effect eBonus = EffectAbilityIncrease(ABILITY_WISDOM, 1);
                effect eSuper = SupernaturalEffect(eBonus);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSuper, oSkin);
            }

            FloatingTextStringOnCreature("* Wisdom +1 *", oPC);
            effect eVfx = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVfx, oPC);

            DestroyObject(oItem);
        }
    }
}
