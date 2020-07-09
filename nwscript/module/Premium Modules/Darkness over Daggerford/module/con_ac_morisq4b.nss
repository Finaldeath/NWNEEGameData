//::///////////////////////////////////////////////
//:: FileName con_ac_morisq4b
//:: Player kills Elveronne with holy water
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/13/2005 11:59:20 PM
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "rb_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oE = OBJECT_SELF;
    effect eF = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
    effect eD = EffectDeath(TRUE);
    SetLocalInt(oPC, "moris_quest", 4);
    SetLocalInt(OBJECT_SELF, "no_banter", 1);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eF, oE);
    ActionMoveAwayFromObject(oPC);
    DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eD, oE));

    TakeSingleItem(oPC, "X1_WMGRENADE005");;
}
