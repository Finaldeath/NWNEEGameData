#include "nw_i0_generic"
// use this script on a door or area transition to only allow players
// .. this prevents monsters from following players through doors
// .. use this script on the "OnAreaTransitionClick" event of the door

void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);

    if (GetIsPC(oClicker))
    {
        object oFernd = GetObjectByTag("ac_fernd");
        AssignCommand(oClicker, JumpToObject(oTarget));
        ChangeToStandardFaction(oFernd, STANDARD_FACTION_COMMONER);
        ClearPersonalReputation(oClicker, oFernd);
        AssignCommand(oFernd, ClearAllActions(TRUE));
        int i = 1;
        object oHench = GetHenchman(oClicker, i);
        while(oHench != OBJECT_INVALID)
        {
            ClearPersonalReputation(oHench, oFernd);
            ClearPersonalReputation(oFernd, oHench);
            AssignCommand(oHench, ClearAllActions(TRUE));
            i++;
            oHench = GetHenchman(oClicker, i);
        }
    }
    else
    {
        ChangeToStandardFaction(oClicker, STANDARD_FACTION_COMMONER);
        ClearPersonalReputation(GetFirstPC(), oClicker);
        int i = 1;
        object oHench = GetHenchman(GetFirstPC(), i);
        while(oHench != OBJECT_INVALID)
        {
            ClearPersonalReputation(oHench, oClicker);
            ClearPersonalReputation(oClicker, oHench);
            AssignCommand(oHench, ClearAllActions(TRUE));
            i++;
            oHench = GetHenchman(GetFirstPC(), i);
        }
        AssignCommand(oClicker, ClearAllActions(TRUE));
        AssignCommand(oClicker, ActionMoveAwayFromObject(OBJECT_SELF, FALSE, 10.0));
    }
}
