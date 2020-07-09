//:://////////////////////////////////////////////
//:: Created By:  Ben W-Husey
//:: Created On:  June 2003
//   Includes flee and combat conversation options
//   Modified to use SoU updated spawn file - Check it still works!
//:://////////////////////////////////////////////
#include "x0_i0_anims"
#include "x0_i0_treasure"
#include "CU_TREASURE"
void main()
{
SetSpawnInCondition(NW_FLAG_ESCAPE_RETURN);    // OPTIONAL BEHAVIOR (Flee to a way point and return a short time later.)
SetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION);
SetSpawnInCondition(NW_FLAG_SHOUT_ATTACK_MY_TARGET);
SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);         //OPTIONAL BEHAVIOR - Fire User Defined Event 1002
SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT); //OPTIONAL BEHAVIOR - Fire User Defined Event 1003
    SetListeningPatterns();    // Goes through and sets up which shouts the NPC will listen to.
    WalkWayPoints();           // Optional Parameter: void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)
                               // 1. Looks to see if any Way Points in the module have the tag "WP_" + NPC TAG + "_0X", if so walk them
                               // 2. If the tag of the Way Point is "POST_" + NPC TAG the creature will return this way point after
                               //    combat.
    GetTreasure("Misc",OBJECT_SELF,18,0,0);     //Chance of miscellaneous object
    GetTreasure("OneHand",OBJECT_SELF,100,0,1);     //Creature requires one handed weapon
}


