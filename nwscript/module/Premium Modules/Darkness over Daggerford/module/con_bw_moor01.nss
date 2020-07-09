// the player uses boonmoppet's row boat to cross the river

#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();
    string sTag = GetTag(OBJECT_SELF);
    object oBoat = GetNearestObjectByTag("bw_rowboat");
    float fDist = GetDistanceToObject(oBoat);

    string sJumpWP = (sTag + "_jump");
    object oJumpWP = GetNearestObjectByTag(sJumpWP);

    string sBoatWP = "bw_ar0800_moor2_boat";
    if (GetStringRight(sTag, 1) == "2")
    {
        sBoatWP = "bw_ar0800_moor1_boat";
    }
    object oBoatWP = GetNearestObjectByTag(sBoatWP);
    location lBoatWP = GetLocation(oBoatWP);

    CreateObject(OBJECT_TYPE_PLACEABLE, "bw_rowboat", lBoatWP);

    SetPlotFlag(oBoat, FALSE);
    DestroyObject(oBoat, 0.2f);

    TeleportToObject(oPC, oJumpWP, TRUE);

    PlaySound("as_na_waterlap1");
}
