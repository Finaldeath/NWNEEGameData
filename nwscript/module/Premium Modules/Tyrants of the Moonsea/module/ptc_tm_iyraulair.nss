//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ptc_tm_iyraulair
// DATE: Jan 07, 2019.
// AUTH: Rich Barker
// NOTE: Prevent Zhents following through transition if dragon
//       alive, and move them out of cave when dragon dead
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "x0_i0_walkway"

#include "hf_in_cutscene"
#include "hf_in_plot"

const string NPC_TAG_MERRIK = "IyraurothMerrik";
const string NPC_TAG_ZHENT1 = "IyraurothZhentFighter1";
const string NPC_TAG_ZHENT2 = "IyraurothZhentFighter2";
const string NPC_TAG_ZHENT3 = "IyraurothZhentFighter3";
const string NPC_TAG_ZHENT4 = "IyraurothZhentFighter4";
const string NPC_TAG_PRIEST1 = "PriestofBane1";
const string NPC_TAG_PRIEST2 = "PriestofBane2";
const string NPC_TAG_MAGE1 = "IyraurothZhentarimMage1";
const string NPC_TAG_MAGE2 = "IyraurothZhentarimMage2";

void MoveZhentInCave(object oCreature)
{
    if(!GetIsDead(oCreature))
    {
        AssignCommand(oCreature, ClearAllActions());
        AssignCommand(oCreature,
            JumpToLocation(GetLocation(GetWaypointByTag("WP_THIL_" + GetTag(oCreature)))));
    }
}

void MoveZhentsInCave()
{
    object oMerrik = GetObjectByTag(NPC_TAG_MERRIK);
    object oZhent1 = GetObjectByTag(NPC_TAG_ZHENT1);
    object oZhent2 = GetObjectByTag(NPC_TAG_ZHENT2);
    object oZhent3 = GetObjectByTag(NPC_TAG_ZHENT3);
    object oZhent4 = GetObjectByTag(NPC_TAG_ZHENT4);
    object oPriest1 = GetObjectByTag(NPC_TAG_PRIEST1);
    object oPriest2 = GetObjectByTag(NPC_TAG_PRIEST2);
    object oMage1 = GetObjectByTag(NPC_TAG_MAGE1);
    object oMage2 = GetObjectByTag(NPC_TAG_MAGE2);

    MoveZhentInCave(oMerrik);
    MoveZhentInCave(oZhent1);
    MoveZhentInCave(oZhent2);
    MoveZhentInCave(oZhent3);
    MoveZhentInCave(oZhent4);
    MoveZhentInCave(oPriest1);
    MoveZhentInCave(oPriest2);
    MoveZhentInCave(oMage1);
    MoveZhentInCave(oMage2);
}

//Send Zhents back to their campsite POSTs
void RemoveZhentFromCave(object oCreature, object oPC)
{
    if(!GetIsDead(oCreature))
    {
        CutsceneRemoveNegativeEffects(oCreature);
        SetIsTemporaryNeutral(oPC, oCreature);
        AssignCommand(oCreature, ClearAllActions(TRUE));
        AssignCommand(oCreature,
            ActionJumpToLocation(GetLocation(GetWaypointByTag("WP_THID_" + GetTag(oCreature)))));
        AssignCommand(oCreature,
            ActionDoCommand(SetWalkCondition(NW_WALK_FLAG_CONSTANT, TRUE, oCreature)));
        //Failsafe
        DelayCommand(20.0, SetWalkCondition(NW_WALK_FLAG_CONSTANT, TRUE, oCreature));
    }
}

void RemoveZhentsFromCave(object oPC)
{
    object oMerrik = GetObjectByTag(NPC_TAG_MERRIK);
    object oZhent1 = GetObjectByTag(NPC_TAG_ZHENT1);
    object oZhent2 = GetObjectByTag(NPC_TAG_ZHENT2);
    object oZhent3 = GetObjectByTag(NPC_TAG_ZHENT3);
    object oZhent4 = GetObjectByTag(NPC_TAG_ZHENT4);
    object oPriest1 = GetObjectByTag(NPC_TAG_PRIEST1);
    object oPriest2 = GetObjectByTag(NPC_TAG_PRIEST2);
    object oMage1 = GetObjectByTag(NPC_TAG_MAGE1);
    object oMage2 = GetObjectByTag(NPC_TAG_MAGE2);

    RemoveZhentFromCave(oMerrik, oPC);
    RemoveZhentFromCave(oZhent1, oPC);
    RemoveZhentFromCave(oZhent2, oPC);
    RemoveZhentFromCave(oZhent3, oPC);
    RemoveZhentFromCave(oZhent4, oPC);
    RemoveZhentFromCave(oPriest1, oPC);
    RemoveZhentFromCave(oPriest2, oPC);
    RemoveZhentFromCave(oMage1, oPC);
    RemoveZhentFromCave(oMage2, oPC);
}

void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);

    if(GetIsPC(oClicker))
    {
        PlotLevelSet("ZhentsFollowing", 0);
        //If Zhents are in cave and Iyrauroth lives, keep Zhents in cave
        if(PlotLevelGet("IyraurothDead") == 0)
        {
            if(PlotLevelGet("IyraurothMerrik") > 1)
            {
                MoveZhentsInCave();
            }
        }
        else
        {
            //If Zhents are in cave and Iyrauroth dead, remove Zhents from cave
            if(PlotLevelGet("IyraurothMerrik") == 3)
            {
                PlotLevelSet("IyraurothMerrik", 4);
                RemoveZhentsFromCave(oClicker);
            }
        }
        // move the player
        AssignCommand(oClicker, JumpToObject(oTarget));
        AssignCommand(oClicker, SetCameraFacing(90.0));
    }
}
