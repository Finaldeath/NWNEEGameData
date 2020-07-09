//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ndm_tm_karim
//:: DATE: January 12, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: OnDamage Script for Karim Ninetrees
//:: Will switch to Bear form when HP below 50%
//::////////////////////////////////////////////////////


void main()
{
    int nMaxHP = GetMaxHitPoints();
    int nCurrentHP = GetCurrentHitPoints();

    if ( (IntToFloat(nCurrentHP) <= IntToFloat(nMaxHP)*0.5) &&
         (GetLocalInt(OBJECT_SELF, "nDone") == 0) )
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);

        effect ePoly = EffectPolymorph(POLYMORPH_TYPE_DIRE_BROWN_BEAR);
        effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
        effect eHeal = EffectHeal(nMaxHP);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, ePoly, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHeal, OBJECT_SELF);
    }

    ExecuteScript("nw_c2_default6", OBJECT_SELF);
}
