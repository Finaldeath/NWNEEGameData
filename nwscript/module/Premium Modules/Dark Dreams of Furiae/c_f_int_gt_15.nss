// if int <= 15

int StartingConditional()
{
    int iResult = GetAbilityScore(GetPCSpeaker(), ABILITY_INTELLIGENCE);
    if(iResult <= 15) return TRUE;
    return FALSE;

}
