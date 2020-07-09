// open the secret door or transport the player to the other side

#include "inc_id1_debug"

void main()
{
    // is the door open?
    if (GetIsOpen(OBJECT_SELF) == FALSE)
    {
        // open the door
        PlayAnimation(ANIMATION_PLACEABLE_OPEN);
    } else
    {
        // get the player using the door
        object oPC = GetLastUsedBy();

        // get secret door tag
        string sTag = GetTag(OBJECT_SELF);

        // determine where you're going
        string sDestination;
        if (sTag == "SecretDoor")
        {
            sDestination = "SecretDoorExit";
        } else
        {
            sDestination = "SecretDoor";
        }

        // get the destination door
        object oDestination = GetNearestObjectByTag(sDestination);

        // open the destination door if it's closed
        if (GetIsOpen(oDestination) == FALSE)
        {
            AssignCommand(oDestination, PlayAnimation(ANIMATION_PLACEABLE_OPEN));
        }

        location lDestination = GetLocation(oDestination);

        // jump the player to the destination
        DebugMessage("Clearing actions. Point 40.");
        AssignCommand(oPC, ClearAllActions());
        DelayCommand(0.1, AssignCommand(oPC, ActionJumpToLocation(lDestination)));

        // setting plot to false to be safe
        if (GetPlotFlag(oPC) == TRUE)
        {
            DebugMessage("Plot flag was set on player.");
        }
        SetPlotFlag(oPC, FALSE);

        // jump all of player's followers
        int nCount = 1;
        object oHenchman = GetHenchman(oPC, nCount);
        while (oHenchman != OBJECT_INVALID)
        {
            // jump the henchman to the destination
            DebugMessage("Clearing actions. Point 41.");
            AssignCommand(oHenchman, ClearAllActions());
            DelayCommand(0.1, AssignCommand(oHenchman, ActionJumpToLocation(lDestination)));

            nCount++;
            oHenchman = GetHenchman(oPC, nCount);
        }
    }
}
