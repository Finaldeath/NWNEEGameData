#include "cu_functions"

void main()
{
    object oLast = GetObjectByTag("WP_TestLast");
    AssignCommand(GetPCSpeaker(),JumpToLocation(GetLocation(oLast)));
}
