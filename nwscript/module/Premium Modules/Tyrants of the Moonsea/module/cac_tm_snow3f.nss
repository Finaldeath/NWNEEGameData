// secret: buried zhent: player casts cure fireball

void main()
{
    object oPC = GetPCSpeaker();
    object oZhent = OBJECT_SELF;

    effect eVis = EffectVisualEffect(VFX_FNF_FIREBALL);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oZhent);
}
