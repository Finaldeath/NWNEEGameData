#include "ddf_util"

void main()
{
    int iTeddyDead = GetLocalInt(GetModule(), "ddf_teddy_dead");
    int iTeddyLeft = GetLocalInt(GetModule(), "ddf_teddy_apt_leave");
    int iTeddySawPC = GetLocalInt(GetModule(), "ddf_teddy_apt_saw_pc");

    // If teddy is alive and hasn't left and saw the player
    if (iTeddyDead == FALSE && iTeddyLeft == FALSE && iTeddySawPC == TRUE)
    {
        // Close the door
        ActionCloseDoor(OBJECT_SELF);

        // Make Teddy run to the player and talk
        object oPC = GetLastOpenedBy();
        object oTeddy = GetObjectByTag("DDF_NPC_Teddy");
        AssignCommand(oTeddy, ClearAllActions());
        AssignCommand(oTeddy, ActionMoveToObject(oPC, TRUE));
        AssignCommand(oTeddy, ActionStartConversation(oPC, "tedd_003"));
    }
}
