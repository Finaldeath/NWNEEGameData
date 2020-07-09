// player activates the mirror crystal in illefarn

void main()
{
    object oUser = GetLastUsedBy();
    if (GetIsPC(oUser))
    {
        object oDoor = GetNearestObjectByTag("EXIT_AR2501_AR2501D");
        if (GetLocked(oDoor))
        {
            object oArea = GetArea(OBJECT_SELF);

            if (GetLocalInt(oArea, "nIH_BeamActive") == 1)
            {
                FloatingTextStringOnCreature("Can't use that now.", oUser);
            }
            else
            {
                PlaySound("as_sw_genericlk1");

                PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
                DelayCommand(0.8, SignalEvent(OBJECT_SELF, EventUserDefined(501)));
                DelayCommand(7.0, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));

                SetLocalInt(oArea, "nIH_BeamActive", 1);
                DelayCommand(7.2, SetLocalInt(oArea, "nIH_BeamActive", 0));
            }
        }
        else
        {
            FloatingTextStringOnCreature("Nothing happens.", oUser);
        }
    }
}
