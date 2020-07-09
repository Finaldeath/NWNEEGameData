#include "hf_in_skillcheck"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetGold(oPC) < 100)
    {
        return FALSE;
    }
    else
    {
        object oNPC = OBJECT_SELF;
        int nSkill = SKILL_APPRAISE;
        SkillSetSkillNum(oPC, oNPC, nSkill);
        if (SkillCanRetry(oPC, oNPC, nSkill))
            return(TRUE);
        return(SkillCanAttempt(oPC, oNPC, nSkill));
    }
}
