// when player enters the castle via the tunnels, the throne room doors should open

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC) && !GetLocalInt(OBJECT_SELF, "trigger_fired"))
    {
        SetLocalInt(OBJECT_SELF, "trigger_fired", 1);

        // open the throne room doors
        SetLocked(GetObjectByTag("pm_thronedoor1"), FALSE);
        SetLocked(GetObjectByTag("pm_thronedoor2"), FALSE);
        AssignCommand(GetObjectByTag("pm_thronedoor1"), ActionOpenDoor(GetObjectByTag("pm_thronedoor1")));
        AssignCommand(GetObjectByTag("pm_thronedoor2"), ActionOpenDoor(GetObjectByTag("pm_thronedoor2")));

        // destroy matagar in his throne room - he shouldn't be there now
        DestroyObject(GetNearestObjectByTag("db_matagar", oPC), 1.0);

        // destroy any giffons who might be hanging around after cutscene mv_ar0401_2
        // .. the cutscene should have done this anyways, but just to make sure
        DestroyObject(GetNearestObjectByTag("castguard1", oPC), 1.0);
        DestroyObject(GetNearestObjectByTag("castguard2", oPC), 1.0);
        DestroyObject(GetNearestObjectByTag("castguard3", oPC), 1.0);
        DestroyObject(GetNearestObjectByTag("castguard4", oPC), 1.0);
        DestroyObject(GetNearestObjectByTag("castguard5", oPC), 1.0);
        DestroyObject(GetNearestObjectByTag("castguard6", oPC), 1.0);
        DestroyObject(GetNearestObjectByTag("castguard7", oPC), 1.0);
    }
}
