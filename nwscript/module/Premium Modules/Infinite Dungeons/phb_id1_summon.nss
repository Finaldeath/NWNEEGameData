//::////////////////////////////////////////////////////////////////////////////
//:: phb_id1_summon
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Heartbeat Event handler for the summon plcs in Halaster's area. Checks a
    local variable to determine if an elemental should be summoned and, if so,
    summons. The elemental summoned is created from a blueprint stored locally
    on the object.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Dec 5, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_boss"
#include "inc_id1_creature"

void main()
{
    object oThis = OBJECT_SELF;
    int nSummon = GetLocalInt(oThis, "nSummon");

    // Make sure Halaster hasn't already surrendered.
    object oHalaster = DB_GetObjectByTag(HALASTER_TAG);

    if (GetLocalInt(GetModule(), "bHalasterSurrender") == TRUE) //oHalaster, SURRENDER_FLAG))
    {
        effect eDMG = EffectDamage(10000);

        AssignCommand(GetModule(),
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDMG, oThis));

        return;
    }

    if (nSummon > 0)
    {

        // Decrement the summon queue.
        nSummon--;
        SetLocalInt(oThis, "nSummon", nSummon);

        // Fire some visual effects.
        effect eVFX = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);
        location lLoc = GetLocation(oThis);

        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lLoc);

        // Summon an elemental.
        string sSummon = GetLocalString(oThis, "sSummon");

        DebugMessage("summoning: " + sSummon);

        object oElemental = DB_CreateObject(OBJECT_TYPE_CREATURE, sSummon,
                                lLoc, TRUE, MINION_TAG);

        // Set some level up information on the elemental.
        object oDungeon = GetCurrentDungeon();
        int nEnc = GetLocalInt(oDungeon, "nBossLevel");

        SetLocalInt(oElemental, "nCR", nEnc);
        SetLocalInt(oElemental, "nBaseHD", 1);
        SetLocalInt(oElemental, "nClass", -1);

        SetLocalObject(oElemental, "oSource", oThis);

        AssignCommand(oElemental, ActionMoveToObject(oHalaster));
    }
}
