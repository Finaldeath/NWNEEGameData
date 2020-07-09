//:://////////////////////////////////////////////////
//:: c3t_atc_re_flee
//:://////////////////////////////////////////////////
/*
  Area Transition Script for random encounter area
  'retreat' transition trigger.

*/
//:://////////////////////////////////////////////////
//:: Copyright (c) 2005 Bioware Corp.
//:: Created By: Brian Watson for Ossian Studios
//:: Created On: 8/28/2005
//:://////////////////////////////////////////////////

#include "inc_bw_worldmap"

void encComplete(object oPC);

void main()
{
    object oClicker = GetClickingObject();
    float fDelay = 0.0f;

    AssignCommand(oClicker, ClearAllActions(TRUE));

    object oTrigger = GetLocalObject(oClicker, "oWM_RE_Destination");
    int nTDays = GetLocalInt(oClicker, "nWM_RE_TDays");
    int nTHours = GetLocalInt(oClicker, "nWM_RE_nTHours");

/*
    moved this to on exit area script!

    DeleteLocalObject(oClicker, "oWM_RE_Destination");
    DeleteLocalInt(oClicker, "nWM_RE_TDays");
    DeleteLocalInt(oClicker, "nWM_RE_nTHours");

    // MULTIPLAYER HANDLER //
    // remove this variable to clear the 'active' random encounter
    DeleteLocalString(GetModule(), "sWM_RE_ActivePoint");
*/

    // check for fleeing players, or those needing a reward
    if (GetLocalInt(oClicker, "nREComplete") == 0)
    {
        int nNth = 1;
        int nFoundHostile = 0;
        object oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oClicker, nNth, CREATURE_TYPE_IS_ALIVE, TRUE);

        // look for hostile creatures
        while (GetIsObjectValid(oCreature) && (nFoundHostile == 0))
        {
            if (GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oCreature) == 100)
            {
                nFoundHostile = 1;
            }

            nNth += 1;
            oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oClicker, nNth, CREATURE_TYPE_IS_ALIVE, TRUE);
        }

        if (nFoundHostile == 0) // no hostile creatures found
        {
            encComplete(oClicker); // xp reward
            fDelay = 0.8f;
        }
        else                     // hostiles were found!
        {
            // send message, force player to pause
            FloatingTextStringOnCreature("Fleeing...", oClicker, FALSE);
            fDelay = 0.8f;
        }
    }

    // travel, no fade
    if (fDelay == 0.0f)
    {
        MapTravel(oClicker, oTrigger, nTDays, nTHours);
    }
    else
    {
        DelayCommand(fDelay, MapTravel(oClicker, oTrigger, nTDays, nTHours));
    }
}


// give players a message and an xp bonus
void encComplete(object oPC)
{
    object oPlayer = GetFirstFactionMember(oPC);
    int nXPAward = 10;
    int nHD;
    int nXPBonus;
    string sBonus;

    while (GetIsObjectValid(oPlayer))
    {
        if (GetLocalInt(oPlayer, "nREComplete") == 0)
        {
            nHD = GetHitDice(oPlayer);
            nXPBonus = (nXPAward * nHD);

            GiveXPToCreature(oPlayer, nXPBonus);

            SetLocalInt(oPlayer, "nREComplete", 1);

            sBonus = IntToString(nXPBonus);
            FloatingTextStringOnCreature("Encounter defeated: "+sBonus+" XP!", oPlayer, FALSE);
        }

        oPlayer = GetNextFactionMember(oPC);
    }
}
