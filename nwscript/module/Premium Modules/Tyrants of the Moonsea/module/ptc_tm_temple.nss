//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ptc_tm_temple
//::////////////////////////////////////////////////////
//:: Voonlar "Temple of Bane" cutscene
//:: Door transition click - Camera workaround
//::////////////////////////////////////////////////////

void main()
{
    object oClicker = GetClickingObject();
    object oDoor = OBJECT_SELF;

    if (GetLocalInt(oDoor, "nDone") > 0)
    {
        SetLocalInt(oDoor, "nDone", 1);
        BlackScreen(oClicker);
        AssignCommand(oClicker, SetCameraFacing(0.0, 15.0, 10.0, CAMERA_TRANSITION_TYPE_SNAP));
        DelayCommand(0.5f, ExecuteScript("hf_pl_open_notpc", oDoor));
    }
    else
    {
        ExecuteScript("hf_pl_open_notpc", oDoor);
    }
}
