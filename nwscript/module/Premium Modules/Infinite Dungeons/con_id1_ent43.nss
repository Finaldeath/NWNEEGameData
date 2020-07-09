int StartingConditional()
{
    int nPreset = GetLocalInt(GetModule(), "nPreset");
    if (nPreset == 1)
    {
        SetCustomToken(5201, "The dungeon is currently customized for Fighter-type characters. It will feature heavier armor and martial weapons, as well as increased numbers of creatures.");
    } else if (nPreset == 2)
    {
        SetCustomToken(5201, "The dungeon is currently customized for Rogue-type characters. It will feature lighter weapons and armor and more traps and secret areas.");
    } else if (nPreset == 3)
    {
        SetCustomToken(5201, "The dungeon is currently customized for Mage-type characters. It will feature no heavy armor or weapons, but increased numbers of mage-specific items.");
    } else
    {
        SetCustomToken(5201, "The dungeon is currently set to default settings. Anything can appear in the dungeon.");
    }

    return TRUE;
}

