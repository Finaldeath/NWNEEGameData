// October 2005
// B W-Husey
// This OnEnter script is used to rearm the party

#include "cu_functions"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);
    if (GetIsDefPC(oPC))
    {
    //disarm entering party and store what weapons they used
    RearmParty(oPC);
    }
}
