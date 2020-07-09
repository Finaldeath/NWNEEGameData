// do a skill check
// ... the skill to check must be setup in a previous script

#include "hf_in_skillcheck"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;
    int nSkill = SkillGetSkillNum(oPC, oNPC);
    return(SkillCheck(oPC, oNPC, nSkill));
}
