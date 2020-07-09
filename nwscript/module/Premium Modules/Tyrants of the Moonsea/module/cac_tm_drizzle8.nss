//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_drizzle8
// DATE: February 21, 2006.
// AUTH: Luke Scull
// NOTE: Sets int, gives player Potion of Death Armor.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int nCount=GetLocalInt(OBJECT_SELF, "potions");
void main()
{
nCount = nCount+1;
SetLocalInt(OBJECT_SELF, "potions", nCount);

object oPC = GetPCSpeaker();

CreateItemOnObject("x2_it_mpotion002", oPC);
}
