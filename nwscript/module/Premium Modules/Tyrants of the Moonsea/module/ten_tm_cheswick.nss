//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_cheswick
//::////////////////////////////////////////////////////
//:: Quest: A Merchants Tale
//:: Have Cheswick initate conversation
//::////////////////////////////////////////////////////

#include "hf_in_util"

const string NPC_TAG_CHESWICK = "MerchantCheswick";


// Make Cheswick initiate conversation with the player
void CheswickInitConvo(object oPC)
{
    object oCheswick = GetObjectInArea(NPC_TAG_CHESWICK, oPC);

    AssignCommand(oPC, ClearAllActions(TRUE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneDominated(), oPC, 3.0);

    AssignCommand(oCheswick, ClearAllActions(TRUE));
    DelayCommand(0.5, AssignCommand(oCheswick, ActionStartConversation(oPC)));
}


void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC) &&(GetLocalInt(OBJECT_SELF, "nDone") == 0))
    {
        int nJournalEntry = GetLocalInt(oPC, "NW_JOURNAL_ENTRYAMerchantsTale");
        if (nJournalEntry == 20)
        {
            SetLocalInt(OBJECT_SELF, "nDone", 1);

            CheswickInitConvo(oPC);
        }
    }
}
