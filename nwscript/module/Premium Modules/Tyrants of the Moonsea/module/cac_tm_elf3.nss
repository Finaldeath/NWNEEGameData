//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_elf3
// DATE: February 25, 2006
// AUTH: Luke Scull.
// NOTE: Opens cell door and sends player message
//       informing them of the fact.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oPC = GetFirstPC();

object oDoor = GetObjectByTag("YourCellToArenaComplex1");

DelayCommand(2.5, AssignCommand(oDoor, SetLocked(OBJECT_SELF, FALSE)));

DelayCommand(3.0, AssignCommand(oDoor, ActionOpenDoor(OBJECT_SELF)));

DelayCommand(5.0, AssignCommand(oPC, SpeakString("As you finish speaking with the orc, the cell door springs open once more. This time you recognize the whispery, sinister voice calling your name.")));
}
