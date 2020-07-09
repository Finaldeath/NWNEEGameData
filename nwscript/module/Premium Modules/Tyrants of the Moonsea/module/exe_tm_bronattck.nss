//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: exe_tm_bronattck
// DATE: August 31, 2005
// AUTH: Luke Scull
// NOTE: Buffs Bron (to represent Zhent mage cheating)
//       and causes him to attack.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "nw_i0_generic"

void main()
{
    // Define objects
    object oBron = GetObjectByTag("TheBron");
    object oMage = GetObjectByTag("ZhentarimMage");
    object oPC = GetFirstPC();

    // Clear actions and remove Bron's plot flag
    AssignCommand(oBron, ClearAllActions());
    AssignCommand(oMage, ClearAllActions());

    SetPlotFlag(oBron, FALSE);

    DelayCommand(1.0, AssignCommand(oBron, SpeakString("I'll make you sorry you ever crossed me!", TALKVOLUME_SHOUT)));

    // Buff him up since Zents don't play fair
    AssignCommand(oBron, ActionCastSpellAtObject(SPELL_BULLS_STRENGTH, OBJECT_SELF,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    AssignCommand(oBron, ActionCastSpellAtObject(SPELL_CATS_GRACE, OBJECT_SELF,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    AssignCommand(oBron, ActionCastSpellAtObject(SPELL_HASTE, OBJECT_SELF,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

    // Get Bron to attack PC
    DelayCommand(2.0, AssignCommand(oBron, SetIsTemporaryEnemy(oPC)));
    DelayCommand(2.1, AssignCommand(oBron, DetermineCombatRound()));
    DelayCommand(2.2, AssignCommand(oBron, ActionAttack(oPC)));
}
