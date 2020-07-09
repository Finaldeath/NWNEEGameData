//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_innovat14
// DATE: March 18, 2006
// AUTH: Luke Scull.
// NOTE: Set int on Innovator so his dialogue updates
//       and change int on Drizzle so that player can
//       receive potions again.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
SetLocalInt(GetPCSpeaker(), "innovator", 5);

// Rset Drizzle potions: Done ndt_tm_maggolem instead
// SetLocalInt(GetObjectByTag("DrizzletheAlchemist"), "potions", 0);
}
