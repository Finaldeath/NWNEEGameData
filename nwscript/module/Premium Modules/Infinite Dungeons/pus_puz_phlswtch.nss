//::////////////////////////////////////////////////////////////////////////////
//:: pus_puz_phlswtch.
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Placeable On Used script for the switch placeable in the Phylactery path
    puzzle. Activating the switch will cause it to glow and cause any of the
    phylacteries that are used to initiate the firing animation.

    Update Feb 28, 2006: The switch will now have an unesable shaft of light
    placeable created on top of it, instead of just a small glow on the switch
    itself, to represent the state toggle.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 14, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_phlctpth"

void main()
{
    object oThis = OBJECT_SELF;
    //effect eVFX = EffectVisualEffect(VFX_DUR_GLOW_WHITE);

    int nState = GetLocalInt(oThis, S_SWITCH_STATE);

    // If puzzle is currently in the rotate state switch it over to the
    // activate state and apply a glow effect to the switch.
    if (nState == N_SWITCH_STATE_ROTATE)
    {
        SetLocalInt(oThis, S_SWITCH_STATE, N_SWITCH_STATE_ACTIVATE);

        //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, oThis);

        location lLoc = GetLocation(oThis);
        object oLight = DB_CreateObject(OBJECT_TYPE_PLACEABLE, "plc_solwhite", lLoc);

        SetLocalObject(oThis, "oLight", oLight);
    }
    else // switch to the rotate state and remove the glow.
    {
        SetLocalInt(oThis, S_SWITCH_STATE, N_SWITCH_STATE_ROTATE);

        /*
        eVFX = GetFirstEffect(oThis);

        while (GetIsEffectValid(eVFX))
        {
            RemoveEffect(oThis, eVFX);

            eVFX = GetNextEffect(oThis);
        }
        */

        object oLight = GetLocalObject(oThis, "oLight");

        DestroyObject(oLight);
    }
}
