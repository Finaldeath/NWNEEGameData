#include "ddf_util"
#include "ddf_journal"

void main()
{
    if(MovePartyToObject(GetPCSpeaker(), GetObjectByTag("roostersroost_arrival")))
    {
        SetQuestState(AREA_ROOSTERS_ROOST, INVESTIGATION_INPROGRESS);
        SetLocalInt(GetModule(), IS_INVESTIGATING, TRUE);
        UpdateJournal(GetPCSpeaker());
    }
    //AssignCommand(GetPCSpeaker(), ActionJumpToObject(GetObjectByTag("roostersroost_arrival"), FALSE));
}
