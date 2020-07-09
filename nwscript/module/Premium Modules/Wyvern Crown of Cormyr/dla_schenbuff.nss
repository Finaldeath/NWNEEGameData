// B W-Husey
// Spellcasting class

int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    if(GetLevelByClass(CLASS_TYPE_CLERIC, OBJECT_SELF) >= 1)
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_SORCERER, OBJECT_SELF) >= 1))
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_WIZARD, OBJECT_SELF) >= 1))
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_DRUID, OBJECT_SELF) >= 1))
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_BARD, OBJECT_SELF) >= 1))
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_RANGER, OBJECT_SELF) >= 5))
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_PALADIN, OBJECT_SELF) >= 5))
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
