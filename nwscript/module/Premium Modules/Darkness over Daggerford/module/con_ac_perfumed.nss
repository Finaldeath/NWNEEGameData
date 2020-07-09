//::///////////////////////////////////////////////
//:: FileName con_ac_perfumed
//:: Player is perfumed (increased charisma and not "stinky"
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/27/2005 11:20:11 PM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    object oPC = GetPCSpeaker();
    SetLocalInt(GetPCSpeaker(), "perfumed", 1);

    effect eCheck = GetFirstEffect(oPC);
    effect eP = EffectVisualEffect(VFX_IMP_CHARM);
    effect eC = EffectAbilityIncrease(ABILITY_CHARISMA,1);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eP, oPC);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eC, oPC, 2880.0);
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 1.0);
}
