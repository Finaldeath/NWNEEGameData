//::///////////////////////////////////////////////
//:: con_a1_hasfire
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have the ability to cast a fire
    spell?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iResult = FALSE;

    if  ((GetHasSpell(SPELL_FLAME_ARROW, oPC) > 0)
      || (GetHasSpell(SPELL_FLAME_LASH, oPC) > 0)
      || (GetHasSpell(SPELL_FLAME_STRIKE, oPC) > 0)
      || (GetHasSpell(SPELL_BURNING_HANDS, oPC) > 0)
      || (GetHasSpell(SPELL_FIRE_STORM, oPC) > 0)
      || (GetHasSpell(SPELL_FIREBALL, oPC) > 0)
      || (GetHasSpell(SPELL_FIREBRAND, oPC) > 0)
      || (GetHasSpell(SPELL_INFERNO, oPC) > 0)
      || (GetHasSpell(SPELL_COMBUST, oPC) > 0)
      || (GetHasSpell(SPELL_SHADES_FIREBALL, oPC) > 0)
      || (GetHasSpell(SPELL_SHADES_WALL_OF_FIRE, oPC) > 0)
      || (GetHasSpell(SPELL_WALL_OF_FIRE, oPC) > 0))
    {
        iResult = TRUE;
    }

    return iResult;
}
