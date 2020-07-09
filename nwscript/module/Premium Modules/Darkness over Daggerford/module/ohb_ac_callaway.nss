//::///////////////////////////////////////////////
//:: FileName ohb_ac_callaway
//:: Farming ohb
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: January 7, 2006 2:13:17 PM
//:://////////////////////////////////////////////
#include "NW_I0_PLOT"
void ahcFace(float f1)
{
SetFacing(f1);
}

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

int nRandom=d4();
object owaypoint= GetLocalObject(OBJECT_SELF, "waypoint");

if (!GetIsObjectValid(owaypoint))
{
        // Randomly seek out up to the 6th-nearest table
        owaypoint=GetNearestObjectByTag("wp_ac_cal_farm",OBJECT_SELF, nRandom);
        if (owaypoint != OBJECT_SELF && GetIsObjectValid(owaypoint) )
        {
        // Move to waypoint
        SetLocalInt(OBJECT_SELF, "maid_state", 1);
        SetLocalObject(OBJECT_SELF, "waypoint", owaypoint);
        ActionMoveToObject(owaypoint, FALSE, 2.0);
        ActionDoCommand(ahcFace(GetLocalFloat(owaypoint, "direction")));
        ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 3.0);
        ActionDoCommand(SetLocalObject(OBJECT_SELF, "waypoint", OBJECT_INVALID));
        }
}
}

