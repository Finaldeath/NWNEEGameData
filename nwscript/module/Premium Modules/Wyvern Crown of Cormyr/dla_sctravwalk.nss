// October 2005
// B W-Husey
// Checks if that has a local destination so the player can choose to walk
// instead of use overland travel (i.e. between town areas).

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(OBJECT_SELF, "TRAVEL_WALK") == 1)
        return TRUE;

    return FALSE;
}
