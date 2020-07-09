//::///////////////////////////////////////////////
//:: dop_a2_tasina
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    When the player opens the door, start
    a cutscene (do once).

    April 8 - Locked door, moved script to
    OnFailToOpen event.

    May 1 - Moved to OnOpen event, to avoid
    stupid "locked door" sounds. Also put script
    on a trigger just beyond the door as a backup.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 17/05
//:://////////////////////////////////////////////
#include "inc_polymorphfix"

void StartCS(object oDoor, object oPC);

void main()
{
    object oPC;
    object oDoor = GetObjectByTagInArea("a2_door_cut_tasina", GetArea(OBJECT_SELF));

    // Need different method of getting oPC depending on whether the script
    // was fired by the door or the trigger.
    float fDelay;
    if(GetTag(OBJECT_SELF)=="a2_trig_cut_tasina")
    {
        oPC = GetEnteringObject();
        fDelay = 0.0;
    }
    else
    {
        oPC = GetLastOpenedBy();
        // When opening the door, the player will have the door highlighted
        // If we go into cutscene mode right away, that highlight will
        // persist for the duration of the cutscene. Really annoying. A slight
        // delay will allow the door to open and greatly reduce the possibility
        // of this happening.
        fDelay = 1.0;
    }

    object oModule = GetModule();

    if( GetIsPCNotDM(oPC) &&
        !GetLocalInt(oModule, "dop_a2_tas1_d1") )
    {
        SetLocalInt(oModule, "dop_a2_tas1_d1", TRUE);
        AssignCommand(oPC, ClearAllActions(TRUE));
        DelayCommand(fDelay, StartCS(oDoor, oPC));
    }
}

void StartCS(object oDoor, object oPC)
{
    AssignCommand(oDoor, ActionUnlockObject(oDoor));
    AssignCommand(oPC, ClearAllActions(TRUE));
    cs_PreCutsceneFade(CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);
    cs_StartCutscene_Poly("cut_a2_tas1", "cut_a2_tas1_end", 1.5, FALSE, TRUE, 1);
    // This cutscene is NOT abortable - there is a conversation at the
    // end of it that must be in the cutscene.

    // This is a critical plot point, so let's ensure ALL PC's are in
    // the area.
    object oPC2 = GetFirstPC();
    object oArea = GetArea(oPC);
    location lLoc = GetLocation(oPC);
    while(GetIsObjectValid(oPC2))
    {
        if(!GetIsDM(oPC2)) // ignore DM's, as usual
        {
            if(GetArea(oPC2) != oArea)
            {
                RemovePolymorph(oPC2);
                // if this PC is in a different area, jump them here
                // note: I'm using my JumpPCsToLocation function, which
                // is the "safe" way to do it. It has checks to make
                // sure the pc isn't in cutscene mode and stuff, and will
                // make them jump as soon as it's safe to do so. In theory.
                JumpPCsToLocation(lLoc, 0, oPC2);
            }
        }
        oPC2 = GetNextPC();
    }
}
