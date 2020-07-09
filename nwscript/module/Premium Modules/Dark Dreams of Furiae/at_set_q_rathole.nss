#include "ddf_util"
#include "ddf_journal"

void main()
{
    if(MovePartyToObject(GetPCSpeaker(), GetObjectByTag("ratholestreets_arrival")))
    {
        SetQuestState(AREA_RATHOLE_STREETS, INVESTIGATION_INPROGRESS);
        SetLocalInt(GetModule(), IS_INVESTIGATING, TRUE);
        UpdateJournal(GetPCSpeaker());
    }
    //AssignCommand(GetPCSpeaker(), ActionJumpToObject(GetObjectByTag("ratholestreets_arrival"), FALSE));
}
