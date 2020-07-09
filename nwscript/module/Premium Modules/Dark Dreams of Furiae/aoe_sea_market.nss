#include "ddf_util"
#include "ddf_ring_dialog"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == FALSE) return;
    //SetLocalInt(GetModule(), "ddf_in_area", AREA_SEA_MARKET);

    SetCurrentArea(oPC, AREA_SEA_MARKET);
    // https://app.asana.com/0/842177838074622/928180496577998
    ExploreAreaForPlayer(OBJECT_SELF, oPC, TRUE);

    TryRingDialog(oPC);
}
