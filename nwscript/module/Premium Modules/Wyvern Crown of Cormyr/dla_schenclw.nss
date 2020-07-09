// check to see if the henchman has a spell memorized

int StartingConditional()
{
    int iResult;

    iResult = GetHasSpell(SPELL_CURE_LIGHT_WOUNDS, OBJECT_SELF);
    return iResult;
}
