void main()
{
    //handle the on use functionality for scripted items
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    location lLocation = GetItemActivatedTargetLocation();
    string sItemUsed = GetTag(oItem);

    //when the item is 'White Glove's Perfume'
    if (sItemUsed == "a2_db_perfume")
    {
        effect eVisual = EffectVisualEffect(VFX_DUR_MAGIC_RESISTANCE);
        effect eBluff = EffectSkillIncrease(SKILL_BLUFF, 8);
        effect ePersuade = EffectSkillIncrease(SKILL_PERSUADE, 8);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisual, oPC, 45.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBluff, oPC, 45.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePersuade, oPC, 45.0f);
    }
}
