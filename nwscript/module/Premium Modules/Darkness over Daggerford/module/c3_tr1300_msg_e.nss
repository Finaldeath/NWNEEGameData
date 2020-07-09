// player enters the trigger in front of the stronghold door

#include "inc_stronghold"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        QuestGiveQuestStart(oPC);
    }
}
