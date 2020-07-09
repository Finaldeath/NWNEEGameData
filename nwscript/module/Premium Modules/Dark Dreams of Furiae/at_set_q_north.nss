#include "ddf_util"
#include "ddf_journal"

void main()
{
    if(MovePartyToObject(GetPCSpeaker(), GetObjectByTag("northmarket_arrival")))
    {
        SetQuestState(AREA_NORTH_MARKET, INVESTIGATION_INPROGRESS);
        SetLocalInt(GetModule(), IS_INVESTIGATING, TRUE);
        UpdateJournal(GetPCSpeaker());
    }
    //AssignCommand(GetPCSpeaker(), ActionJumpToObject(GetObjectByTag("northmarket_arrival"), FALSE));
}
