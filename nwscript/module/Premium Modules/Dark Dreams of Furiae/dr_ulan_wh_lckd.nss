#include "ddf_util"

void main()
{
    // Grab the gigantic guard and player
    object oGuard = GetObjectByTag("GiganticGuard");
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

    if (GetIsObjectValid(oGuard))
    {
        // Play the dialog
        AssignCommand(oPC, ActionStartConversation(oGuard, "slavg_001"));
    }
}
