//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_bennart1
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Create Bennart "item" on PC, destroy old man.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

object oPC = GetPCSpeaker();

object oBennart = GetObjectByTag("Bennart");

CreateItemOnObject("bennartwaters", oPC);
AddJournalQuestEntry("LocktowerRescue", 95, oPC);
DestroyObject(oBennart, 0.1);
}

