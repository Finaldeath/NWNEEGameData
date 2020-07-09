#include "hf_in_skillcheck"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;
    int nSkill = SkillGetSkillNum(oPC, oNPC);
    SkillCheckFail(oPC, oNPC, nSkill);
    return(TRUE);
}
