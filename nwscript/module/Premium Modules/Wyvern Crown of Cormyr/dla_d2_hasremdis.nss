// check to see if the henchman has a feat available

int StartingConditional()
{
    int iResult;

    iResult = GetHasFeat(FEAT_REMOVE_DISEASE, OBJECT_SELF);
    return iResult;
}
