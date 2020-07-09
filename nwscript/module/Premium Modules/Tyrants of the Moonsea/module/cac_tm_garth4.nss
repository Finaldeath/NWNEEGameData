//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_garth4
// DATE: March 17, 2006
// AUTH: Luke Scull
// NOTE: Pause conversation, then get Garth to cast a
//       block of buffing spells on the PC before
//       resuming.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_plot"
#include "cut_tm_arena_inc"

void main()
{
    object oGarth = OBJECT_SELF;
    object oElf = GetNearestObjectByTag(NPC_TAG_ELF);
    object oPC = GetPCSpeaker();

    PlotLevelSet("Elf-Arena-Outcome", 1); // Elf is sacrificed

    ActionPauseConversation();

    // These spells should pretty much guarantee the player can defeat the Minotaur
    ActionCastFakeSpellAtObject(SPELL_WORD_OF_FAITH, oPC);
    DelayCommand(2.5, AssignCommand(oGarth, ActionCastSpellAtObject(SPELL_REGENERATE, oPC,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
    DelayCommand(2.5, AssignCommand(oGarth, ActionCastSpellAtObject(SPELL_BATTLETIDE, oPC,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
    DelayCommand(2.5, AssignCommand(oGarth, ActionCastSpellAtObject(SPELL_DIVINE_POWER, oPC,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
    DelayCommand(2.5, AssignCommand(oGarth, ActionCastSpellAtObject(SPELL_BLESS, oPC,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
    DelayCommand(2.5, AssignCommand(oGarth, ActionCastSpellAtObject(SPELL_OWLS_WISDOM, oPC,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
    DelayCommand(2.5, AssignCommand(oGarth, ActionCastSpellAtObject(SPELL_ENDURANCE, oPC,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
    DelayCommand(2.5, AssignCommand(oGarth, ActionCastSpellAtObject(SPELL_BULLS_STRENGTH, oPC,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
    DelayCommand(2.5, AssignCommand(oGarth, ActionCastSpellAtObject(SPELL_BARKSKIN, oPC,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));

    DelayCommand(3.0, ActionResumeConversation());
}
