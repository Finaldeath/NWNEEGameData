//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: pus_tm_portal2
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Transport player to portal on first floor of
//       Dreadspire when used.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oPC = GetLastUsedBy();

object oDestination = GetObjectByTag("PortaltoSecondFloor");

PlaySound("as_mg_telepout1");

DelayCommand(0.2,AssignCommand(oPC, ActionJumpToObject(oDestination)));
}

