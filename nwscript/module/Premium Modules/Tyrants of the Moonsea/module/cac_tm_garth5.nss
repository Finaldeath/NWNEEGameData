//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_garth5
// DATE: March 17, 2006.
// AUTH: Luke Scull
// NOTE: Get Garth to heal Elf, resume conversation.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_plot"
#include "cut_tm_arena_inc"

void main()
{
    object oGarth = OBJECT_SELF;
    object oElf = GetNearestObjectByTag(NPC_TAG_ELF);
    object oPC = GetPCSpeaker();
    
    PlotLevelSet("Elf-Arena-Outcome", 0); // Elf is healed

    ActionPauseConversation();

    // Heal Elf
    AssignCommand(oGarth, ActionCastSpellAtObject(SPELL_HEAL, oElf,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE));
    DelayCommand(2.0, AssignCommand(oElf, ClearAllActions()));
    DelayCommand(2.5, AssignCommand(oElf, ActionPlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 1.0)));
    
    DelayCommand(3.0, ActionResumeConversation());
}
