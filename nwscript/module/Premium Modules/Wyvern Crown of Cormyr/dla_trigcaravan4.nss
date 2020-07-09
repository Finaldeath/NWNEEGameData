// Trigger tells PC battle has begun with the bandits.

#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC))    AllParty("nSalvatori1Side",oPC,4);
}
