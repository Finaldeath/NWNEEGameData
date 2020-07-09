// check to see if the henchman has a spell memorized

int StartingConditional()
{
    int iResult;

    iResult = GetHasSpell(SPELL_CURE_MODERATE_WOUNDS, OBJECT_SELF);
    return iResult;
}
