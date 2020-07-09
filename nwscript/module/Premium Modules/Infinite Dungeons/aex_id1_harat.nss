//::////////////////////////////////////////////////////////////////////////////
//:: aex_id1_harat
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Exit event for Harat's area. When a player exits the chain visual effects
    should all be removed in order to avoid lingering chain visuals.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: March 21, 2006
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_harat"

void main()
{
    object oExit = GetExitingObject();

    // Attempt to remove beam effects from the object leaving.
    RemoveAllEffects(oExit, EFFECT_TYPE_BEAM);

    if (GetIsPC(oExit)) // If a player is leaving.
    {
        object oSource;
        int i;

        // Cycle the chain source objects and remove their effects.
        for (i = 0; i < 17; ++i)
        {
            oSource = DB_GetObjectByTag(CHAIN_SOURCE_PRFX + IntToString(i));

            RemoveAllEffects(oSource);
        }
    }
}
