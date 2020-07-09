// returns true if we are standing in the beacon inn (main floor)

int StartingConditional()
{
    object oArea =  GetArea(OBJECT_SELF);
    if (GetTag(oArea) == "beaconinn")
        return TRUE;
    return FALSE;
}
