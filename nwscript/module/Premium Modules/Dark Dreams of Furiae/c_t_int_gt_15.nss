// is INT > 15

int StartingConditional()
{
    int _int = GetAbilityScore(GetPCSpeaker(), ABILITY_INTELLIGENCE);

    if(_int > 15) return TRUE;
    return FALSE;
}
