//Transform Ezril into Malaugrym
void main()
{
    object oEremuth = OBJECT_SELF;

    ActionPauseConversation();

    SetPortraitResRef(oEremuth, "po_malaugrym_");

    ActionPlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 4.0);
    ActionDoCommand(
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(EFFECT_TYPE_POLYMORPH), oEremuth));
    ActionDoCommand(SetCreatureAppearanceType(oEremuth, 15036)); // Malaugrym appearance

    ActionResumeConversation();
}
