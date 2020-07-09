int StartingConditional()
{
    if(GetSkillRank(SKILL_LORE, GetPCSpeaker()) >= 5)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
