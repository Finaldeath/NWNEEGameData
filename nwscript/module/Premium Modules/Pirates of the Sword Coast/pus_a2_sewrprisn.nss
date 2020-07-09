//::///////////////////////////////////////////////
//:: pus_a2_sewrprisn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Player uses the ladder in the sewers to get
    to the Prison area.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////
#include "inc_polymorphfix"

void main()
{
    object oGrate = OBJECT_SELF;
    object oUser = GetLastUsedBy();
    object oTarget = GetWaypointByTag("a2_prisnsewr");
    location lTarget = GetLocation(oTarget);

    //Restrict Possessed Familiars
    if (GetIsPossessedFamiliar(oUser) == TRUE)
    {
        string sMessage = "You dare not stray far from your master.";
        FloatingTextStringOnCreature(sMessage, oUser);
    }
    else
    {
        // I should explain this - Condition 1: if a cutscene is currently
        // running in next area, remove polymorph. That's simple. Condition 2:
        // If the variable specified is set, it means that a cutscene should
        // start when a PC enters the area. I do a sanity check on whether
        // that cutscene has ever ran before. If it hasn't, and the variable is
        // set, we remove polymorph.
        object oTargetArea = GetArea(oTarget);
        if(cs_GetCutsceneRunning(oTargetArea) ||
             ( GetLocalInt(OBJECT_SELF, l_n_XPM_START_CS_ON_AEN) &&
               !cs_GetCutsceneStarted(1, oTargetArea) ))
        {
            RemovePolymorph(oUser);
        }
        AssignCommand(oUser, ClearAllActions(TRUE));
        AssignCommand(oUser, JumpToLocation(lTarget));
    }
}
