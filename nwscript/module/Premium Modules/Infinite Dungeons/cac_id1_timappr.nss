//::////////////////////////////////////////////////////////////////////////////
//:: cac_id1_timappr
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Conversation action taken script to have Timmie appear during the
    conversation with the defeated clone of Halaster.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Nov 18, 2005
//::////////////////////////////////////////////////////////////////////////////
#include "inc_id1_debug"
void main()
{
    object oThis = OBJECT_SELF;
    location lLoc = GetLocation(oThis);

    object oTimmy = CreateObject(OBJECT_TYPE_CREATURE, "id1_cuttimmy", lLoc, FALSE);

    // DEBUG
    if (!GetIsObjectValid(oTimmy))
    {
        DebugMessage("cac_id1_timappr::main() - INVALID_OBJECT created.");
    }
}
