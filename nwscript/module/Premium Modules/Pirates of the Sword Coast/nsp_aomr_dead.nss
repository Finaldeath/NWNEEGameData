void main()
{
    object oSelf = OBJECT_SELF;
    effect eDead = EffectDeath(FALSE, FALSE);

    ExecuteScript("nw_default9", oSelf);

    SetIsDestroyable(FALSE, FALSE, TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDead, oSelf);
}
