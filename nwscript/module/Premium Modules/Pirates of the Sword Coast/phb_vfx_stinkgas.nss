//::///////////////////////////////////////////////
//:: phb_vfx_stinkgas
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Emit a stinking Gas visual effect to represent
    the Troglodyte stench.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
void main()
{
    object oSelf = OBJECT_SELF;
    effect eCloud = EffectVisualEffect(517);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCloud, oSelf, 8.0f);

}
