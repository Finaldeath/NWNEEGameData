//::///////////////////////////////////////////////
//:: con_a1_crftchk
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    craft skill check based on game difficulty.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iDifficulty, iResult;
    int iRank = GetSkillRank(SKILL_CRAFT_WEAPON, oPC);
    int iD20 = Random(20)+1;

    switch (GetGameDifficulty())
    {
        case(GAME_DIFFICULTY_DIFFICULT):
        case(GAME_DIFFICULTY_CORE_RULES):
            iDifficulty = 21;
        break;
        case(GAME_DIFFICULTY_NORMAL):
            iDifficulty = 17;
        break;
        case(GAME_DIFFICULTY_EASY):
        case(GAME_DIFFICULTY_VERY_EASY):
            iDifficulty = 10;
        break;
    }

    //Fake the Skill check to avoid the misleading feedback message.
    if (GetHasFeat(FEAT_SKILL_MASTERY, oPC) == TRUE)
    {
        iD20 = 20;
    }
    if (iRank == -1 ||
        iRank + iD20 < iDifficulty)
    {
        iResult = FALSE;
    }
    else
    {
        iResult = TRUE;
    }

    return iResult;
}
