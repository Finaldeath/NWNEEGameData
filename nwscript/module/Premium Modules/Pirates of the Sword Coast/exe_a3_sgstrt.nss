//::///////////////////////////////////////////////
//:: exe_a3_sgstrt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Handle the waterlevel portion of the
    puzzle combat.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"
#include "_inc_generic"

const string S_WATER_VERYLOW = "The salty brine swirls around your ankles.";
const string S_WATER_MDDL_A = "The water is too high for you to even plug the holes!";
const string S_WATER_MDDL_B = "You'll have to man the bilge pumps until the water levels lower.";
//const string S_WATER_MDDL_C = "";
const string S_WATER_HIGH = "The ship is listing to starboard. Someone has to man the bilge pumps!";
const string S_WATER_VERYHIGH = "The ships begins to splinter. In seconds, you'll be crushed within her hull!";

void RestartSeige();
void SendMessage(string sMSG);

void SendMessage(string sMSG)
{
    object oCursor = GetFirstPC();

    while (GetIsObjectValid(oCursor) == TRUE)
    {
        FloatingTextStringOnCreature(sMSG, oCursor);
        oCursor = GetNextPC();
    }
}

void main()
{
    object oSelf = OBJECT_SELF;
    object oModule = GetModule();
    object oWater, oHole;

    int iWater = GetLocalInt(oSelf, "A3_WATERLEVEL");
    int iHoles = GetLocalInt(oSelf, "A3_WATERHOLES");
    int iDoOnce, iXCord, iYCord, iWarning;

    float fZRender, fXCord, fYCord;
    vector vRender;
    location lRender;

    //SendMessageToPC(GetFirstPC(), "***FIRING, exe_a3_sgstrt");

    // If the puzzle is still active calculate the water
    if (iHoles < 4)
    {
        iWater = iWater + 1 + iHoles;
        fZRender = 1 + IntToFloat(iWater) * 0.020f;

        // warn the player about the current water level
        iWarning = GetLocalInt(oModule, "A3_SIEGEWARN_VLOW");
        if ((iWater >= 10) && (iWarning == FALSE))
        {
            SetLocalInt(oModule, "A3_SIEGEWARN_VLOW", TRUE);
            SendMessage(S_WATER_VERYLOW);
        }
        iWarning = GetLocalInt(oModule, "A3_SIEGEWARN_MED");
        if ((iWater >= 60) && (iWarning == FALSE))
        {
            SetLocalInt(oModule, "A3_SIEGEWARN_MED", TRUE);
            SendMessage(S_WATER_MDDL_A);
            DelayCommand(1.0f, SendMessage(S_WATER_MDDL_B));
            //DelayCommand(2.0f, SendMessage(S_WATER_MDDL_C));
        }
        iWarning = GetLocalInt(oModule, "A3_SIEGEWARN_HIGH");
        if ((iWater >= 90) && (iWarning == FALSE))
        {
            SetLocalInt(oModule, "A3_SIEGEWARN_HIGH", TRUE);
            SendMessage(S_WATER_HIGH);
        }
        iWarning = GetLocalInt(oModule, "A3_SIEGEWARN_VHIGH");
        if ((iWater >= 110) && (iWarning == FALSE))
        {
            SetLocalInt(oModule, "A3_SIEGEWARN_VHIGH", TRUE);
            SendMessage(S_WATER_VERYHIGH);
        }

        if (iWater >= 120)
        {
            //Seige Failed, try again.
            RestartSeige();
        }
        else
        {
            //SendMessageToPC(GetFirstPC(), "WATER LEVEL = " + IntToString(iWater));
            SetFogColor(FOG_TYPE_ALL, ((iWater * 10) / 16) , oSelf);
            SetFogAmount(FOG_TYPE_ALL, (10 + (iWater / 3)), oSelf);

            while(iXCord <4)
            {
                while(iYCord <3)
                {
                    fXCord = IntToFloat(iXCord) * 10 + 5;
                    fYCord = IntToFloat(iYCord) * 10 + 5;
                    vRender = Vector(fXCord, fYCord, fZRender);
                    lRender = Location(oSelf, vRender, 0.0f);

                    oWater = CreateObject(OBJECT_TYPE_PLACEABLE, "vfxplc_tropic", lRender);

                    DestroyObject(oWater, 1.9f);

                    iYCord++;
                }
                iYCord = 0;
                iXCord++;
            }

            SetLocalInt(oSelf, "A3_WATERLEVEL", iWater);
            DelayCommand(2.0f, ExecuteScript("exe_a3_sgstrt", oSelf));
        }
    }
    else
    {
        SetFogColor(FOG_TYPE_ALL, 0 , oSelf);
        SetFogAmount(FOG_TYPE_ALL, 10, oSelf);

        fZRender = 0.3f;
        // make some water stick around at ground
        // level when all the holes are plugged
        while(iXCord <4)
        {
            while(iYCord <3)
            {
                fXCord = IntToFloat(iXCord) * 10 + 5;
                fYCord = IntToFloat(iYCord) * 10 + 5;
                vRender = Vector(fXCord, fYCord, fZRender);
                lRender = Location(oSelf, vRender, 0.0f);

                oWater = CreateObject(OBJECT_TYPE_PLACEABLE, "vfxplc_tropic", lRender);

                iYCord++;
            }
            iYCord = 0;
            iXCord++;
        }
    }

    // Activate the hostile spawning.
    iDoOnce = GetLocalInt(oSelf, "exe_a3_sgstrt");
    if (iDoOnce == FALSE)
    {
        SetLocalInt(oSelf, "exe_a3_sgstrt", TRUE);
    }
}

