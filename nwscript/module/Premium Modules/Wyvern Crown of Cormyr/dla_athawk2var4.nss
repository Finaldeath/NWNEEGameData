//PARTY WIDE - VARIABLE SWITCHED TO 1
//April 2004
// B W-Husey
// PC asks a question that he cannot ask again.
// These generic scripts must ONLY be used once per character, and never for multiple option variables
// Note on the conversation root comments what each variable has been use for.
// Special version for Hawklin


#include "cu_FUNCTIONS"
void main()
{
    string sName = "Var4"+GetTag(OBJECT_SELF);      //Set variable to object's tag + extra bit
    AllParty(sName,GetPCSpeaker(),TRUE);
}


