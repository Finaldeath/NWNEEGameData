//:://////////////////////////////////////////////
//:: exe_a3_vtrfight
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Initiate combat with The Avatar and the
    Sahaugin.
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
    object oWPVtr = GetObjectByTag("A3_TSN_TASINA");
    // JE: Avatar is now spawned in during the previous cutscene script.
    // Now we just need to find the object, and turn in hostile.
    //object oAvatar = CreateObject(OBJECT_TYPE_CREATURE, "potsc_avatar", GetLocation(oWPVtr));
    object oAvatar = GetObjectByTag("potsc_avatar");
    ChangeToStandardFaction(oAvatar, STANDARD_FACTION_HOSTILE);

    object oRealGarm = GetObjectByTag("a1_hench_garm");
    object oRealNisar = GetObjectByTag("a2_hench_nisar");
    object oMasterGarm = GetLastMaster(oRealGarm);
    object oMasterNisar = GetLastMaster(oRealNisar);

    SetLocalInt(OBJECT_SELF, "SAHAUGINTOTAL", 100);
    SetLocalInt(OBJECT_SELF, "SAHAUGINCOUNT", 0);

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

    DelayCommand(1.0f, AssignCommand(oAvatar, DetermineCombatRound(oPC)));
    DelayCommand(5.0f, SummonHelp(oAvatar));
    DelayCommand(10.0f, ExecuteScript("phb_a3_monster", oArea));
}

void SummonHelp(object oAvatar)
{
    object oCursor, oPC, oSahaugin;
    int iCounter, iDifficulty, iShgTotal, iShgCount, iActiveShg;
    location lSpawn;
    string sSpawn;

    // if the hag is dead, end the game.
    if ((GetIsDead(oAvatar) == TRUE) || (GetIsObjectValid(oAvatar) == FALSE))
    {
        //SendMessageToPC(GetFirstPC(), "**SummonHelp called (Hag Dead):");
        //ExecuteScript("", OBJECT_SELF);
    }
    else
    {
        //SendMessageToPC(GetFirstPC(), "**SummonHelp called (Hag Alive):");

        iShgTotal = GetLocalInt(OBJECT_SELF, "SAHAUGINTOTAL");
        iShgCount = GetLocalInt(OBJECT_SELF, "SAHAUGINCOUNT");

        if (iShgCount < iShgTotal)
        {
            //Count the number of Sahaugin in the area.
            iCounter = 0;
            oCursor = GetObjectByTag("a3_shgnwarrior01", iCounter);
            while (GetIsObjectValid(oCursor) == TRUE)
            {
                iCounter++;
                iActiveShg++;
                oCursor = GetObjectByTag("a3_shgnwarrior01", iCounter);
            }

            iCounter = 0;
            oCursor = GetObjectByTag("a3_shgnwarrior02", iCounter);
            while (GetIsObjectValid(oCursor) == TRUE)
            {
                iCounter++;
                iActiveShg++;
                oCursor = GetObjectByTag("a3_shgnwarrior02", iCounter);
            }

            //SendMessageToPC(GetFirstPC(), "**Current Harpys: "
            //    + IntToString(iActiveHarpy));

            //Check the games difficulty rating
            iDifficulty = GetGameDifficulty();
            switch (iDifficulty)
            {
                case GAME_DIFFICULTY_CORE_RULES:
                case GAME_DIFFICULTY_DIFFICULT:
                    iDifficulty = 3;
                break;
                case GAME_DIFFICULTY_NORMAL:
                    iDifficulty = 2;
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

            // create Sahaugin based on the above information.
            for (iCounter = 0; (iCounter + iActiveShg) < iDifficulty; iCounter++)
            {
                oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oAvatar);
                lSpawn = GetLocation(GetNearestObjectByTag("WP_SAHAUGINSPWN", oPC, iCounter++));
                sSpawn = "a3_shgnwarrior0" + IntToString(Random(2)+1);
                oSahaugin = CreateObject(OBJECT_TYPE_CREATURE, sSpawn, lSpawn, TRUE);

                //SendMessageToPC(GetFirstPC(), "**New Harpy Created: "
                //    + GetTag(oHarpy));

                DelayCommand(1.0f, AssignCommand(oSahaugin, DetermineCombatRound(oPC)));
                iShgCount++;
            }

            // do this function recursively until the hag is dead.
            SetLocalInt(OBJECT_SELF, "SAHAUGINCOUNT", iShgCount);
            DelayCommand(10.0f, SummonHelp(oAvatar));
        }
    }
}
