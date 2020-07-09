//August 2003
// B W-Husey
// Commoner spawn script (STATIC) - these guys do nothing
// It doesn't call dla_cresetup, so they won't get access to the other variables.

#include "x0_i0_anims"
// #include "x0_i0_walkway" - in x0_i0_anims
#include "x0_i0_treasure"

void main()
{


    SetListeningPatterns();
    //SetAILevel(OBJECT_SELF,AI_LEVEL_VERY_LOW);
//    WalkWayPoints();
    //* Create a small amount of treasure on the creature
//    CTG_GenerateNPCTreasure(TREASURE_TYPE_MONSTER, OBJECT_SELF);
    // ***** ADD ANY SPECIAL ON-SPAWN CODE HERE ***** //
}
