//::///////////////////////////////////////////////
//:: ten_a2_vantinit
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Have Vantabular interact with the PC once they
     arrive on the beach.

     Also, spawn vengaul or honey pea into the camp
     outside of town once the PC enters this
     trigger.

*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    // JE, Mar 7/05: Moved Vantabular dialog init to cutscene end script.
    // Also, I now start a cutscene here.

    object oSelf = OBJECT_SELF;
    //object oVantabular = GetObjectByTag("a2_vantabular");
    object oEnter = GetEnteringObject();
    int iDoOnce = GetLocalInt(oSelf, "ten_a2_vantinit");

    object oWP, oTrigger, oSpawn;
    location lWP;
    string sSpawn = "";
    int iBRBAlly = FALSE;
    int iBLDAlly = FALSE;

    if ((GetIsPCNotDM(oEnter) == TRUE) && (iDoOnce != TRUE))
    {
        SetLocalInt(oSelf, "ten_a2_vantinit", TRUE);
        //AssignCommand(oVantabular, ActionStartConversation(oEnter));

        cs_SetOption(CS_OPTION_ASSOCIATE_INVISIBILITY, FALSE, GetArea(OBJECT_SELF));
        cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);
        cs_StartCutscene_Poly("cut_a2_intro", "cut_a2_intro_end", 2.0, TRUE);

        // it's night
        SetTime(19,0,0,0);

/*
    Spawn vengaul or honey pea into the camp
    outside of town once the PC enters this
    trigger.
*/
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
