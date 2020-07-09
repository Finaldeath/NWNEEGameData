// October 2005
// All travel conversation conditionals work the same way.
// Naming convention used: dla_sctravel + the code name of the area (see DLA Progress Chart for code names)
// B W-Husey


int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(OBJECT_SELF, "TRAVEL_LW") == 1)
        return TRUE;

    return FALSE;
}
