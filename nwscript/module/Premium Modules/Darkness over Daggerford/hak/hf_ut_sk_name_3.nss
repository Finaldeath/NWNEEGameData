// sets the name of the current dialog branch
// ... this is needed when you have multiple skill checks of the same type
// ... in the same dialog (at different "branch" levels)

#include "hf_in_skillcheck"

void main()
{
    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;
    SkillSetBranchName(oPC, oNPC, "3");
}
