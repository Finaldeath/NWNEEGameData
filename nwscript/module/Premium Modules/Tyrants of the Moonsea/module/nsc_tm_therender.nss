//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: nsc_tm_thrender
//::////////////////////////////////////////////////////
//:: The Render - OnSpellCastAt
//:: Only vulnerable to electrical damage
//::////////////////////////////////////////////////////

void main()
{

    //--------------------------------------------------------------------------
    // GZ: 2003-10-16
    // Make Plot Creatures Ignore Attacks
    //--------------------------------------------------------------------------
    if (GetPlotFlag(OBJECT_SELF) || GetLocalInt(OBJECT_SELF, "nKnockdown") == 1)
    {
        return;
    }

    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------
    ExecuteScript("nw_c2_defaultb", OBJECT_SELF);
}
