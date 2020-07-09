#include "hf_in_skillcheck"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;
    int nSkill = SkillGetSkillNum(oPC, oNPC);
    SkillCheck(oPC, oNPC, nSkill, TRUE);
    return(TRUE);
}
