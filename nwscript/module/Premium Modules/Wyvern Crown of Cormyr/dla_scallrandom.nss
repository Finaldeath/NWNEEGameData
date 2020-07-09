//::///////////////////////////////////////////////
//:: FileName dla_scallrandom
//:: Created By: B W-Husey
//:: Created On: 07/10/2005 14:00:37
//:: Default random response script usable on any character. Add to the'Text appears when' of any
//:: dialogue branch (except the last option).
//:://////////////////////////////////////////////
#include "x0_i0_anims"
int StartingConditional()
{
    //Vulcano May 23 2006:  stop the NPC pseudo conversation to prevent
    //oFriend from calling AnimActionStopTalking, which can move the NPC
    //speaker away and break conversation.  Safest to do it here.
    object oFriend = GetCurrentFriend();
    if(GetIsObjectValid(oFriend))
    {
        SetAnimationCondition(NW_ANIM_FLAG_IS_TALKING, FALSE);
        SetAnimationCondition(NW_ANIM_FLAG_IS_TALKING, FALSE, oFriend);
    }

    // Add the randomness
    return (Random(3) < 1);
}


