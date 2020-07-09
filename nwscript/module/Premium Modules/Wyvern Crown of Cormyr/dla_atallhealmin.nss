// September 2005
// B W-Husey
// Generic heal script - heals speaking PC 26-33 hit points, and those of
// familliar, summoned creature and up to 4 henchmen.

// This does all the healing - in a function so I can delay it
void ActionHeal(object xPlayer)
{
 AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_CURE_CRITICAL_WOUNDS,xPlayer));
 int xPlayerHP;
 effect xPlayerHeal;
 effect xHealVis = EffectVisualEffect(VFX_IMP_HEALING_X);
 //Set how much to heal
 xPlayerHP = Random(8)+25;
 //Create the heal effect
 xPlayerHeal = EffectHeal(xPlayerHP);
 //Perform the heal and the effect
 ApplyEffectToObject(DURATION_TYPE_INSTANT,xHealVis,xPlayer);
 ApplyEffectToObject(DURATION_TYPE_INSTANT,xPlayerHeal,xPlayer);
 object oAssociate = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, GetPCSpeaker());
 ApplyEffectToObject(DURATION_TYPE_INSTANT,xHealVis,oAssociate);
 ApplyEffectToObject(DURATION_TYPE_INSTANT,xPlayerHeal,oAssociate);
 oAssociate = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, GetPCSpeaker(),2);
 ApplyEffectToObject(DURATION_TYPE_INSTANT,xHealVis,oAssociate);
 ApplyEffectToObject(DURATION_TYPE_INSTANT,xPlayerHeal,oAssociate);
 oAssociate = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, GetPCSpeaker(),3);
 ApplyEffectToObject(DURATION_TYPE_INSTANT,xHealVis,oAssociate);
 ApplyEffectToObject(DURATION_TYPE_INSTANT,xPlayerHeal,oAssociate);
 oAssociate = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, GetPCSpeaker(),4);
 ApplyEffectToObject(DURATION_TYPE_INSTANT,xHealVis,oAssociate);
 ApplyEffectToObject(DURATION_TYPE_INSTANT,xPlayerHeal,oAssociate);
 oAssociate = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, GetPCSpeaker());
 ApplyEffectToObject(DURATION_TYPE_INSTANT,xHealVis,oAssociate);
 ApplyEffectToObject(DURATION_TYPE_INSTANT,xPlayerHeal,oAssociate);
 oAssociate = GetAssociate(ASSOCIATE_TYPE_SUMMONED, GetPCSpeaker());
 ApplyEffectToObject(DURATION_TYPE_INSTANT,xHealVis,oAssociate);
 ApplyEffectToObject(DURATION_TYPE_INSTANT,xPlayerHeal,oAssociate);
 oAssociate = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, GetPCSpeaker());
 ApplyEffectToObject(DURATION_TYPE_INSTANT,xHealVis,oAssociate);
 ApplyEffectToObject(DURATION_TYPE_INSTANT,xPlayerHeal,oAssociate);
}

void main()
{
 ActionPauseConversation();
 //Set the variables
 object oPC = GetPCSpeaker();
    DelayCommand(1.5,ActionHeal(oPC));

    DelayCommand(3.5,ActionResumeConversation());
}

