//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_redplmof1
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Fade out screen then fade in when player has
//       jumped to secret passage in the Arena. Add
//       int so Red Plume officer's dialogue updates.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oPC = GetFirstPC();

object oWaypoint = GetObjectByTag("WP_ArenaPassage_Jump");

object oWaypoint2 = GetObjectByTag("WP_RedPlumeOfficer_Jump");

FadeToBlack(oPC, FADE_SPEED_FASTEST);

SetLocalInt(oPC, "redplumeofficer", 1);

DelayCommand(1.0, AssignCommand(oPC, JumpToObject(oWaypoint)));

DelayCommand(1.0, JumpToObject(oWaypoint2));

DelayCommand(3.0, FadeFromBlack(oPC, FADE_SPEED_MEDIUM));
}
