//::///////////////////////////////////////////////
//::
//:: c2_oe_ar2505f
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Enter script for area.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 10/17/2005
//::
//:://////////////////////////////////////////////

#include "x0_i0_position"

#include "hf_in_spawn"

void SummonFriends(location lLocation, object oBehold, object oPC);

void main()
{
    object oEnterer = GetEnteringObject();

    if (GetIsPC(oEnterer))
    {

        if (GetLocalInt(GetModule(), "nIH_BeholderIntro") == 0)
        {
            if (GetLocalInt(oEnterer, "nIH_BeenTLair") == 0)
            {
                object oWP = GetNearestObjectByTag("bw_beholder_spawn", oEnterer);
                location lLoc = GetLocation(oWP);

                object oBeholder = CreateObject(OBJECT_TYPE_CREATURE, "bw_beholder_n", lLoc, FALSE);
                AssignCommand(oBeholder, ActionJumpToObject(oEnterer));
                AssignCommand(oBeholder, ActionDoCommand(SummonFriends(lLoc, OBJECT_SELF, oEnterer)));
                AssignCommand(oBeholder, ActionStartConversation(oEnterer));

                SetLocalInt(GetModule(), "nIH_BeholderIntro", 1);
            }
            else
            {
                SpawnEnter(oEnterer);
            }
        }
        else
        {
            SpawnEnter(oEnterer);
        }
    }
}

void SummonFriends(location lLocation, object oBehold, object oPC)
{
    object oTrog1 = CreateObject(OBJECT_TYPE_CREATURE, "bw_trog01", lLocation, FALSE);
    object oTrog2 = CreateObject(OBJECT_TYPE_CREATURE, "bw_trog01", lLocation, FALSE);
    ChangeFaction(oTrog1, oBehold);
    ChangeFaction(oTrog2, oBehold);
    AssignCommand(oTrog1, ClearAllActions(TRUE));
    AssignCommand(oTrog2, ClearAllActions(TRUE));
    AssignCommand(oTrog1, ActionJumpToObject(oBehold));
    AssignCommand(oTrog2, ActionJumpToObject(oBehold));
    AssignCommand(oTrog1, TurnToFaceObject(oPC));
    AssignCommand(oTrog2, TurnToFaceObject(oPC));
}
