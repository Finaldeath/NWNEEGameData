//::////////////////////////////////////////////////////////////////////////////
//:: cac_id1_timdispp
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Conversation action taken script to have little timmie be replaced with
    a copy of Halastar
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Nov 18, 2005
//::////////////////////////////////////////////////////////////////////////////
#include "inc_id1_debug"
void main()
{
    object oTimmy = GetObjectByTag("id1_cuttimmy");

    if (GetIsObjectValid(oTimmy))
    {
        effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);

        location lLoc1 = GetLocation(oTimmy);
        location lLoc2 = GetLocation(GetPCSpeaker());

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oTimmy);
        AssignCommand(oTimmy, ActionJumpToLocation(lLoc2));

        object oHalaster = CreateObject(OBJECT_TYPE_CREATURE,
            "id1_halaster_clo", lLoc1);

        // EDIT: make halaster not hostile
        ChangeToStandardFaction(oHalaster, STANDARD_FACTION_COMMONER);

        if (!GetIsObjectValid(oHalaster))
        {
            DebugMessage("cac_id1_timdisap::main() Halaster copy invalid.");
        }
    }
    else // Error
    {
        DebugMessage("cac_id1_timdisap::main() Timme is OBJECT_INVALID.");
    }
}
