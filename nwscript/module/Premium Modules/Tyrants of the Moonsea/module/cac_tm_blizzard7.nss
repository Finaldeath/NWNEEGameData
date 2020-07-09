//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_blizzard7
// DATE: March 18, 2006
// AUTH: Luke Scull.
// NOTE: Temporarily fade screen and destroy Blizzard.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

//TODO:DELETE
// Merged into arena cutscenes

void main()
{
object oPC = GetFirstPC();

object oWaypoint = GetObjectByTag("WP_hfcells_blizz_offscreen");

FadeToBlack(oPC);

DelayCommand(1.5, JumpToObject(oWaypoint));

DelayCommand(3.0, FadeFromBlack(oPC));

DestroyObject(OBJECT_SELF, 6.0);
}
