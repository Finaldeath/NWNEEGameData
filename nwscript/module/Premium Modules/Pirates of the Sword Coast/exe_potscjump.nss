//::///////////////////////////////////////////////
//:: exe_potscjump
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Jump the players to the current start location.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 31, 2005
//:://////////////////////////////////////////////
#include "inc_safepoint"

void main()
{
    object oArea = OBJECT_SELF;
    object oCursor = GetFirstPC();
    object oModule = GetModule();
    object oTarget, oLeader;

    // cycle through all players and move the ones
    // in the intro cutscene area to the current safe location.
    while (GetIsObjectValid(oCursor) == TRUE)
    {
        if (GetArea(oCursor) == oArea)
        {
            // if there's already a leader in the game, jump to them.
            // otherwise jumpt to the most recent safe location

            //JE: I added a check to make sure oLeader is in a different area.
            //If oLeader is still in the first area, but for some reason they
            //are not the first pc, this can potentially leave players stuck
            //in the first area.
            oLeader = GetFactionLeader(oCursor);
            if ( (oCursor != oLeader) &&
                 (GetIsObjectValid(oLeader) == TRUE) &&
                 (GetArea(oLeader) != oArea) )
            {
                AssignCommand(oCursor, ClearAllActions(TRUE));
                AssignCommand(oCursor, JumpToObject(oLeader));
            }
            else
            {
                AssignCommand(oCursor, ClearAllActions(TRUE));
                AssignCommand(oCursor, MoveToSafeLoc(oCursor));
            }
        }

        oCursor = GetNextPC();
    }
}
