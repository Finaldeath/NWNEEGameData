void main()
{
    if(GetAppearanceType(OBJECT_SELF) != APPEARANCE_TYPE_WEREWOLF)
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(5202));
        if(GetAppearanceType(GetObjectByTag("ac_jonas2")) != APPEARANCE_TYPE_WEREWOLF)
        {
            SignalEvent(GetObjectByTag("ac_jonas2"), EventUserDefined(5202));
        }
        return;
    }
    else
    if(GetAppearanceType(GetObjectByTag("ac_jonas2")) != APPEARANCE_TYPE_WEREWOLF)
    {
        SignalEvent(GetObjectByTag("ac_jonas2"), EventUserDefined(5202));
        return;
    }

    //--------------------------------------------------------------------------
    // GZ: 2003-10-16
    // Make Plot Creatures Ignore Attacks
    //--------------------------------------------------------------------------
    if (GetPlotFlag(OBJECT_SELF))
    {
        return;
    }

    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------

    ExecuteScript("nw_c2_defaultb", OBJECT_SELF);
}
