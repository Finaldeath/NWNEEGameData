//:://////////////////////////////////////////////////
//:: a3_ou_wm_locale
//:://////////////////////////////////////////////////
/*
  OnUsed Script for world map placeables.

*/
//:://////////////////////////////////////////////////
//:: Copyright (c) 2005 Bioware Corp.
//:: Created By: Brian Watson for Ossian Studios
//:: Created On: 8/28/2005
//:://////////////////////////////////////////////////

#include "inc_bw_worldmap"

void main()
{
    object oUser = GetLastUsedBy();
    object oModule = GetModule();

    string sTag = GetTag(OBJECT_SELF);
    string sPreviousArea = GetLocalString(oUser, "sWM_PreviousArea");
    string sTravelArea;
    string sTrigger = "";

    int nTDays = 0;
    int nTHours = 0;
    int nRandomChance = 0;

    string sRandomLoc;

    if (sTag == "wmi_cancel")                // this is the 'cancel' placeable
    {
        // return to associated trigger, stored on user in transition
        sTrigger = GetLocalString(oUser, "sWM_PreviousTrig");
    }
    else
    {
        if (GetStringRight(sTag, 2) == "_r") // if this is a revealed area
        {
            string sSuffix = GetStringRight(sTag, 10);
            sTravelArea = GetStringLeft(sSuffix, 8);

            string sAdjArea = GetLocalString(oUser, "sWM_AdjacentArea");

            if (sTravelArea == sAdjArea) // player is adjacent to chosen travel destination
            {
                // ...it should now become a visible area
                string sVariableName = ("nWM_" + sTravelArea + "_status");
                SetLocalInt(oModule, sVariableName, nWM_VISIBLE);

                /* // DEBUG
                SendMessageToPC(oUser, "DEBUG: Area now visible: " + sTravelArea);
                // DEBUG */

                // DelayCommand(1.0, UpdateWorldMap());
                AssignCommand(oModule, DelayCommand(1.0, UpdateWorldMap()));
            }
            else
            {
                // not adjacent to revealed area, we can't travel here
                PlaySound("gui_nowalk");
                return;
            }
        }
        else                                 // ...otherwise already visible
        {
            sTravelArea = GetStringRight(sTag, 8);
        }

        if (sPreviousArea == sTravelArea)    // returning to previous area
        {
            // return to associated trigger, stored on user in transition
            sTrigger = GetLocalString(oUser, "sWM_PreviousTrig");
        }
        else
        {
            int nRow = 0;
            int nPrevAreaRow = -1;
            string sLookup = Get2DAString(sWM_TRAVEL2DA, sWM_TRAVEL2DA_AREA, nRow);
            while ((sLookup != "") && (nPrevAreaRow == -1))
            {
                if (sLookup == sPreviousArea) // found previous area
                {
                    nPrevAreaRow = nRow;
                }
                nRow += 1;
                sLookup = Get2DAString(sWM_TRAVEL2DA, sWM_TRAVEL2DA_AREA, nRow);
            }

            if (nPrevAreaRow == -1)
            {
                // DEBUG
                SendMessageToPC(oUser, "DEBUG: Cannot locate previous location!");
                return;
                // DEBUG
            }

            string sTravelData = Get2DAString(sWM_TRAVEL2DA, sTravelArea, nPrevAreaRow);    // ex: 0.12.North.TN.30
            int sDataLength = GetStringLength(sTravelData);

            if ((sDataLength > 15) || (sDataLength < 14))
            {
                // DEBUG
                SendMessageToPC(oUser, "DEBUG: Travel data format unexpected!");
                SendMessageToPC(oUser, "DEBUG: sTravelArea" + sTravelArea);
                SendMessageToPC(oUser, "DEBUG: sTravelData: " + sTravelData);
                return;
                // DEBUG
            }
            else
            {
                // this will be a string 4/5 char's long, a cardinal direction
                int nDirLength = (sDataLength - 10);

                string sTDays = GetStringLeft(sTravelData, 1);                 // ex: 1
                string sTHours = GetSubString(sTravelData, 2, 2);              // ex: 14
                string sTDirection = GetSubString(sTravelData, 5, nDirLength); // ex: North

                string sRandomData = GetStringRight(sTravelData, 4);           // ex: TN.1
                sRandomLoc = GetStringLeft(sRandomData, 2);                    // ex: TN
                string sRandomChance = GetStringRight(sRandomData, 1);         // ex: 1

                nTDays = StringToInt(sTDays);
                nTHours = StringToInt(sTHours);

                nRandomChance = StringToInt(sRandomChance);
                if (nRandomChance > 0) // random encounter is possible
                {
                    int nTotalHours = (nTDays * 24);
                    nTotalHours = (nTotalHours + nTHours);

                    // still possible to get a 0 chance, if total hours traveled is 0
                    nRandomChance = (nRandomChance * nTotalHours * nWM_RE_CHANCE);
                    if (nRandomChance > nWM_RE_MAX_CHANCE) nRandomChance = nWM_RE_MAX_CHANCE;
                }

                nRow = 0;
                int nNextAreaRow = -1;
                sLookup = Get2DAString(sWM_MAP2DA, sWM_MAP2DA_AREA, nRow);
                while ((sLookup != "") && (nNextAreaRow == -1))
                {
                    if (sLookup == sTravelArea) // found destination area
                    {
                        nNextAreaRow = nRow;
                    }
                    nRow += 1;
                    sLookup = Get2DAString(sWM_MAP2DA, sWM_MAP2DA_AREA, nRow);
                }

                if (nNextAreaRow == -1)
                {
                    // DEBUG
                    SendMessageToPC(oUser, "DEBUG: Cannot locate next location!");
                    return;
                    // DEBUG
                }

                string sExit = ("Exit_" + sTDirection);
                sTrigger = Get2DAString(sWM_MAP2DA, sExit, nNextAreaRow);
                if (nWM_JUMPCAPS == TRUE) sTrigger = GetStringUpperCase(sTrigger);

                /*
                // this may help determine what's going wrong
                // if there are any world map errors - bw
                //
                // DEBUG
                string sTotalChance = IntToString(nRandomChance);
                SendMessageToPC(oUser, "DEBUG: sTDays: " + sTDays);
                SendMessageToPC(oUser, "DEBUG: sTHours: " + sTHours);
                SendMessageToPC(oUser, "DEBUG: sTDirection: " + sTDirection);
                SendMessageToPC(oUser, "DEBUG: sRandomLoc: " + sRandomLoc);
                SendMessageToPC(oUser, "DEBUG: sRandomChance: " + sRandomChance);
                SendMessageToPC(oUser, "DEBUG: sExit: " + sExit);
                SendMessageToPC(oUser, "DEBUG: sTravelArea: " + sTravelArea);
                SendMessageToPC(oUser, "DEBUG: sTrigger: " + sTrigger + ".");
                SendMessageToPC(oUser, "DEBUG: sTotalChance: " + sTotalChance);
                // DEBUG
                */
            }
        }
    }

    object oTrigger = GetObjectByTag(sTrigger);

    if (GetIsObjectValid(oTrigger))
    {
        if (nRandomChance == 99) nRandomChance = 100; // chance a 2-digit #

        int nRoll = d100();

        // MULTIPLAYER HANDLER //
        // if the last player to travel went to the same
        // destination, and that player is not the current traveler...
        if ((GetLocalObject(oModule, "oWM_LastDestination") == oTrigger) &&
            (GetLocalObject(oModule, "oWM_LastTraveler") != oUser))
        {
            if (GetLocalString(oModule, "sWM_RE_ActivePoint") != "")
            {
                // if a previous player triggered a random encounter
                // go there now
                FadeToBlack(oUser, FADE_SPEED_FAST);
                RandomEncounter(oUser, "ACTIVE", oTrigger, nTDays, nTHours);

                /* // DEBUG
                SendMessageToPC(oUser, "DEBUG: Random Encounter active!");
                // DEBUG */
            }
            else
            {
                // travel to same destination as previous player,
                // no random encounter chance
                // no clock advance
                FadeToBlack(oUser, FADE_SPEED_FAST);
                MapTravel(oUser, oTrigger, 0, 0, FALSE);

                /* // DEBUG
                SendMessageToPC(oUser, "DEBUG: Party travel.");
                // DEBUG */
            }
        }
        else if (nRoll > nRandomChance)
        {
            // travel normally
            FadeToBlack(oUser, FADE_SPEED_FAST);
            MapTravel(oUser, oTrigger, nTDays, nTHours);

            /*
            // DEBUG
            SendMessageToPC(oUser, "DEBUG: nRERoll" + IntToString(nRoll));
            // DEBUG
            */
        }
        else
        {
            // triggered a random encounter!
            FadeToBlack(oUser, FADE_SPEED_FAST);
            RandomEncounter(oUser, sRandomLoc, oTrigger, nTDays, nTHours);

            /*
            // DEBUG
            SendMessageToPC(oUser, "DEBUG: nRERoll" + IntToString(nRoll));
            // DEBUG
            */
        }
    }
    else
    {
        // DEBUG
        SendMessageToPC(oUser, "DEBUG: Travel to this area is not possible or is not defined.");
        // DEBUG
    }
}
