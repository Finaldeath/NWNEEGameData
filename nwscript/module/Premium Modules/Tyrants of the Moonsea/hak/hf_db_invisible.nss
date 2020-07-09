// debug script to make the player invisible
// .. used to make load screens or take screen shots

void main()
{
    object oPC = GetFirstPC();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oPC, 10.0);
}
