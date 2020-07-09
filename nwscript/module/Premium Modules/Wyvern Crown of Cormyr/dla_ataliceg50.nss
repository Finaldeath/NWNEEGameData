// January 2006
// B W-Husey
// Generic script gives 50 gold. Set the choice for Alice information.
#include "cu_functions"
void main()
{
    TakeGoldFromCreature(50,GetPCSpeaker());
    AllParty("nAInfo",GetPCSpeaker(),1);

}
