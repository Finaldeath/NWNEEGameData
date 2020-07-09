// Sets plot variable nHawklinPlot1
// Called from Thiodor's conversation when the player wins a joust.

#include "dla_i0_joust"

void main()
{
    object oPC = GetPCSpeaker();
    int nHawklin1 = GetLocalInt(oPC, "nHawklinPlot1");
    int bCanSquire = DLA_GetStateIsSet(DLA_GetJoustState(oPC), DLA_JOUSTSTATE_T1_2);
    //plot integration, when pc wins two or more jousts
    // Also set tokens for who this opponent was if opp 2 of day 1 for use in Family Grave quest.
    if(bCanSquire && nHawklin1<3)
    {
         AllParty("nHawklinPlot1", oPC, 3);
         if (GetLocalInt(oPC,"nHawkTalk")>0) AddJournalQuestEntry("Hawklin1",20,oPC);
         SetCustomToken(1022, DLA_GetOpponentName(oPC));
         SetCustomToken(1027, GetLocalString(oPC, "OpGender"));
         DeleteLocalString(oPC, "OpGender");
         SetLocalString(oPC, "DLA_JoustLoser", DLA_GetOpponentResref(oPC));
    }
}


