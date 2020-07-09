//Give HF_SKILL_XP amount on successful Insight checks
void main()
{
    if(GetLocalInt(OBJECT_SELF, "nInsightXPAwarded") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nInsightXPAwarded", 1);
        GiveXPToCreature(GetPCSpeaker(), GetLocalInt(GetModule(), "HF_SKILL_XP"));
    }
}
