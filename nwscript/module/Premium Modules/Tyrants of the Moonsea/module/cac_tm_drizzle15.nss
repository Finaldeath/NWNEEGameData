//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_drizzle15
// DATE: February 21, 2006.
// AUTH: Luke Scull
// NOTE: Sets int, gives player Potion of Lore.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int nCount=GetLocalInt(OBJECT_SELF, "potions");
void main()
{
nCount = nCount+1;
SetLocalInt(OBJECT_SELF, "potions", nCount);

object oPC = GetPCSpeaker();

CreateItemOnObject("nw_it_mpotion019", oPC);
}
