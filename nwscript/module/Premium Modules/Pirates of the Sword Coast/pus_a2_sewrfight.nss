//::///////////////////////////////////////////////
//:: pus_a2_sewrfight
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Player uses the ladder in the sewers to get
    to the fight club area.
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
    object oTarget = GetWaypointByTag("a2_fightsewer");
    location lTarget = GetLocation(oTarget);

    //Restrict Possessed Familiars
    if (GetIsPossessedFamiliar(oUser) == TRUE)
    {
        string sMessage = "You dare not stray far from your master.";
        FloatingTextStringOnCreature(sMessage, oUser);
    }
    else
    {
        // A cutscene runs on first enter - if it hasn't run, remove polymorph.
        // Also remove polymorph if a cutscene is currently running.
        object oTargetArea = GetArea(oTarget);
        if(cs_GetCutsceneRunning(oTargetArea) ||
           !cs_GetCutsceneStarted(1, oTargetArea))
        {
            RemovePolymorph(oUser);
        }
        AssignCommand(oUser, ClearAllActions(TRUE));
        AssignCommand(oUser, JumpToLocation(lTarget));
    }
}
