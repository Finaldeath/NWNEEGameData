#include "ddf_journal"

string sFlag = "ddf_learn_harasi_day2";

void main()
{
    if (GetLocalInt(GetModule(), sFlag) == FALSE)
    {
        // Update flag and journal
        SetLocalInt(GetModule(), sFlag, TRUE);
        UpdateJournal(GetPCSpeaker());
    }
}
