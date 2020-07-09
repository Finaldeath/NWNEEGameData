// the player enters gillian's tower
// .. force a convo with the bandit leader

#include "hf_in_spawn"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        //object oB = GetObjectByTag("ac_ghillbandit");
        SpawnEnter(oPC);
        //SetCutsceneMode(oPC);
        //AssignCommand(oPC, ActionStartConversation(oB));
        //AssignCommand(oPC, ActionDoCommand(SetCutsceneMode(oPC, FALSE)));
    }
}
