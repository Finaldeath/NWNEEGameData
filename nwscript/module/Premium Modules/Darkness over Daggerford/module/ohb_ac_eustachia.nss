//::///////////////////////////////////////////////
//:: FileName ohb_ac_eustachia
//:: Eustachia milking cow on heartbeat
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/25/2005 2:13:17 PM
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
SetFacingPoint(GetPosition(GetNearestObjectByTag("NW_COW")));
ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 5.5);

}

