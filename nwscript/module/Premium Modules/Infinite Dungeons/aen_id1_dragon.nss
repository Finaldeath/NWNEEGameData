//::////////////////////////////////////////////////////////////////////////////
//:: aen_id1_dragon
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Area On Enter event script for the Prismatic Dragon's lair. Initial set up
    of the area is performed here; the dragon is created.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: March 03, 2006
//::////////////////////////////////////////////////////////////////////////////

const string WAYPOINT = "ID1_STATIC_WP_BOSS";
const string DRAGON_RESREF = "id_olddrgpris";

// Name: Create Dragon
//
// Defined in: aen_id1_dragon
//
// Creates the Prismatic Dragon boss on the boss waypoint.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreateDragon();

void main()
{
    object oEnter = GetEnteringObject();
    object oThis = OBJECT_SELF;
    int bDoOnce = GetLocalInt(oThis, "bDoOnce");

    if (GetIsPC(oEnter) && !bDoOnce)
    {
        SetLocalInt(oThis, "bDoOnce", TRUE);

        ExploreAreaForPlayer(OBJECT_SELF, oEnter);

        CreateDragon();
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateDragon
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: March 06, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreateDragon()
{
    // Create the prismatic dragon on the boss waypoint.
    object oBossWP = GetWaypointByTag(WAYPOINT);
    location lLoc = GetLocation(oBossWP);

    CreateObject(OBJECT_TYPE_CREATURE, DRAGON_RESREF, lLoc);
}
