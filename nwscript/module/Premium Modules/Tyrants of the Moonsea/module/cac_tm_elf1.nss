//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_elf1
// DATE: February 21, 2006
// AUTH: Luke Scull.
// NOTE: Sets int so Elf's dialogue updates and adds
//       journal entry.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oPC = GetPCSpeaker();

AddJournalQuestEntry("HillsfarArenaElf", 10, oPC);

SetLocalInt(oPC, "elf", 1);

}
