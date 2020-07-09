//::///////////////////////////////////////////////
//:: aen_a3_sgintro
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has left the Island of the dead
    and is on route to the Midnight rose.

    Then Sahaugin attack.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oPC = GetEnteringObject();
    object oGarm, oNisar;
    int iDoOnce = GetLocalInt(OBJECT_SELF, "aen_a3_sgintro");

    cs_AreaOnEnter_Poly(oPC);

    if ((GetIsPCNotDM(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(OBJECT_SELF, "aen_a3_sgintro", TRUE);

        int iCounter = 1;
        string sNPCTag;
        location lSpawn;
        object oModule = GetModule();
        object oWPCrew, oNPCCrew;
        sNPCTag = GetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iCounter));
        effect e = EffectCutsceneGhost();
        while (sNPCTag != "")
        {
            oWPCrew = GetObjectByTag("A3_Topdeck_SPWN_0" + IntToString(iCounter));
            lSpawn = GetLocation(oWPCrew);

            sNPCTag = GetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iCounter));
            oNPCCrew = CreateObject(OBJECT_TYPE_CREATURE, sNPCTag, lSpawn);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, e, oNPCCrew);

            SetObjectArray(OBJECT_SELF, "oaCrew", iCounter, oNPCCrew);
            iCounter++;
        }

        cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);
        cs_StartCutscene_Poly("cut_a3_sgintro", "exe_a3_jumpsg", 3.0f, TRUE, FALSE, 10, OBJECT_SELF);
    }
}
