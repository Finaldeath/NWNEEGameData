//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_ordercamp
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Updates The Crippled Fang journal entry to 37
//       when player enters the trigger.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oPC = GetEnteringObject();

    if (!GetIsPC(oPC)) return;

    int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

    if (DoOnce==TRUE) return;

    SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

    AddJournalQuestEntry("OrderoftheCrippledFang", 37, oPC, TRUE, FALSE);
}
