//::///////////////////////////////////////////////
//:: dla_s3_onhitsoul
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   OnHit Cast Spell: Soulsucker
   Items that have this property have a chance of
   doing massive damage (2d12) and applying a penalty of
   5 to the contitution of the creature being hit.
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: April 24, 2006
//:://////////////////////////////////////////////

void main()
{
     object  oPC          = OBJECT_SELF;
     object  oSpellTarget = GetSpellTargetObject();
     object  oItem        = GetSpellCastItem();

     effect eVis1  = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
     effect eVis2  = EffectVisualEffect(VFX_IMP_DEATH);
     effect eDam   = EffectDamage(2*d12(),DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_TWO);

     effect eLink  = EffectLinkEffects(eVis2,eDam);
            eLink  = EffectLinkEffects(eVis1,eLink);

     effect eDrain = EffectAbilityDecrease(ABILITY_CONSTITUTION,5);

     //does not work on doors, chests, etc. Needs charges to work
     if ( Random(20)<1 && GetObjectType(oSpellTarget)==OBJECT_TYPE_CREATURE && GetItemCharges(oItem)>0)
     {
         SetItemCharges(oItem,GetItemCharges(oItem) -1);
         ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oSpellTarget);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDrain, oSpellTarget, RoundsToSeconds(1));
         SendMessageToPC(oPC,GetName(oItem)+": Charge Used");
     }
}
