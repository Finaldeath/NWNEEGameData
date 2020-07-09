//Set variables indicating Iyrauroth is slain (triggered from ndt_tm_iyrauroth)
//and ensure Zhents don't remain hostil to PC if dragon spells have turned them
//hostile
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

//Perform a ClearActions(TRUE) on all PC party members
void ClearPartyActions(object oPC)
{
    object oFacMem = GetFirstFactionMember(oPC, FALSE);

    while (GetIsObjectValid(oFacMem))
    {
        AssignCommand(oFacMem, ClearAllActions(TRUE));
        oFacMem = GetNextFactionMember(oPC, FALSE);
    }
}

 //Clear party members feelings towards guard, and vice versa
 void ClearPartyReputation(object oPC, object oCreature)
{
    object oFacMem = GetFirstFactionMember(oPC, FALSE);

    while (GetIsObjectValid(oFacMem))
    {
        ClearPersonalReputation(oFacMem, oCreature);
        ClearPersonalReputation(oCreature, oFacMem);

        oFacMem = GetNextFactionMember(oPC, FALSE);
    }
}

//Reset Zhents faction and reputation
void ResetZhentFaction(object oPC, object oCreature)
{
    if(!GetIsDead(oCreature))
    {
        AssignCommand(oCreature, ClearAllActions(TRUE));

        //Clear party reputation towards me
        ClearPartyReputation(oPC, OBJECT_SELF);

        //Change how my current faction (MERCHANT) feels about me
        SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 80, OBJECT_SELF);
    }
}

void ResetZhentsFaction(object oPC)
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

    ResetZhentFaction(oMerrik, oPC);
    ResetZhentFaction(oZhent1, oPC);
    ResetZhentFaction(oZhent2, oPC);
    ResetZhentFaction(oZhent3, oPC);
    ResetZhentFaction(oZhent4, oPC);
    ResetZhentFaction(oPriest1, oPC);
    ResetZhentFaction(oPriest2, oPC);
    ResetZhentFaction(oMage1, oPC);
    ResetZhentFaction(oMage2, oPC);
}

void main()
{
    switch(GetUserDefinedEventNumber())
    {
        case 4001 :
            PlotLevelSet("IyraurothDead", 1);

            if(PlotLevelGet("IyraurothMerrik") == 2)
            {
                if(PlotLevelGet("MerrickDead") == 0)
                {
                    PlotLevelSet("IyraurothZhentarimOfficer", 5);
                }
                else
                {
                    PlotLevelSet("IyraurothZhentarimOfficer", 4);
                }

                PlotLevelSet("IyraurothMerrik", 3);
                PlotLevelSet("IyraurothZhentFighter1", 2);
                PlotLevelSet("IyraurothZhentFighter2", 2);
                PlotLevelSet("IyraurothZhentFighter3", 2);
                PlotLevelSet("IyraurothZhentFighter4", 2);
                PlotLevelSet("PriestofBane1", 2);
                PlotLevelSet("PriestofBane2", 2);
                PlotLevelSet("IyraurothZhentarimMage1", 2);
                PlotLevelSet("IyraurothZhentarimMage2", 2);
            }

            if(PlotLevelGet("IyraurothMerrik") > 1)
            {
                object oPC = GetFirstPC();
                ClearPartyActions(oPC);
                ResetZhentsFaction(oPC);
            }
        break;
    }
}
