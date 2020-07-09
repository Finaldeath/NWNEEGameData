// the player has killed one of abatorru's minions in AR1110
// .. after 3/4 of them are killed, abatorru joins the fight

#include "nw_i0_generic"

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    int nCount = GetLocalInt(oArea, "nVrocksDead");
    SetLocalInt(oArea, "nVrocksDead", ++nCount);
    if (nCount >= 3)
    {
        if (GetLocalInt(oArea, "nAbatorruHostile") == 0)
        {
            SetLocalInt(oArea, "nAbatorruHostile", 1);
            object oDevil = GetNearestObjectByTag("ks_abatorru", OBJECT_SELF);
            if (GetIsObjectValid(oDevil))
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_AURA_FIRE), oDevil);
                AssignCommand(oDevil, PlaySound("c_devil_bat2"));
                ChangeToStandardFaction(oDevil, STANDARD_FACTION_HOSTILE);
                AssignCommand(oDevil, DetermineCombatRound());
            }
        }
    }
}
