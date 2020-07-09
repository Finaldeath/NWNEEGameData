void main()
{
    object oPC = GetPCSpeaker();
    object oSelf = OBJECT_SELF;
    SetPlotFlag(oSelf, FALSE);
    int nHits = GetCurrentHitPoints(oSelf) - 1;
    if (nHits > 0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nHits), oSelf);
    }
    AssignCommand(oPC, ActionAttack(oSelf));
}
