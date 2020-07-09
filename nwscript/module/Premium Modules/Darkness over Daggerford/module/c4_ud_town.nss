///////////////////////////////////////////////////////////////////////////////
// c4_ud_town
//
// This script is to be used in conjuction with the trigger script "c3_walk_to_ambnt"
//
// If the sivak draconian has been switched to ambient animations via "c3_walk_to_ambnt"
// this script will switch it back to walking waypoints.
//
// for a npc to fire this script set the NW_GENERIC_MASTER int on the NPC to 1048576

//////////////////////////////////////////////////////////////////////////////
#include "nw_i0_generic"
void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == 1001)
    {
       if (GetLocalInt(OBJECT_SELF, "DontWalkWaypoints") && GetIsNight())
       {
          SetLocalInt(OBJECT_SELF,"DontWalkWaypoints",0);
          AssignCommand(OBJECT_SELF,ActionDoCommand(SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS, FALSE)));
          AssignCommand(OBJECT_SELF,ActionDoCommand(SetAnimationCondition(NW_ANIM_FLAG_CONSTANT, FALSE)));
          AssignCommand(OBJECT_SELF,ActionDoCommand(SetAnimationCondition(NW_ANIM_FLAG_IS_CIVILIZED,FALSE)));
          AssignCommand(OBJECT_SELF,WalkWayPoints(FALSE,0.2) );
       }
       return;

     }
}
