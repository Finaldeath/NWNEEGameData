#include "ddf_util"

void main()
{
    object oEnter = GetEnteringObject();

    // Early out if a player character didn't trigger this
    if (GetIsPC(oEnter) == FALSE)
    {
        return;
    }

    int iUlanIntro = GetLocalInt(OBJECT_SELF, "UlanIntro");

    if (iUlanIntro == FALSE)
    {
        // Set our flag
        SetLocalInt(OBJECT_SELF, "UlanIntro", TRUE);

        // Get Ulan
        object oUlan = GetObjectByTag("DDF_NPC_UlanA");

        AssignCommand(oUlan, ActionStartConversation(oEnter, "ulan_001"));
    }
}
