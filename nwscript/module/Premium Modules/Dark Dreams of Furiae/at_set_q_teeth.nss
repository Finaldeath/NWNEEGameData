#include "ddf_util"
#include "ddf_journal"

void main()
{
    if(MovePartyToObject(GetPCSpeaker(), GetObjectByTag("teethoforisaw_arrival")))
    {
        SetQuestState(AREA_TEETH_OF_ORISAW, INVESTIGATION_INPROGRESS);
        SetLocalInt(GetModule(), IS_INVESTIGATING, TRUE);
        UpdateJournal(GetPCSpeaker());
    }
    //AssignCommand(GetPCSpeaker(), ActionJumpToObject(GetObjectByTag("teethoforisaw_arrival"), FALSE));
}
