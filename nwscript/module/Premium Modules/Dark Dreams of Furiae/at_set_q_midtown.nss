#include "ddf_util"
#include "ddf_journal"

void main()
{
    if(MovePartyToObject(GetPCSpeaker(), GetObjectByTag("midtownmunicipaldistrict_arrival")))
    {
        SetQuestState(AREA_MIDTOWN_MUNICIPAL_DISTRICT, INVESTIGATION_INPROGRESS);
        SetLocalInt(GetModule(), IS_INVESTIGATING, TRUE);
        UpdateJournal(GetPCSpeaker());
    }
    //AssignCommand(GetPCSpeaker(), ActionJumpToObject(GetObjectByTag("midtownmunicipaldistrict_arrival"), FALSE));
}
