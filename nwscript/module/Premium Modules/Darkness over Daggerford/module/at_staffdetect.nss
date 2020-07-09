//at_staffdetect
//This script will make the secret trapdoor appear when the PC uses the staff of detection.
//
//Author: Phil Mitchell (Baron of Gateford)
void main()
{
  // yes we found it, now create the appropriate door
  object oWaypoint = GetNearestObjectByTag("WP_C1AR0304_C1AR0304B_EXIT");
  location locLoc = GetLocation(oWaypoint);
  object oidDoor;
  oidDoor = CreateObject(OBJECT_TYPE_PLACEABLE,"pm_bsi_TrapDoor",locLoc,TRUE);
  DestroyObject(oWaypoint,3.0);
}
