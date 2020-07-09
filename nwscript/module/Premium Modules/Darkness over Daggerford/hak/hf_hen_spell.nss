#include "hf_in_henchman"

void main()
{
    if (HenchmanIsDead(OBJECT_SELF))
    {
        int nId = GetLastSpell();
        if (nId == SPELL_CURE_LIGHT_WOUNDS
        || nId == SPELL_CURE_CRITICAL_WOUNDS
        || nId == SPELL_CURE_MINOR_WOUNDS
        || nId == SPELL_CURE_MODERATE_WOUNDS
        || nId == SPELL_CURE_SERIOUS_WOUNDS
        || nId == SPELL_HEAL
        || nId == 506 // Healing Kits
        || nId == SPELLABILITY_LAY_ON_HANDS
        || nId == 309 // Wholeness of Body
        || nId == SPELL_HEALING_CIRCLE
        || nId == SPELL_RAISE_DEAD
        || nId == SPELL_RESURRECTION
        || nId == SPELL_MASS_HEAL
        || nId == SPELL_GREATER_RESTORATION
        || nId == SPELL_REGENERATE
        || nId == SPELL_AID
        || nId == SPELL_VIRTUE
        )
        {
            object oPC = GetLastSpellCaster();
            if (GetIsPC(oPC))
            {
                HenchmanRaise(OBJECT_SELF, oPC);
                return;
            }
        }
    }

    if (!HenchmanIsPassive(OBJECT_SELF))
    {
        ExecuteScript("nw_ch_acb", OBJECT_SELF);
    }
}
