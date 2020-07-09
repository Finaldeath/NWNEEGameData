// river lis: move the party and the little boat to the opposite side of the river

#include "hf_in_npc"

const string sWP_Boat1 = "WP_RL_BOAT1";
const string sWP_Party1 = "WP_RL_PARTY1";
const string sWP_Boat2 = "WP_RL_BOAT2";
const string sWP_Party2 = "WP_RL_PARTY2";

// move the boat model to the given waypoint
// note that the "talkie" part of the boat exists on each side of the river
void moveBoat(object oBoat, object oWP)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, "tm_pl_shiprow001", GetLocation(oWP));
    object oModel = GetNearestObjectByTag("tm_pl_shiprow", oBoat);
    if (GetIsObjectValid(oModel))
    {
        DestroyObject(oModel);
    }

    SetUseableFlag(oBoat, FALSE);
    object oBoat2 = GetNearestObjectByTag("pl_rowboat");
    if (GetIsObjectValid(oBoat2))
    {
        SetUseableFlag(oBoat2, TRUE);
    }
}

// play some splish splash sounds
void splishSplash(object oPC)
{
    AssignCommand(oPC, PlaySound("as_na_splash1"));
}

// move the boat and players from one side of the river to the other
void main()
{
    object oPC = GetPCSpeaker();
    object oBoat = OBJECT_SELF;
    object oWP_Boat;
    string sWP_Party;

    object oWP1 = GetWaypointByTag(sWP_Boat1);
    object oWP2 = GetWaypointByTag(sWP_Boat2);
    float fDist1 = GetDistanceBetween(oBoat, oWP1);
    float fDist2 = GetDistanceBetween(oBoat, oWP2);
    if (fDist1 > fDist2)
    {
        oWP_Boat = oWP1;
        sWP_Party = sWP_Party1;
    }
    else
    {
        oWP_Boat = oWP2;
        sWP_Party = sWP_Party2;
    }

    TeleportToWaypoint(oPC, sWP_Party, TRUE);
    DelayCommand(1.5f, splishSplash(oPC));
    DelayCommand(2.0f, moveBoat(oBoat, oWP_Boat));
}
