//::///////////////////////////////////////////////
//:: dla_s3_onhitchar
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   B G P Hughes
   OnHit Cast Spell: Self Charge script.
   Items that have this property have a chance of gaining a charge
   when hitting / being hit.
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: April 24, 2006
//:://////////////////////////////////////////////

void main()
{
   // fill the variables
   object oPC          = OBJECT_SELF;
   object oSpellTarget = GetSpellTargetObject();
   object oItem        = GetSpellCastItem();

  if (GetIsObjectValid(oItem))
  {
    int nType = GetBaseItemType(oItem);

  //*****************************Added
    if (nType == BASE_ITEM_ARMOR      || nType == BASE_ITEM_SMALLSHIELD ||
       nType == BASE_ITEM_LARGESHIELD || nType == BASE_ITEM_TOWERSHIELD)
    {  //Kemper style armours/shields like Mail of the Eagle
        effect eVis1 = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
        if (Random(5)<1){
        SetItemCharges(oItem,GetItemCharges(oItem) +1);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis1, oPC);
        SendMessageToPC(oPC,GetName(oItem)+": Charge Gained!");}
    }
    else
    {   //Souldrinker style weapons
        effect eVis1 = EffectVisualEffect(VFX_IMP_HEAD_EVIL);

        //does not work on doors, chests, etc.
        if (Random(10)<1 && GetObjectType(oSpellTarget)==OBJECT_TYPE_CREATURE)
        {
            SetItemCharges(oItem,GetItemCharges(oItem) +1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis1, oPC);
            SendMessageToPC(oPC,GetName(oItem)+": Charge Gained!");
        }
    }

  }
}
