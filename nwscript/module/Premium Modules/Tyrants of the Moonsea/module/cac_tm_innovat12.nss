//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_innovat12
// DATE: March 18, 2006
// AUTH: Luke Scull.
// NOTE: See below for detailed commenting.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oPC = GetFirstPC();

object oWaypoint = GetObjectByTag("WP_Innovator_Post");

object oDoor = GetObjectByTag("YourCellToArenaComplex1");

// Fade out screen

FadeToBlack(oPC, FADE_SPEED_MEDIUM);

// Jump The Innovator back to his desk

DelayCommand(1.0, JumpToObject(oWaypoint));

// Open the cell door then fade back in

DelayCommand(2.0, AssignCommand(oDoor, SetLocked(OBJECT_SELF, FALSE)));

DelayCommand(2.5, AssignCommand(oDoor, ActionOpenDoor(OBJECT_SELF)));

DelayCommand(3.0, FadeFromBlack(oPC, FADE_SPEED_MEDIUM));
}
