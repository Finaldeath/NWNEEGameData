//::///////////////////////////////////////////////
//:: FileName con_setrumor7b
//:: Set this rumor to heard. This rumor also allows
//:: player to get the wild elves Maerovyna quest
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 1:05:44 AM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "rumor7b", 1);
    int nD = GetLocalInt(oPC,"drinks");
    effect eW =  EffectAbilityDecrease(ABILITY_WISDOM,1);
    effect eD =  EffectAbilityDecrease(ABILITY_DEXTERITY,1);

    //Actions
    TakeGoldFromCreature(20,GetPCSpeaker());
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));

    nD++;
    SetLocalInt(oPC,"drinks",nD);
    DelayCommand(120.0,SetLocalInt(oPC,"drinks",(nD-1)));
    if (nD > 3)
    {
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 5.0));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eW, oPC, 120.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eD, oPC, 120.0);
    }
}
