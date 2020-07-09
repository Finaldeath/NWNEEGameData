// June 2003
// B W-Husey
// Sets first time talker variable so first time conversation does not happen again.
// Generic - use on action taken of first conversation for any character


//Alternative for updating for the whole party:

#include "CU_FUNCTIONS"
void main()
{
    AllParty("nFirst"+GetTag(OBJECT_SELF),GetPCSpeaker(),1);
}

