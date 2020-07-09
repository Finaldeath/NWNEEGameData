//::////////////////////////////////////////////////////////////////////////////
//:: pus_puz_phylact
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Placeable object On Used script to rotate the phylacteries or initiate
    their firing, depending on the puzzle state.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 14, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_phlctpth"

void main()
{
    object oThis = OBJECT_SELF;
    object oSwitch = DB_GetObjectByTag(S_SWITCH_TAG);

    int nState = GetLocalInt(oSwitch, S_SWITCH_STATE);

    DebugMessage("puz_puz_phylact::" + GetTag(oThis) + " nState = " + IntToString(nState));

    ResetPhylacteries();

    // Based on the switches state the phylactery should either be rotated or
    // activated.
    if (nState == N_SWITCH_STATE_ROTATE)
    {
        RotatePhylactery(oThis);
    }
    else
    {
        ActivatePhylactery(oThis);
    }
}
