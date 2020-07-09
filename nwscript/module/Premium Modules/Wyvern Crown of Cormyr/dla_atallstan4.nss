// STANDARD VARIABLE - SET PARTY WIDE
//April 2004
// B W-Husey
// Sets a standard variable to the new state.
// Note on the conversation root comments what each variable has been used for.
#include "cu_FUNCTIONS"
void main()
{
    string sName = "Stan4"+GetTag(OBJECT_SELF);      //Set variable to object's tag + extra bit
    AllParty(sName,GetPCSpeaker(),TRUE);
}


