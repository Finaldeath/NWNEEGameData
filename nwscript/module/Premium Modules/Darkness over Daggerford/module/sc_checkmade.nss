int StartingConditional()
{
    if((GetLocalInt(OBJECT_SELF, "iCheckAttempted") == 0) ||
       (GetLocalInt(OBJECT_SELF, "iCheckAttempted") == 1 &&
        GetAbilityScore(GetPCSpeaker(), ABILITY_STRENGTH) >
                       GetLocalInt(OBJECT_SELF, "iStrength")))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
