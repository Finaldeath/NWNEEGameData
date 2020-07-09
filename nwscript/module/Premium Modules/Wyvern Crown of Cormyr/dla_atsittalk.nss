/*
    DLA_ATSITTALK.NSS
    gaoneng erick
    may 6, 2006

    if NPC is flagged as a "sitter", then he will continue sitting instead of
    standing up when talked to
*/
#include "x0_i0_anims"
void main()
{
    object self = OBJECT_SELF;

    //Vulcano May 23 2006:  stop the NPC pseudo conversation to prevent
    //oFriend from calling AnimActionStopTalking, which can move the NPC
    //speaker away and break conversation.  Safest to do it here.
    object oFriend = GetCurrentFriend();
    if(GetIsObjectValid(oFriend))
    {
        SetAnimationCondition(NW_ANIM_FLAG_IS_TALKING, FALSE);
        SetAnimationCondition(NW_ANIM_FLAG_IS_TALKING, FALSE, oFriend);
    }

    if (GetLocalInt(self, "GN_CHAIR")) // if i'm a sitter
    {
        if (GetCurrentAction() != ACTION_SIT) // and i'm not already sitting
        {
            ClearAllActions();
            object chair = GetLocalObject(self, "GN_CHAIR");
            if (GetIsObjectValid(chair)) ActionSit(chair); // sit on my chair
            else // if chair is no longer valid, look for a new chair to sit on
            {
                int i = 1;
                object chair = GetNearestObjectByTag("CHAIR");
                while (GetIsObjectValid(chair) && GetIsObjectValid(GetSittingCreature(chair)))
                {
                    i++;
                    chair = GetNearestObjectByTag("CHAIR", self, i);
                }
                if (GetIsObjectValid(chair)) // new chair found
                {
                    ActionWait(2.0);
                    ActionMoveToObject(chair);
                    ActionSit(chair);
                    SetLocalObject(self, "GN_CHAIR", chair);
                    SetLocalInt(self, "GN_CHAIR", TRUE);
                }
                else // boohoo no more chair, removes "sitter" statue from self
                {
                    DeleteLocalInt(self, "GN_CHAIR");
                    DeleteLocalObject(self, "GN_CHAIR");
                }
            }
        }
    }
}


