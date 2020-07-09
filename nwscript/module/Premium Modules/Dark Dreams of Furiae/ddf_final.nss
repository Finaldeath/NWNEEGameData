#include "ddf_journal"
#include "ddf_util"

void FinalChoice(int iChoice)
{
    SetLocalInt(GetModule(), "ddf_choice_made", TRUE);
    SetLocalInt(GetModule(), "ddf_choice", iChoice);
    UpdateJournal(GetPCSpeaker());
    MovePartyToObject(GetPCSpeaker(), GetObjectByTag("TheEndArrival"), TRUE, TRUE);
}
