//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ptc_tm_unseen1
//::////////////////////////////////////////////////////
//:: Quest: The Unseen - Door transition click
//:: Cutscene camera workaround
//::////////////////////////////////////////////////////

void main()
{
    object oClicker = GetClickingObject();
    object oDoor = OBJECT_SELF;

    if (GetLocalInt(oDoor, "nDone") > 0)
    {
        SetLocalInt(oDoor, "nDone", 1);
        BlackScreen(oClicker);
        AssignCommand(oClicker, SetCameraFacing(80.0, 4.0, 10.0, CAMERA_TRANSITION_TYPE_SNAP));
        DelayCommand(0.5f, ExecuteScript("ptc_tm_transall", oDoor));
    }
    else
    {
        ExecuteScript("ptc_tm_transall", oDoor);
    }

}
