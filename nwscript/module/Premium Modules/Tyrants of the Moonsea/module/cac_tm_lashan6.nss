//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_lashan6
// DATE: October 20, 2005
// AUTH: Luke Scull
// NOTE: Lashan runs off and is destroyed.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oWaypoint = GetObjectByTag("WP_Lashan_Gone");

ActionMoveToObject(oWaypoint, TRUE);

DestroyObject(OBJECT_SELF, 5.0);
}