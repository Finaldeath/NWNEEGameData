//::///////////////////////////////////////////////
//:: Act 0: Turf War Buff
//:: cac_a0_turf_buff.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Have the sorceror from the friendly turf war
     faction buff the player up.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: April 22, 2005
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();

    ActionCastSpellAtObject(SPELL_RESISTANCE, oPC, METAMAGIC_NONE, TRUE);
    ActionCastSpellAtObject(SPELL_GHOSTLY_VISAGE, oPC, METAMAGIC_NONE, TRUE);
    ActionCastSpellAtObject(SPELL_HASTE, oPC, METAMAGIC_NONE, TRUE);
    ActionCastSpellAtObject(SPELL_REGENERATE, oPC, METAMAGIC_NONE, TRUE);
}
