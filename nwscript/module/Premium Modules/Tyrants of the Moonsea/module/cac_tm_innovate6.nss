//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_innovate6
// DATE: February 27, 2006.
// AUTH: Luke Scull
// NOTE: Set int on Drizzle so that player can select
//       potions for next fight, also set int so that
//       Innovator's dialogue updates.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
SetLocalInt(GetObjectByTag("DrizzletheAlchemist"), "potions", 0);

SetLocalInt(GetPCSpeaker(), "innovator", 3);
}
