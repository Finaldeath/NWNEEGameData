void main()
{
    int nEvent = GetUserDefinedEventNumber();

    if (nEvent == 500) // burn
    {
        int nNth = 1;
        object oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, nNth);
        float fDist = GetDistanceToObject(oCreature);

        float fRange = 4.0f;

        effect eVFX = EffectVisualEffect(VFX_IMP_FLAME_M);
        effect eBurn = EffectDamage(d6(6), DAMAGE_TYPE_FIRE);

        while (GetIsObjectValid(oCreature) && (fDist >= 0.0f) && (fDist <= fRange))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oCreature);
            DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBurn, oCreature));

            nNth += 1;
            oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, nNth);
            fDist = GetDistanceToObject(oCreature);
        }
    }
}
