//OnEnter script for trigger around Subterranean Lair illusion
void main()
{
    object oController = GetNearestObjectByTag("IllusionController");
    object oPC = GetEnteringObject();

    //Fire appropriate event to Illusion Controller
    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nEntered", 1);
        SignalEvent(oController, EventUserDefined(4500));
    }
}
