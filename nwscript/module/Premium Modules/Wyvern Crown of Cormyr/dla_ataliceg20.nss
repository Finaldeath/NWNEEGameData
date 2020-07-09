// January 2006
// B W-Husey
// Generic script gives 20 gold. Set the choice for Alice information.
#include "cu_functions"
void main()
{
    TakeGoldFromCreature(20,GetPCSpeaker());
    AllParty("nAInfo",GetPCSpeaker(),2);

}
