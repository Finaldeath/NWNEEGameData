//::////////////////////////////////////////////////////////////////////////////
//:: ndt_id1_maggmin
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Death Event script for Maggris' minions. This script decrements the
    counter of active minions stored on Maggris.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: March 10, 2006
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_maggris"

void main()
{
    object oMaggris = DB_GetObjectByTag(MAGGRIS_TAG);

    // Decrement Maggris' minion counter.
    int nCount = GetLocalInt(oMaggris, MINION_COUNTER);

    nCount--;

    SetLocalInt(oMaggris, MINION_COUNTER, nCount);

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
