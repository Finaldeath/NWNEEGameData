//B W-husey
// September
// Script for use in conversation of doors that require forcing and have not yet been forced.
// Note the jammed door has the variable on NOT the object with the conversation.

int StartingConditional()
{
//    object oStuck = GetNearestObjectByTag("JammedDoor");
    object oStuck = GetNearestObjectByTag("PFEastTowerSouth");

    // Inspect local variables
    if(!(GetLocalInt(oStuck, "iUnforced") == 0))
        return FALSE;

    return TRUE;
}
