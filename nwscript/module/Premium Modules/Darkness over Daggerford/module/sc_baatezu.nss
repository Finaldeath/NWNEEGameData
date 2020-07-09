int StartingConditional()
{
    if(GetSkillRank(SKILL_LORE, GetPCSpeaker()) >= 5 ||
       GetLevelByClass(CLASS_TYPE_PALADIN, GetPCSpeaker()) > 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
