//:://////////////////////////////////////////////
//:: exe_a3_hagfight
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Initiate combat with Tasina and the Harpies
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"
#include "nw_i0_generic"

void SummonHelp(object oHag);

void main()
{
    object oArea = OBJECT_SELF;
    object oPC = GetFirstPC();
    object oWPTsn = GetObjectByTag("A3_TSN_TASINA");
    object oHag = CreateObject(OBJECT_TYPE_CREATURE, "a3_tashag", GetLocation(oWPTsn));

    object oRealGarm = GetObjectByTag("a1_hench_garm");
    object oRealNisar = GetObjectByTag("a2_hench_nisar");
    object oMasterGarm = GetLastMaster(oRealGarm);
    object oMasterNisar = GetLastMaster(oRealNisar);

    SetLocalInt(OBJECT_SELF, "HARPYTOTAL", 100);
    SetLocalInt(OBJECT_SELF, "HARPYCOUNT", 0);

    if (GetIsObjectValid(oMasterGarm) == TRUE)
    {
        HireHenchman(oMasterGarm, oRealGarm);
    }
    else
    {
        HireHenchman(oPC, oRealGarm);
    }

    if (GetIsObjectValid(oMasterNisar) == TRUE)
    {
        HireHenchman(oMasterNisar, oRealNisar);
    }
    else
    {
        HireHenchman(oPC, oRealNisar);
    }

    DelayCommand(1.0f, AssignCommand(oHag, DetermineCombatRound(oPC)));
    DelayCommand(2.0f, SummonHelp(oHag));
    DelayCommand(10.0f, ExecuteScript("phb_a3_monster", oArea));
}

void SummonHelp(object oHag)
{
    object oCursor, oPC, oHarpy;
    int iCounter, iDifficulty, iHarpTotal, iHarpCount, iActiveHarpy;
    location lSpawn;

    // if the hag is dead, end the game.
    if ((GetIsDead(oHag) == TRUE) || (GetIsObjectValid(oHag) == FALSE))
    {
        //SendMessageToPC(GetFirstPC(), "**SummonHelp called (Hag Dead):");
        ExecuteScript("", OBJECT_SELF);
    }
    else
    {
        //SendMessageToPC(GetFirstPC(), "**SummonHelp called (Hag Alive):");

        iHarpTotal = GetLocalInt(OBJECT_SELF, "HARPYTOTAL");
        iHarpCount = GetLocalInt(OBJECT_SELF, "HARPYCOUNT");

        if (iHarpCount < iHarpTotal)
            {
            //Count the number of Harpies in the area.
            oCursor = GetObjectByTag("a3_clrchrpy", iActiveHarpy++);
            while (GetIsObjectValid(oCursor) == TRUE)
            {
                oCursor = GetObjectByTag("a3_clrchrpy", iActiveHarpy++);
            }

            //SendMessageToPC(GetFirstPC(), "**Current Harpys: "
            //    + IntToString(iActiveHarpy));

            //Check the games difficulty rating
            iDifficulty = GetGameDifficulty();
            switch (iDifficulty)
            {
                case GAME_DIFFICULTY_CORE_RULES:
                case GAME_DIFFICULTY_DIFFICULT:
                    iDifficulty = 4;
                break;
                case GAME_DIFFICULTY_NORMAL:
                    iDifficulty = 3;
                break;
                default:
                    iDifficulty = 2;
                break;
            }

            //SendMessageToPC(GetFirstPC(), "**Difficulty Adjustment: "
            //    + IntToString(iDifficulty));

            //count how many players are in the game.
            oCursor = GetFirstPC();
            while (GetIsObjectValid(oCursor) == TRUE)
            {
                iDifficulty += 1;
                oCursor = GetNextPC();
            }

            //SendMessageToPC(GetFirstPC(), "**Difficulty Adjustment (including PCs): "
            //    + IntToString(iDifficulty));

            // create harpys based on the above information.
            for (iCounter = 0; (iCounter + iActiveHarpy) < iDifficulty; iCounter++)
            {
                oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oHag);
                lSpawn = GetLocation(GetNearestObjectByTag("WP_SAHAUGINSPWN", oPC, iCounter++));
                oHarpy = CreateObject(OBJECT_TYPE_CREATURE, "a3_clrchrpy", lSpawn, TRUE);

                //SendMessageToPC(GetFirstPC(), "**New Harpy Created: "
                //    + GetTag(oHarpy));

                DelayCommand(1.0f, AssignCommand(oHarpy, DetermineCombatRound(oPC)));
                iHarpCount++;

            }

            // do this function recursively until the hag is dead.
            SetLocalInt(OBJECT_SELF, "HARPYCOUNT", iHarpCount);
            DelayCommand(10.0f, SummonHelp(oHag));
        }
    }
}
