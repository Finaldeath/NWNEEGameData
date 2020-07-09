// January 2006
// B W-Husey
// Generic script gives 10 gold. Set the choice for Alice information.
#include "cu_functions"
void main()
{
    TakeGoldFromCreature(10,GetPCSpeaker());
    AllParty("nAInfo",GetPCSpeaker(),3);

}
