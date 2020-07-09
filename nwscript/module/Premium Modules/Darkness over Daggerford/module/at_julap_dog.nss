// riddles are all done; julap finds his dog
// .. transform Minedi's appearance into a dog

void main()
{
    object oPC = GetPCSpeaker();
    object oJulap = OBJECT_SELF;
    object oMinedi = GetNearestObjectByTag("ks_minedi", oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oMinedi);
    SetCreatureAppearanceType(oMinedi, APPEARANCE_TYPE_DOG);
    AssignCommand(oMinedi, ActionMoveToObject(oJulap));
}