void RestartSeige()
{
    object oSelf = OBJECT_SELF;
    object oModule = GetModule();

    object oHoles, oPatch, oWater, oPCCursor, oCursor, oDoor;
    object oWPCrew, oNPCCrew, oWPGarm, oWPNisar;
    object oGarm, oNisar, oWPLeave, oWPSpwnS;

    // put the ladder back
    object oWPLadder = GetWaypointByTag("A3_SEIGELADDER_SWPN");
    object oLadder = CreateObject(OBJECT_TYPE_PLACEABLE, "x0_ladder",
        GetLocation(oWPLadder), FALSE, "a3_seigeladder");

    string sNPCTag;
    location lSpawn;
    int iCounter;

    // reset the area fog to black
    DelayCommand(2.5f, SetFogColor(FOG_TYPE_ALL, 0 , oSelf));
    DelayCommand(2.5f, SetFogAmount(FOG_TYPE_ALL, 10, oSelf));

    // Reset the warning messages
    SetLocalInt(oModule, "A3_SIEGEWARN_VLOW", FALSE);
    SetLocalInt(oModule, "A3_SIEGEWARN_MED", FALSE);
    SetLocalInt(oModule, "A3_SIEGEWARN_HIGH", FALSE);
    SetLocalInt(oModule, "A3_SIEGEWARN_VHIGH", FALSE);

    // reset the water, hole, and seige variables
    SetLocalInt(oSelf, "A3_WATERLEVEL", FALSE);
    SetLocalInt(oSelf, "A3_WATERHOLES", FALSE);
    SetLocalInt(oSelf, "exe_a3_sgstrt", FALSE);
    SetLocalInt(oModule, "pop_a3_cutseige1", FALSE);

    // close the door on the PCs cabin
    oDoor = GetObjectByTag("a3_seigedoor");
    AssignCommand(oDoor, ActionCloseDoor(oDoor));

    // Reset the area music
    MusicBattleStop(oSelf);
    MusicBackgroundPlay(oSelf);

    //SendMessageToPC(GetFirstPC(), "Clear the holes");

    //Clear the holes
    iCounter = 0;
    oHoles = GetObjectByTag("a3_seigehole");
    while (GetIsObjectValid(oHoles) == TRUE)
    {
        DestroyObject(oHoles, 0.5f);
        iCounter++;
        oHoles = GetObjectByTag("a3_seigehole", iCounter);
    }

    //SendMessageToPC(GetFirstPC(), "Clear the hole plugs");

    //Clear the hole plugs
    iCounter = 0;
    oPatch = GetObjectByTag("a3_holeplug");
    while (GetIsObjectValid(oPatch) == TRUE)
    {
        DestroyObject(oPatch, 0.5f);
        iCounter++;
        oPatch = GetObjectByTag("a3_holeplug", iCounter);
    }

    //SendMessageToPC(GetFirstPC(), "Clear the Water");

    //Clear the Water
    iCounter = 0;
    oWater = GetObjectByTag("a3_sgwater");
    while (GetIsObjectValid(oWater) == TRUE)
    {
        DestroyObject(oWater, 0.5f);
        iCounter++;
        oWater = GetObjectByTag("a3_sgwater", iCounter);
    }

    //SendMessageToPC(GetFirstPC(), "Destroy hostiles");

    // Destroy hostiles
    iCounter = 0;
    oCursor = GetObjectByTag("a3_seigefish", iCounter);
    while (GetIsObjectValid(oCursor) == TRUE)
    {
        DestroyObject(oCursor, 1.0f);
        iCounter++;
        oCursor = GetObjectByTag("a3_seigefish", iCounter);
    }

    //SendMessageToPC(GetFirstPC(), "reset the PC back to the room");

    //reset the PC back to the room
    oPCCursor = GetFirstPC();
    while (GetIsObjectValid(oPCCursor) == TRUE)
    {
        //SendMessageToPC(oPCCursor, "clean the PC's inventory of wood.");

        // clean the PC's inventory of wood.
        oCursor = GetFirstItemInInventory(oPCCursor);
        while (GetIsObjectValid(oCursor) == TRUE)
        {
            if (GetTag(oCursor) == "a3_wdnbrds")
            {
                DestroyObject(oCursor, 0.5f);
            }

            oCursor = GetNextItemInInventory(oPCCursor);
        }

        //SendMessageToPC(oPCCursor, "Fade to black.");

        FadeToBlack(oPCCursor);

        //SendMessageToPC(oPCCursor, "Reset the plot state");

        DelayCommand(2.5f, AddJournalQuestEntry("a3_seige", 20, oPCCursor, TRUE, TRUE, TRUE));
        DelayCommand(2.5f, AssignCommand(oPCCursor, ClearAllActions(TRUE)));
        DelayCommand(2.5f, ForceRest(oPCCursor));
        DelayCommand(2.5f, SetCommandable(TRUE, oPCCursor));
        DelayCommand(3.0f, FadeFromBlack(oPCCursor));

        //SendMessageToPC(oPCCursor, "for some reason the PC doesn't always jump...");

        //for some reason the PC doesn't always jump...
/*
        DelayCommand(2.1f, AssignCommand(oPCCursor, JumpToLocation(GetLocation(
            GetWaypointByTag("A3_SEIGESTART1")))));
        DelayCommand(2.2f, AssignCommand(oPCCursor, JumpToLocation(GetLocation(
            GetWaypointByTag("A3_SEIGESTART1")))));
        DelayCommand(2.3f, AssignCommand(oPCCursor, JumpToLocation(GetLocation(
            GetWaypointByTag("A3_SEIGESTART1")))));
*/
        // JE: ... which is why I have this function
        location lLoc = GetLocation(GetWaypointByTag("A3_SEIGESTART1"));
        DelayCommand(2.1, JumpPCsToLocation(lLoc, 0, oPCCursor));
        oPCCursor = GetNextPC();
    }

    //SendMessageToPC(GetFirstPC(), "create NPC crew outside of the room");

    // create NPC crew outside of the room
    iCounter = 1;
    sNPCTag = GetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iCounter));
    while (sNPCTag != "")
    {
        oWPCrew = GetObjectByTag("A3_SEIGESPWN_0" + IntToString(iCounter));
        lSpawn = GetLocation(oWPCrew);

        sNPCTag = GetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iCounter));
        oNPCCrew = CreateObject(OBJECT_TYPE_CREATURE, sNPCTag, lSpawn);

        //SendMessageToPC(oPCCursor, "***aen_a3_sbseige fired; crew '"
        //    + GetTag(oNPCCrew) + "' at waypoint '" + GetTag(oWPCrew) + "'");

        iCounter++;
    }

    //SendMessageToPC(GetFirstPC(), "remove and setup the henchmen.");

    // remove and setup the henchmen.
    oGarm = GetObjectByTag("a1_hench_garm");
    AssignCommand(oGarm, ClearAllActions(TRUE));
    FireHenchman(GetMaster(oGarm), oGarm);
    oWPGarm = GetObjectByTag("A3_SEIGESPWN_GARM");
    AssignCommand(oGarm, JumpToLocation(GetLocation(oWPGarm)));
    ForceRest(oGarm);

    oNisar = GetObjectByTag("a2_hench_nisar");
    AssignCommand(oNisar, ClearAllActions(TRUE));
    FireHenchman(GetMaster(oNisar), oNisar);
    oWPNisar = GetObjectByTag("A3_SEIGESPWN_NISAR");
    AssignCommand(oNisar, JumpToLocation(GetLocation(oWPNisar)));
    ForceRest(oNisar);
}
