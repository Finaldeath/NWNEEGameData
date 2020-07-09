//August 2003
// B W-Husey
// Commoner spawn script (DEFAULT) - talk, interact,
// Change voiceset for each using it.
// It doesn't call dla_cresetup, so they won't get access to the other variables.

#include "x0_i0_anims"
// #include "x0_i0_walkway" - in x0_i0_anims
#include "x0_i0_treasure"

void main()
{
SetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING);
SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);

    // **** Animation Conditions **** //
    // * These are extra conditions you can put on creatures with ambient
    // * animations.

    // * Civilized creatures interact with placeables in
    // * their area that have the tag "NW_INTERACTIVE"
    // * and "talk" to each other.
    // *
    // * Humanoid races are civilized by default, so only
    // * set this flag for monster races that you want to
    // * behave the same way.
    // SetAnimationCondition(NW_ANIM_FLAG_IS_CIVILIZED);

SetAnimationCondition(NW_ANIM_FLAG_CHATTER);

    // * Creatures with _immobile_ ambient animations
    // * can have this flag set to make them mobile in a
    // * close range. They will never leave their immediate
    // * area, but will move around in it, frequently
    // * returning to their starting point.
    // *
    // * Note that creatures spawned inside interior areas
    // * that contain a waypoint with one of the tags
    // * "NW_HOME", "NW_TAVERN", "NW_SHOP" will automatically
    // * have this condition set.
    // SetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE);


    SetListeningPatterns();
//    WalkWayPoints();
    //* Create a small amount of treasure on the creature
//    CTG_GenerateNPCTreasure(TREASURE_TYPE_MONSTER, OBJECT_SELF);
    // ***** ADD ANY SPECIAL ON-SPAWN CODE HERE ***** //
}
