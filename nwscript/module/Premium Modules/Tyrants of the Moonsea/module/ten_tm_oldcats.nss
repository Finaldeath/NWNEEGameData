//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_oldcats
// DATE: October 19, 2005
// AUTH: Luke Scull
// NOTE: Sets Evil Beneath Voonlar journal entry to 20.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

AddJournalQuestEntry("EvilBeneathVoonlar", 20, oPC, TRUE, FALSE);

}

