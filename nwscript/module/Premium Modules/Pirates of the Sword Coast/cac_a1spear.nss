//::///////////////////////////////////////////////
//:: cac_a1spear
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Create a spear based of the players craft
    skill.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oStick = GetItemPossessedBy(oPC, "a1_stick_long");
    int iDoOnce = GetLocalInt(GetModule(), "CRAFT_A1_SPEAR");
    int iCounter = GetLocalInt(GetModule(), "CRAFT_A1_COUNTER");
    int iResult, iDifficulty;

    ActionPauseConversation();

    if (GetIsObjectValid(oStick) == TRUE)
    {
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

        DestroyObject(oStick);
        iResult = GetIsSkillSuccessful(oPC, SKILL_CRAFT_WEAPON, iDifficulty);

        if(iResult == TRUE)
        {
            CreateItemOnObject("a1_firespear_s", oPC);
        }
        else
        {
            CreateItemOnObject("a1_firespear", oPC);
        }

        if (iDoOnce == FALSE)
        {
            SetLocalInt(GetModule(), "CRAFT_A1_SPEAR", TRUE);
            SetLocalInt(GetModule(), "CRAFT_A1_COUNTER", (iCounter + 1));
        }
    }

    ActionResumeConversation();
}
