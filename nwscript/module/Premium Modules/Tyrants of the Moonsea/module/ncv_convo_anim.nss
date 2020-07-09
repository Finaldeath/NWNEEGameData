// character on-conversation script:
// allows ambient NPCs to casually converse with the player
// while maintaining their current looping animations
// ignores shouts because we're too busy animating

#include "nw_i0_generic"

void main()
{
    // can't talk when petrified
    if (GetHasEffect(EFFECT_TYPE_PETRIFY, OBJECT_SELF) == TRUE)
    {
        return;
    }

    // can't talk when dead
    if (GetIsDead(OBJECT_SELF) == TRUE)
    {
        return;
    }

    // start talking, but don't turn to face the player
    float fDir = GetFacing(OBJECT_SELF);
    BeginConversation();
    ClearAllActions();
    AssignCommand(OBJECT_SELF, SetFacing(fDir));

    // send the user-defined event if appropriate
    if (GetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DIALOGUE));
    }
}
