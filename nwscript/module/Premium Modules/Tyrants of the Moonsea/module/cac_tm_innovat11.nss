//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_innovat11
// DATE: March 18, 2006
// AUTH: Luke Scull.
// NOTE: Close and lock the cell door.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oDoor = GetObjectByTag("ArenaComplex1ToYourCell");

object oDoor2 = GetObjectByTag("YourCellToArenaComplex1");

AssignCommand(oDoor, ActionCloseDoor(OBJECT_SELF));

DelayCommand(0.5, AssignCommand(oDoor, SetLocked(OBJECT_SELF, TRUE)));

AssignCommand(oDoor2, ActionCloseDoor(OBJECT_SELF));

DelayCommand(0.5, AssignCommand(oDoor2, SetLocked(OBJECT_SELF, TRUE)));
}
