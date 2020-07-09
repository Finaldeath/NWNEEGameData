// check to see if the henchman has a spell memorized

int StartingConditional()
{
    int iResult;

    iResult = GetHasSpell(SPELL_CURE_MINOR_WOUNDS, OBJECT_SELF);
    return iResult;
}
