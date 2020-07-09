#include "inc_id1_debug"

void main()
{
    // get the player using the door
    object oPC = GetLastUsedBy();

    // get secret door tag
    string sTag = GetTag(OBJECT_SELF);

    // determine where you're going
    string sDestination;
    if (sTag == "PuzzleSecretEntrance")
    {
        sDestination = "PuzzleSecretExit";
    } else
    {
        sDestination = "PuzzleSecretEntrance";
    }

    // get the destination door
    object oDestination = GetNearestObjectByTag(sDestination);

    location lDestination = GetLocation(oDestination);

    // jump the player to the destination
    DebugMessage("Clearing actions. Point 31.");
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
        DebugMessage("Clearing actions. Point 32.");
        AssignCommand(oHenchman, ClearAllActions());
        DelayCommand(0.1, AssignCommand(oHenchman, ActionJumpToLocation(lDestination)));

        nCount++;
        oHenchman = GetHenchman(oPC, nCount);
    }
}
