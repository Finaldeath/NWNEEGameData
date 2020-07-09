// Set Nosfiraat quest to started

void ActivateStone(string sTag)
{
    object oStone = GetObjectByTag(sTag);
    SetPlotFlag(oStone, FALSE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GLOW_RED), oStone);
}

void main()
{
    ActivateStone("am_ar2000_rune1");
    ActivateStone("am_ar2000_rune2");
    ActivateStone("am_ar2000_rune3");

    SetLocalInt(GetPCSpeaker(), "ac_nosfiraat_qst", 1);
}
