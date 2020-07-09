//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_garth2
// DATE: February 27, 2006.
// AUTH: Luke Scull
// NOTE: Open cell door.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oDoor = GetObjectByTag("YourCellToArenaComplex1");

DelayCommand(2.5, AssignCommand(oDoor, SetLocked(OBJECT_SELF, FALSE)));

DelayCommand(3.0, AssignCommand(oDoor, ActionOpenDoor(OBJECT_SELF)));
}
