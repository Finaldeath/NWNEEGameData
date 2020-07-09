//::///////////////////////////////////////////////
//::
//:: a3_oe_ar0900_tr
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Enter script for triggers.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 2/8/2005
//::
//:://////////////////////////////////////////////

#include "nw_i0_generic"

object FindOgre(object oPC, int nAll = 0);

void main()
{
    object oEnterer = GetEnteringObject();
    string sTag = GetTag(OBJECT_SELF);

    if (GetIsPC(oEnterer) && GetLocalInt(GetModule(), "nWH_OgresDispatched") == 0)
    {
        if (sTag == "ar0900_trig01")
        {
            // ogre bridge checkpoint
            // check if pc cleared to pass
            // if not, bridgekeeper starts conversation

            if (GetLocalInt(oEnterer, "nWH_PaidToll") == 0)
            {
                object oOgre = FindOgre(oEnterer);
                if (GetIsObjectValid(oOgre))
                {
                    AssignCommand(oEnterer, ClearAllActions());
                    effect eFreeze = EffectCutsceneImmobilize();
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFreeze, oEnterer, 2.2f);

                    AssignCommand(oOgre, ClearAllActions());
                    AssignCommand(oOgre, SpeakString("You! Stop!"));
                    AssignCommand(oOgre, ActionStartConversation(oEnterer));
                }
            }
        }
        else if (sTag == "ar0900_trig02")
        {
            // ogre bridge point of no return
            // if pc is not cleared to pass, ogres go hostile

            if (GetLocalInt(oEnterer, "nWH_PaidToll") == 0)
            {
                object oOgre = FindOgre(oEnterer, 1);  // now we want *any* ogre
                if (GetIsObjectValid(oOgre))
                {
                    AdjustReputation(oEnterer, oOgre, -100);

                    AssignCommand(oOgre, ClearAllActions());
                    AssignCommand(oOgre, SpeakString("No pay toll! Now must die!"));
                    AssignCommand(oOgre, DetermineCombatRound(oEnterer));

                    SetLocalInt(oEnterer, "nWH_PaidToll", -1);   // enemy for life!
                }
            }
        }
    }
}

// this script will look for a nearby ogre bridgekeeper, and will
// return this creature *if the ogre sees the PC*
// and if ogre is not dead or in combat or a conversation
//
// if nAll is set to 1, function will return any nearby ogre that is
// of the wild hills ogre faction that is neutral to pc and
// sees the pc

object FindOgre(object oPC, int nAll = 0)
{
    object oOgre = GetNearestObjectByTag("bw_ogre03", oPC);
    if (GetIsObjectValid(oOgre) && !GetIsDead(oOgre) && !GetIsInCombat(oOgre) && !IsInConversation(oOgre) && GetObjectSeen(oPC, oOgre))
    {
        return oOgre;
    }
    else
    {
        oOgre = GetNearestObjectByTag("bw_ogre04", oPC);
        if (GetIsObjectValid(oOgre) && !GetIsDead(oOgre) && !GetIsInCombat(oOgre) && !IsInConversation(oOgre) && GetObjectSeen(oPC, oOgre))
        {
            return oOgre;
        }
    }

    if (nAll == 1)
    {
        int nNth = 1;
        object oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oPC, nNth, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_NEUTRAL);
        string sTag;

        while (GetIsObjectValid(oCreature))
        {
            sTag = GetTag(oCreature);
            if (GetStringLeft(sTag, 7) == "bw_ogre")
            {
                return oCreature;
            }

            nNth += 1;
            oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oPC, nNth, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_NEUTRAL);
        }
    }

    return OBJECT_INVALID;
}
