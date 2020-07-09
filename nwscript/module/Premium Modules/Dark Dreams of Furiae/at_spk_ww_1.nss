#include "ddf_journal"

string sFlag = "ddf_spoke_dealer";

void main()
{
    if (GetLocalInt(GetModule(), sFlag) == FALSE)
    {
        // Update flag and journal
        SetLocalInt(GetModule(), sFlag, TRUE);
        UpdateJournal(GetPCSpeaker());
    }
}
