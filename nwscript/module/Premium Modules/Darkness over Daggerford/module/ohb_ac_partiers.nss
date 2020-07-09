//::///////////////////////////////////////////////
//:: FileName ohb_ac_partiers
//:: Party goers "talk" to each other
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/22/2005 2:13:17 PM
//:://////////////////////////////////////////////
#include "NW_I0_PLOT"
int anyPlayersInArea( object who )
{
    object pc = GetNearestCreature( CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, who );
    if( !GetIsObjectValid(pc) )
        return 0;
    return 1;
}

void main()
{
    if( !anyPlayersInArea( OBJECT_SELF ) )
        return;
    if (IsInConversation(OBJECT_SELF)) return;
    if (GetLocalInt(OBJECT_SELF, "no_banter") == 1) return;

    object oTarget = GetNearestObjectByTag("ac_partyguest");

    SetFacingPoint(GetPosition(oTarget));
    ClearAllActions();
    int n = d4();
    if (n == 1)
    {
        ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 5.7);
    }
    else if (n == 2)
    {
        ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 2.0);
        ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK);
        ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 2.0);
    }
    else if (n == 3)
    {
        ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 5.7);
    }
    else
    {
        ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 2.0);
        ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 3.7);
    }
}

