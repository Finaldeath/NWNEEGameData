// B W-Husey
// September 2005
// Script to test for forcing a door (in conversation). Note the DOOR_OPEN variable
// is set on the jammed door, not the conversing door necessarily.
// Forcing uses character's strength plus a d6() to beat door's variable.

int StartingConditional()
{
//    object oStuck = GetNearestObjectByTag("JammedDoor");
    object oStuck = GetNearestObjectByTag("PFEastTowerSouth");

   int iForce = GetLocalInt(oStuck,"DOOR_OPEN");
   if(!(GetAbilityScore(GetPCSpeaker(), ABILITY_STRENGTH) + Random(6) > iForce))
        return FALSE;

    return TRUE;
}
