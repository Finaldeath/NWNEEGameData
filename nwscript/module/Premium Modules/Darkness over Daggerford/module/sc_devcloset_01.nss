// is the player a mage or sorc?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nWiz = GetLevelByClass(CLASS_TYPE_WIZARD, oPC);
    int nSor = GetLevelByClass(CLASS_TYPE_SORCERER, oPC);
    return (nWiz > 0 || nSor > 0);
}
