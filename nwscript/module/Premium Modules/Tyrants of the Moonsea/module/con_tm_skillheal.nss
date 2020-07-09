int StartingConditional()
{
    if(GetHasSkill(SKILL_HEAL, GetPCSpeaker()))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
