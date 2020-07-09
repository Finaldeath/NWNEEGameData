#include "inc_id1_utility"

void main()
{
    // find the average level of players in the dungeon
    int nCR = GetPartyLevel(GetFirstPC(), TRUE);

    // get timmy's current store
    object oStore = GetLocalObject(OBJECT_SELF, "oStore");
    if (oStore != OBJECT_INVALID)
    {
        DestroyObject(oStore);
    }

    object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU36");
    SetLocalInt(oMicroCPU, "nLevel", nCR);
    SetLocalInt(oMicroCPU, "bTimmy", TRUE);
    SetLocalObject(oMicroCPU, "oParent", OBJECT_SELF);

    DelayCommand(0.01, ExecuteScript("exe_id1_micstore", oMicroCPU));
}
