// player has damage abatorru's sphere in AR1110.
// .. this makes abatorru very angry.

#include "nw_i0_generic"

void main()
{
    // make abatorru attack the player
    if (GetLocalInt(OBJECT_SELF, "nIsDamaged") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nIsDamaged", 1);
        object oDevil = GetNearestObjectByTag("ks_abatorru", OBJECT_SELF);
        if (GetIsObjectValid(oDevil))
        {
            if (!GetIsDead(oDevil))
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_AURA_FIRE), oDevil);
                AssignCommand(oDevil, PlaySound("c_devil_bat2"));
                ChangeToStandardFaction(oDevil, STANDARD_FACTION_HOSTILE);
                AssignCommand(oDevil, SpeakString("Argh! My Sphere! Now you shall die!"));
                AssignCommand(oDevil, DetermineCombatRound());
            }
        }
    }

    // fancy VFX
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_BREACH), OBJECT_SELF);
}
