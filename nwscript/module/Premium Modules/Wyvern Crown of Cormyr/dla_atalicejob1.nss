//PARTY WIDE - VARIABLE SWITCHED
//November 2005
// B W-Husey
// Number of jobs offered updated to 1



#include "cu_FUNCTIONS"
void main()
{
    string sName = "nAliceJob";      //Set variable to object's tag + extra bit
    AllParty(sName,GetPCSpeaker(),1);

    sName = "Var2"+GetTag(OBJECT_SELF);      //Set variable to object's tag + extra bit
    AllParty(sName,GetPCSpeaker(),TRUE);
}


