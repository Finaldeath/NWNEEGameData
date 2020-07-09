//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_night3
// DATE: 1 April, 2006
// AUTH: Luke Scull
// NOTE: Fade out screen and allow Nightshade to be
//       removed from game world.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oPC = GetFirstPC();

object oWaypoint = GetObjectByTag("WP_DepartingNPC_Jump");

object oDoor = GetObjectByTag("LarissCurios_To_TempleDistrict");

ActionMoveToObject(oDoor);

DelayCommand(0.5, FadeToBlack(oPC));

DelayCommand(2.0, JumpToObject(oWaypoint));

DelayCommand(5.5, FadeFromBlack(oPC));

DestroyObject(OBJECT_SELF, 6.0);
}
