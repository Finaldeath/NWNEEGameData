// set the current skill

#include "hf_in_skillcheck"

void main()
{
    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;
    int nSkill = SKILL_PICK_POCKET;
    SkillSetSkillNum(oPC, oNPC, nSkill);
}
