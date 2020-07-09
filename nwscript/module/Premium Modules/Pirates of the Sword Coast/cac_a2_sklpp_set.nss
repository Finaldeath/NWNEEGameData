//::///////////////////////////////////////////////
//:: cac_a2_sklpp_set
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set a dynamic DC for a pick pocket.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oPete = OBJECT_SELF;
    int iDifficulty = 0;
    int iDC = 0;

    switch (GetGameDifficulty())
    {
        case GAME_DIFFICULTY_CORE_RULES :
        case GAME_DIFFICULTY_DIFFICULT :
            iDifficulty = 15;
        break;

        case GAME_DIFFICULTY_NORMAL :
            iDifficulty = 10;
        break;

        case GAME_DIFFICULTY_EASY :
        case GAME_DIFFICULTY_VERY_EASY :
            iDifficulty = 5;
        break;

        default:
            iDifficulty = 10;
        break;
    }

    iDC = iDifficulty + GetHitDice(oPC);

    SetCustomToken(1000, "DC: " + IntToString(iDC));
    SetLocalInt(oPete, "SKILL_PICKPOCKET_DC", iDC);

    ExecuteScript("cac_a2_rpete_d1", oPete);
    ExecuteScript("ww_abil_init", oPete);
}
