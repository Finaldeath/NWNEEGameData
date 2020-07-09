//::///////////////////////////////////////////////
//:: ten_a2_spwndela
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Spawn vengaul or honey pea into the camp
    outside of town once the PC enters this
    trigger.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "_inc_generic"

void main()
{
    object oPC, oWP, oTrigger, oSpawn;
    location lWP;
    string sSpawn = "";

    int iDoOnce = GetLocalInt(OBJECT_SELF, "ten_a2_spwndela");
    int iBRBAlly = FALSE;
    int iBLDAlly = FALSE;

    oPC = GetEnteringObject();

    if ((GetIsPCNotDM(oPC) == TRUE) && (iDoOnce != TRUE))
    {
        SetLocalInt(OBJECT_SELF, "ten_a2_spwndela", TRUE);

        //oTrigger = GetObjectByTag("trig_pirateinit");
        oWP = GetWaypointByTag("wp_pirate_camp");
        lWP = GetLocation(oWP);

        iBLDAlly = GetLocalInt(GetModule(), "A0_BLOODSAILOR_ALLY");
        iBRBAlly = GetLocalInt(GetModule(), "A0_BLACKRIVER_ALLY");

        // create either dela or honey pea.
        if (iBRBAlly == TRUE)
        {
            sSpawn = "a2_honeybandit";
        }
        else
        {
            sSpawn = "a2_vengaul";
        }

        oSpawn = CreateObject(OBJECT_TYPE_CREATURE, sSpawn, lWP);

        // JE: used to be stored on a trigger, but is easier for me to work
        // with if it's on the area. Also changed variable name to be a little
        // more specific.
        SetLocalObject(GetArea(OBJECT_SELF), "NPC_BANDIT", oSpawn);
    }
}
