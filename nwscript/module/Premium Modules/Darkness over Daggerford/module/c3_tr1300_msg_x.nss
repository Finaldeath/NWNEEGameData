// player exits a trigger in front of the stronghold door

#include "inc_stronghold"

void main()
{
    object oPC = GetExitingObject();
    if (GetIsPC(oPC))
    {
        QuestGiveQuestEnd(oPC);
    }
}
