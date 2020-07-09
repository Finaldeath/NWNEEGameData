//::///////////////////////////////////////////////
//:: FileName ohb_ac_pretrello
//:: Petrello reading music when you come in.
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/21/2005 2:13:17 PM
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
if (GetLocalInt(OBJECT_SELF, "no_hb") == 1) return;
ActionPlayAnimation(ANIMATION_FIREFORGET_READ);
}

