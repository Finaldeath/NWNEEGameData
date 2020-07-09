//::///////////////////////////////////////////////
//:: dla_hrs_onspell
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*

    OnSpellCastAt event handler for horses

*/
//:://////////////////////////////////////////////
//:: Created By: DirgeSinger
//:: Created On: June 04, 2005
//:://////////////////////////////////////////////
//:: Updated On: June 06, 2005

#include "x0_i0_henchman"
#include "X0_INC_HENAI"
#include "dla_i0_horse"

void main()
{
    //if a horse henchman, keep going for code. If just a horse, refer to the
    //appropriate AI file.
    if(GetAssociateType(OBJECT_SELF) != ASSOCIATE_TYPE_HENCHMAN || !DLA_GetIsDLAHorse(OBJECT_SELF))
    {
        ExecuteScript("x2_def_spellcast", OBJECT_SELF);
        return;
    }

    //if the last spell was a curative one, then let's restore the horse henchman
    if(GetIsHenchmanDying() == TRUE)
    {
        int nId = GetLastSpell();
        if(nId == SPELL_CURE_LIGHT_WOUNDS
            || nId == SPELL_CURE_CRITICAL_WOUNDS
            || nId == SPELL_CURE_MINOR_WOUNDS
            || nId == SPELL_CURE_MODERATE_WOUNDS
            || nId == SPELL_CURE_SERIOUS_WOUNDS
            || nId == SPELL_HEAL
            || nId == 506 // * Healing Kits
            || nId == SPELLABILITY_LAY_ON_HANDS // * Lay on Hands
            || nId == 309    // * Wholeness of Body
            || nId == SPELL_HEALING_CIRCLE
            || nId == SPELL_RAISE_DEAD
            || nId == SPELL_RESURRECTION
            || nId == SPELL_MASS_HEAL
            || nId == SPELL_GREATER_RESTORATION
            || nId == SPELL_REGENERATE
            || nId == SPELL_AID
            || nId == SPELL_VIRTUE)
        {
            SetLocalInt(OBJECT_SELF, "X0_L_WAS_HEALED", 10);
            WrapCommandable(TRUE, OBJECT_SELF);
            DoRespawn(GetLastSpellCaster(), OBJECT_SELF);
            return;
        }
    }

    //go ahead and run the normal script for associate OnSpellCastAt
    ExecuteScript("nw_ch_acb", OBJECT_SELF);
}

