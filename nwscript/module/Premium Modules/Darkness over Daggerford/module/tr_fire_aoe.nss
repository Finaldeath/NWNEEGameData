// a creature has entered a fire area in edalseye's tower

void main()
{
    if (GetLocalInt(OBJECT_SELF, "nActive") != 0)
    {
        object oEnter = GetEnteringObject();
        if (GetTag(oEnter) != "ks_mephit_fire" &&
            GetTag(oEnter) != "ks_mephit_ice")
        {
            effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
            effect eDmg = EffectDamage(d6()+3, DAMAGE_TYPE_FIRE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oEnter);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oEnter);
        }
    }
}
