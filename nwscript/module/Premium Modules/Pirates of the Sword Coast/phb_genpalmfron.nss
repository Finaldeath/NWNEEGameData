//::///////////////////////////////////////////////
//:: phb_genpalmfron
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Generate tinder on the "Palm Fron" placables.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Oct, 2004
//:://////////////////////////////////////////////
const string sTinder = "a1_tinder";

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
        if (GetTag(oInventory) == sTinder)
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
        if (Random(DifficultyScaler()) == 0)
        {
            CreateItemOnObject(sTinder, oSelf);
        }
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
