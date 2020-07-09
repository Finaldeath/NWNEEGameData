//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_dazel3
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Kill Bennart and update journal.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oBennart = GetObjectByTag("Bennart");

object oPC = GetFirstPC();

ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oBennart);

AddJournalQuestEntry("LocktowerRescue", 91, oPC);
}
