//:://////////////////////////////////////////////
//:: Created By:  Ben W-Husey
//:: Created On:  January 2006
//   Includes flee options
//   Modified to use SoU updated spawn file - Check it still works!
//:://////////////////////////////////////////////
#include "x0_i0_anims"
#include "x0_i0_treasure"

void main()
{
SetSpawnInCondition(NW_FLAG_ESCAPE_RETURN);    // OPTIONAL BEHAVIOR (Flee to a way point and return a short time later.)
SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);         //OPTIONAL BEHAVIOR - Fire User Defined Event 1002
SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);         //OPTIONAL BEHAVIOR - Fire User Defined Event
SetSpawnInCondition(NW_FLAG_DEATH_EVENT);         //OPTIONAL BEHAVIOR - Fire User Defined Event
SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);         //OPTIONAL BEHAVIOR - Fire User Defined Event
SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT); //OPTIONAL BEHAVIOR - Fire User Defined Event 1003
}


