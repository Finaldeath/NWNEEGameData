//::////////////////////////////////////////////////////////////////////////////
//:: ndm_id1_masteriu
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Damaged event script for Masterius. Randomly causes Masterius to animate
    some reaper ghouls that will heal him as the drain life from the players.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 19, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_masteriu"

void main()
{
    int nMaxHP = GetMaxHitPoints();
    int nCurrentHP = GetCurrentHitPoints();
    int nRand = Random(nMaxHP);

    // If the ranomly generated number is greater than Masterius' current
    // Hitpoints he should summon a healing zombie.
    if (nRand > nCurrentHP)
    {
        // Draw some living dead from the nearest pile of corpses.
        object oCorpsePile = DB_GetNearestObjectByTag(CORPSE_PILE_TAG);

        // If a corpse pile is available apply some effects and create the ghoul
        if (GetIsObjectValid(oCorpsePile))
        {
            location lLoc = GetLocation(oCorpsePile);

            DebugMessage("Clearing actions. Point 27.");
            ClearAllActions(TRUE);

            ActionCastFakeSpellAtObject(SPELL_ANIMATE_DEAD, oCorpsePile);

            object oGhoul = DB_CreateObject(OBJECT_TYPE_CREATURE, GHOUL_RESREF, lLoc);

            // Level up information for the ghoul.
            object oDungeon = GetCurrentDungeon();
            int nEnc = GetLocalInt(oDungeon, "nBossLevel");

            nEnc -= 2;

            if (nEnc >= 0) nEnc = 1;

            SetLocalInt(oGhoul, "nCreatureType", 3);
            SetLocalInt(oGhoul, "nCR", nEnc);
            SetLocalInt(oGhoul, "nBaseHD", 1);
            SetLocalInt(oGhoul, "nClass", -1);

            SetLocalObject(oGhoul, "oMaster", OBJECT_SELF);

            AssignCommand(oGhoul, ActionForceMoveToObject(OBJECT_SELF));
        }
    }
}
