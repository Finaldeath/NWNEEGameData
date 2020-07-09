// zhentil keep area enter event

#include "hf_in_plot"
#include "hf_in_util"

// sidequest: "gorlax the many eyed"
void handleGorlaxSidequest(object oPC)
{
    // sparrow and jackdaw talk to the player after exiting the orphanage
    if (PlotLevelGet("Tyana") == 1)
    {
        PlotLevelSet("Tyana", 2);
        PlotLevelSet("Sparrow", 5);

        object oDoor = GetObjectByTag("ZhentOrphanIN");
        AssignCommand(oDoor, ActionCloseDoor(oDoor));
        SetLocked(oDoor, TRUE);

        object oSparrow = GetObjectInArea("Sparrow", oPC);
        AssignCommand(oPC, ActionStartConversation(oSparrow));
    }

    // after killing gorlax, jackdaw and sparrow return to the orphanage
    if (PlotLevelGet("Sparrow") == 7)
    {
        PlotLevelSet("Sparrow", 8);

        object oDoor = GetObjectByTag("ZhentOrphanIN");
        if (GetIsObjectValid(oDoor))
        {
            SetLocked(oDoor, FALSE);
        }

        object oWPjack = GetWaypointByTag("WP_ZKAO_JACKDAW");
        object oJackdaw = GetObjectByTag("Jackdaw");
        AssignCommand(oJackdaw, JumpToLocation(GetLocation(oWPjack)));
        object oWPspar = GetWaypointByTag("WP_ZKAO_SPARROW2");
        object oSparrow = GetObjectByTag("Sparrow");
        AssignCommand(oSparrow, JumpToLocation(GetLocation(oWPspar)));
    }
}

void exploreArea(object oPC)
{
    if (GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nEntered", 1);
        ExploreAreaForPlayer(GetArea(oPC), oPC, TRUE);
    }
}

void handleKornah()
{
    if(PlotLevelGet("KornahtheCrazy") == 9 &&
       GetLocalInt(OBJECT_SELF, "nKornahSpawned") == 0)
    {
        CreateObject(OBJECT_TYPE_CREATURE, "kornahthecrazy",
                     GetLocation(GetWaypointByTag("POST_KornahtheCrazy")));
        SetLocalInt(OBJECT_SELF, "nKornahSpawned", 1);
    }
}

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        handleGorlaxSidequest(oPC);
        exploreArea(oPC);
        handleKornah();
    }
}
