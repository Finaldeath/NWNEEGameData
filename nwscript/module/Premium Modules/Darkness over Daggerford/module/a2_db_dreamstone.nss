void main()
{
    //handle the on use functionality for scripted items
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    location lLocation = GetItemActivatedTargetLocation();
    string sItemUsed = GetTag(oItem);
    effect eWeird = EffectDazed();
    //when the item is the 'Dreamstone'
    if (sItemUsed == "a2_db_dreamstone")
    {
        effect eVisual = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
        //now create the summoned stone creature
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual, lLocation);
        CreateObject(OBJECT_TYPE_CREATURE, "db_animate", lLocation);

        if(GetIsImmune(oPC, IMMUNITY_TYPE_DAZED) == TRUE)
        {
            AssignCommand(oPC, SpeakString("You are protected from the Dreamstone's disorientation effect"));
        }
        else if(GetIsImmune(oPC, IMMUNITY_TYPE_MIND_SPELLS) == TRUE)
        {
            AssignCommand(oPC, SpeakString("You are protected from the Dreamstone's disorientation effect"));
        }
        else if(GetRacialType(oPC)==RACIAL_TYPE_DWARF)
        {
            AssignCommand(oPC, SpeakString("You are protected from the Dreamstone's disorientation effect"));
        }
        else
        {
            AssignCommand(oPC, SpeakString("The sudden contact with the elemental plane of Earth disorientates you..."));
            //apply the disorientate effect to the pc
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWeird, oPC, 15.0f);
            effect eDisorient = EffectVisualEffect(VFX_DUR_IOUNSTONE_GREEN);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDisorient, oPC, 15.0f);
        }
        effect eDespawn = EffectVisualEffect(VFX_FNF_DISPEL_GREATER );
        object oAni = GetObjectByTag("db_animate");
        DelayCommand(90.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDespawn, oAni));
        DestroyObject(GetObjectByTag("db_animate"), 90.5f);
    }
}
