// January 2006
// Update the variable on the party when Salvatori3 is killed

#include "cu_functions"

void main()
{
    object oPC = GetLastKiller();
    AllParty("nPiracy",oPC,6);
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
