//::///////////////////////////////////////////////
//:: FileName con_ac_perfumed
//:: Player is perfumed (increased charisma and not "stinky"
//:: This version also takes 50 gold pieces.
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/27/2005 11:20:11 PM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    object oPC = GetPCSpeaker();
    TakeGoldFromCreature(50,oPC);
    SetLocalInt(GetPCSpeaker(), "perfumed", 1);
    effect eP = EffectVisualEffect(VFX_IMP_CHARM);
    effect eC = EffectAbilityIncrease(ABILITY_CHARISMA,1);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eP, oPC);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eC, oPC, 2880.0);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 1.0);

}
