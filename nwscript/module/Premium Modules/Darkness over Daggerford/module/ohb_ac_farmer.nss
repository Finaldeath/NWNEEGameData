//::///////////////////////////////////////////////
//:: FileName ohb_ac_farmer
//:: Farmers pick produce on heartbeat
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/2/2005 2:13:17 PM
//:://////////////////////////////////////////////
#include "NW_I0_PLOT"
int anyPlayersInArea( object who )
{
    object pc = GetNearestCreature( CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, who );
    if( !GetIsObjectValid(pc) )
        return 0;
    return 1;
}

void ahcFace(object o1)
{
SetFacingPoint(GetPosition(o1));
}

void main()
{
    if( !anyPlayersInArea( OBJECT_SELF ) )
        return;

if (IsInConversation(OBJECT_SELF)) return;
//{
//SetLocalObject(OBJECT_SELF, "waypoint", OBJECT_INVALID);
//SetLocalInt(OBJECT_SELF, "maid_state", 0);
//return;
//}
int nUser=GetUserDefinedEventNumber();
int nRandom=d3();

object owaypoint= GetLocalObject(OBJECT_SELF, "waypoint");
object oBar=GetWaypointByTag("wp_ac_wheelbarrow");

        if (!GetIsObjectValid(owaypoint))
        {
                // Randomly seek out up to the 3rd-nearest door waypoint
                owaypoint=GetNearestObjectByTag("wp_ac_farmer",OBJECT_SELF, nRandom);
                if (owaypoint != OBJECT_SELF && GetIsObjectValid(owaypoint) )
                {
                        // Move to waypoint
                        SetLocalInt(OBJECT_SELF, "maid_state", 1);
                        SetLocalObject(OBJECT_SELF, "waypoint", owaypoint);
                        ActionForceMoveToObject(owaypoint);
                        ActionDoCommand(ahcFace(GetNearestObjectByTag("TNOOrangeTreeLg")));
                        ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 6.0);
                        ActionWait(1.0);

                        // Move to Wheelbarrow
                        ActionDoCommand(SetLocalInt(OBJECT_SELF, "maid_state", 2));
                        ActionForceMoveToObject(oBar);
                        ActionDoCommand(ahcFace(GetNearestObjectByTag("Wheelbarrow")));
                        ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 3.0);
                        ActionDoCommand(SetLocalObject(OBJECT_SELF, "waypoint", OBJECT_INVALID));

                }
        }
}

