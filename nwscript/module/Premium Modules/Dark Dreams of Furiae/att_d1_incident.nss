#include "ddf_util"

void main()
{
    object oPC = GetEnteringObject();// GetFirstPC();
    if(oPC == OBJECT_INVALID || GetIsPC(oPC) == FALSE)
    {
        oPC = GetFirstPC();
    }
    // Play dialog warning you can't exit
    ActionStartConversation(oPC, "dmv_001");
}
