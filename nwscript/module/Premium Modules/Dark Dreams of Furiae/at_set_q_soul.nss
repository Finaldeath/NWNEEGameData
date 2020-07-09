#include "ddf_util"
#include "ddf_journal"

void main()
{
    if(MovePartyToObject(GetPCSpeaker(), GetObjectByTag("soultradeinn_arrival")))
    {
        SetQuestState(AREA_SOUL_TRADE_INN, INVESTIGATION_INPROGRESS);
        SetLocalInt(GetModule(), IS_INVESTIGATING, TRUE);
        UpdateJournal(GetPCSpeaker());
    }
    //AssignCommand(GetPCSpeaker(), ActionJumpToObject(GetObjectByTag("soultradeinn_arrival"), FALSE));
}
