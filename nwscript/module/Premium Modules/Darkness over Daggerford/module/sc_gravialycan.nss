int StartingConditional()
{
    if((GetLocalInt(OBJECT_SELF, "iRevealedLycan") == 1) &&
       (GetSkillRank(SKILL_LORE, GetPCSpeaker()) >= 5 ||
        GetLevelByClass(CLASS_TYPE_CLERIC, GetPCSpeaker()) > 0))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
