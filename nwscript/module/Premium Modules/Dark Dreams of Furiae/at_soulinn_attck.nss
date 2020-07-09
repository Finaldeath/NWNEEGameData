#include "ddf_util"

void main()
{
    object oMerc = GetObjectByTag("SoulTradeInnMercenaryLeader");

    if (GetIsObjectValid(oMerc))
    {
        debug("Merc " + GetName(oMerc) + " run to player and start conversation");

        //Mercenary runs up to the party to force a dialogue that starts combat. Do this only once.
        object oPC = GetPCSpeaker();
        AssignCommand(oMerc, ClearAllActions());
        AssignCommand(oMerc, ActionMoveToObject(oPC, TRUE));
        AssignCommand(oMerc, ActionStartConversation(oPC, "merc_001"));
    }
}
