#include "NW_I0_GENERIC"
#include "ddf_util"

void main()
{
    // Set the flag so we don't keep playing dialog
    SetLocalInt(OBJECT_SELF, "alad_001_done", TRUE);

    // TODO: Make hostile
    object oPC = GetPCSpeaker();
    AdjustReputation(oPC,OBJECT_SELF,-100);
    ClearAllActions();
    ActionAttack(oPC);
    //DetermineCombatRound(oPC);

    // Text Bubble
    SpeakString("Raaaaagh! Leftovers, kill!");

    object oLeftovers = GetObjectByTag("NW_GOLFLESH");
    if(GetIsObjectValid(oLeftovers) == FALSE) debug("-- unable to find golem...");
    AssignCommand(oLeftovers, ClearAllActions());
    AssignCommand(oLeftovers, ActionAttack(oPC));

}
