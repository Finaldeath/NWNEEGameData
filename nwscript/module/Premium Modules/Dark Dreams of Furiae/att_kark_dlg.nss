#include "ddf_util"

void main()
{
    object oEnter = GetEnteringObject();

    // Early out if a player character didn't trigger this
    if (GetIsPC(oEnter) == FALSE)
    {
        return;
    }

    // Get Kark (early out if she's invalid)
    object oKark = GetObjectByTag("DDF_NPC_Karkualii");
    if (GetIsObjectValid(oKark) == FALSE)
    {
        return;
    }

    // If Kark isn't hostile with you, then force the dialog
    int iRepPC = GetReputation(oKark, oEnter);
    if (iRepPC > 10)
    {
        AssignCommand(oKark, ActionStartConversation(oEnter, "kark_001"));
    }

    debug("kark " + GetName(oKark) + " rep " + IntToString(iRepPC));
}
