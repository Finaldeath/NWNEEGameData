#include "inc_id1_debug"

void main()
{
    ActionPauseConversation();

    // rebuild the database
    DebugMessage("Rebuilding database.");

    SetLocalInt(GetModule(), "nQueueMin", -7);

    location lLocation = GetLocation(GetObjectByTag("CPU"));

    object oHolder = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", lLocation, FALSE, "MicroCPU125");

    object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", lLocation, FALSE, "MicroCPU126");
    SetLocalObject(oMicroCPU, "oParent", OBJECT_SELF);
    SetLocalObject(oMicroCPU, "oHolder", oHolder);
    DelayCommand(0.01, ExecuteScript("exe_id1_rebuild1", oMicroCPU));
}
