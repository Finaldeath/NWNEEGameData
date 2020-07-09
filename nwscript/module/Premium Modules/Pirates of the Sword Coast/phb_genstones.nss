//::///////////////////////////////////////////////
//:: phb_genstones
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Generate stones on the Boulder placables.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Oct, 2004
//:://////////////////////////////////////////////
const string sStone = "a1_stone";

int DifficultyScaler();

void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetFirstPC();

    int iItems = 0;
    int iPCs = 0;

    // count the objects in the inventory
    object oInventory = GetFirstItemInInventory(oSelf);
    while (GetIsObjectValid(oInventory) == TRUE)
    {
        if (GetTag(oInventory) == sStone)
        {
            iItems++;
        }

        oInventory = GetNextItemInInventory(oSelf);
    }

    // count the number of players
    while (GetIsObjectValid(oPC) == TRUE)
    {
        oPC = GetNextPC();
        iPCs++;
    }

    // Generate material based on number of players
    if (iItems < iPCs)
    {
        CreateItemOnObject(sStone, oSelf);
    }
}

int DifficultyScaler()
{
    int iReturn;

    switch (GetGameDifficulty())
    {
        case GAME_DIFFICULTY_DIFFICULT:
        case GAME_DIFFICULTY_CORE_RULES:
            iReturn = 7;
        break;

        case GAME_DIFFICULTY_NORMAL:
            iReturn = 5;
        break;

        case GAME_DIFFICULTY_EASY:
        case GAME_DIFFICULTY_VERY_EASY:
        default:
            iReturn = 3;
        break;
    }

    return iReturn;
}
