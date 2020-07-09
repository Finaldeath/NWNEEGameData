//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_drizzle18
// DATE: February 21, 2006.
// AUTH: Luke Scull
// NOTE: If player hasn't already received potions for
//       next fight, give 3 Potions of Cure Critical Wounds.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

object oPC = GetPCSpeaker();

if(GetLocalInt(OBJECT_SELF, "potions") == 1)

return;

CreateItemOnObject("nw_it_mpotion003", oPC);

CreateItemOnObject("nw_it_mpotion003", oPC);

CreateItemOnObject("nw_it_mpotion003", oPC);
}
