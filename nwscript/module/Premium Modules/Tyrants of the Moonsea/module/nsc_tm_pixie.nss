//::///////////////////////////////////////////////
//:: Name x2_def_spellcast
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Spell Cast At script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    int nSpell = GetLastSpell();

    if(nSpell == SPELL_DISPEL_MAGIC || nSpell == SPELL_GREATER_DISPELLING)
    {
        object oController = GetNearestObjectByTag("IllusionController");
        SignalEvent(oController, EventUserDefined(4500));
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
