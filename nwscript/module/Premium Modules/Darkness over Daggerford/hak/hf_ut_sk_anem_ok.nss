// returns false if the skill was previously attempted
// ... also sets-up the correct skill variable for the upcoming check

#include "hf_in_skillcheck"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;
    int nSkill = SKILL_ANIMAL_EMPATHY;
    SkillSetSkillNum(oPC, oNPC, nSkill);
    if (SkillCanRetry(oPC, oNPC, nSkill))
        return(TRUE);
    return(SkillCanAttempt(oPC, oNPC, nSkill));
}
