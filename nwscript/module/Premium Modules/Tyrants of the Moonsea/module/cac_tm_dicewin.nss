//Player has won game of 21 in Gate of Good Fortune casino and gets 2 x stake returned
void main()
{
    int nGold = GetLocalInt(OBJECT_SELF, "HF_GOLD_AMOUNT");

    object oPC = GetPCSpeaker();

    nGold *= 2;

    GiveGoldToCreature(oPC, nGold);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_REFLEX_SAVE_THROW_USE), GetPCSpeaker());
}
