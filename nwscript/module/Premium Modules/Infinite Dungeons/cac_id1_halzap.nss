//::////////////////////////////////////////////////////////////////////////////
//:: cac_id1_halzap
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Conversation action taken script to 'zap' halaster's clone out of existence.
    Since the clone is running the conversation in which this happens and the
    conversation continues after this point "out of existence" will mean into
    cutscene invisibility.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Nov 17, 2005
//::////////////////////////////////////////////////////////////////////////////
#include "inc_id1_debug"
void main()
{
    object oClone = OBJECT_SELF;
    object oHalaster = GetObjectByTag("id1_halaster_clone");

    if (GetIsObjectValid(oHalaster))
    {
        AssignCommand(oHalaster,
            ActionCastFakeSpellAtObject(SPELL_GREATER_DISPELLING, oClone));

        effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
        effect eVFX = EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION);

        DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oClone));
        DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, GetLocation(oClone)));
    }
    else // Error.
    {
        DebugMessage("cac_id1_halzap::main() Could not retrieve clone.");
    }

    // JE: Set a local variable to indicate that the 1st Halaster is
    // now gone. This will be checked by the conversation's abort script.
    // If the conversation is aborted after this point, we run the script
    // that resets things and teleports the players back to the warehouse.
    // This is needed because if the player aborts after this point, they
    // cannot restart the conversation.
    SetLocalInt(OBJECT_SELF, "halconv_point_of_no_return", TRUE);
}
