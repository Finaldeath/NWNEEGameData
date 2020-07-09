//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_innovat10
// DATE: February 28, 2006.
// AUTH: Luke Scull
// NOTE: Set int on Drizzle so that player can select
//       potions for next fight, also set int on player
//       so that Innovator's dialogue updates. Finally,
//       update The Arena journal.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
SetLocalInt(GetObjectByTag("DrizzletheAlchemist"), "potions", 0);

SetLocalInt(GetPCSpeaker(), "innovator", 4);

AddJournalQuestEntry("TheArena", 70, GetPCSpeaker());
}

