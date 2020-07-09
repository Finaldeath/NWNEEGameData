////////////////////////////////////////////////////////////////////////////
// c3_walk_to_ambnt
// Written By : Baron of Gateford (Phil Mitchell)
// This script is to be placed on the on enter event of a trigger.
//
// The script will stop creatures from walking waypoints and switch ambient
// mobile animations on
//
////////////////////////////////////////////////////////////////////////////

#include "nw_i0_generic"
void npcanimationstart(object oNPC)
{
   ActionDoCommand(SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS, TRUE));
   ActionDoCommand(SetAnimationCondition(NW_ANIM_FLAG_CONSTANT, TRUE));
   ActionDoCommand(SetAnimationCondition(NW_ANIM_FLAG_IS_CIVILIZED,TRUE));
   ActionDoCommand(PlayMobileAmbientAnimations());
}
void main()
{
   object oNPC         = GetEnteringObject(); // get the reference to whatever object entered the trigger
   string sWaypointTag = GetTag(OBJECT_SELF); // OBJECT_SELF is the trigger, not the NPC
   string sNPCTag      = GetTag(oNPC);
   string sTagVar = GetLocalString(OBJECT_SELF, "sOwner");
   if ((GetTag(oNPC) == sTagVar)
      && !GetLocalInt(oNPC, "DontWalkWaypoints"))   //if its already switched on then don't do again
    {
          AssignCommand(oNPC, ClearAllActions() );
          SetLocalInt(oNPC,"DontWalkWaypoints",1);
          DelayCommand(0.2, AssignCommand(oNPC, npcanimationstart(oNPC) ) );
    }
}
