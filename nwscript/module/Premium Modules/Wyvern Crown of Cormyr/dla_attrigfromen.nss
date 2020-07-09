// January 2006
// B W-Husey
// Exit transition from an encounter area that continues the PC on their journey.

#include "cu_functions"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC) && GetIsInCombat(oPC)==FALSE)
    {
    if (GetLocalInt(oPC,"nNotInn")==1)    DoTravelNoInn(oPC);
    else DoTravelInn(oPC);
    }
}
