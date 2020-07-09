//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_madoc3
// DATE: August 25, 2005
// AUTH: Luke Scull
// NOTE: Journal entry, Madoc moves to inn.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"

void main()
{
// Define PC and destination for Madoc

object oPC = GetPCSpeaker();
object oTarget = (GetObjectByTag("Voonlar_To_TheSwordsMeet"));

// Add 1st journal entry for "Voonlar"

AddJournalQuestEntry("Voonlar", 10, oPC);

// Make sure plot plag is removed, then destroy after Madoc reaches inn

SetPlotFlag(OBJECT_SELF, 0);
DestroyObject(OBJECT_SELF, 4.0);

// Madoc moves to inn

ActionMoveToObject(oTarget, TRUE);

// End the cutscene wrapping this conversation
CutsceneNextShot();
}
