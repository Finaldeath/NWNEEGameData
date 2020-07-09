#include "ddf_journal"

string sFlag = "ddf_drug_password";

void main()
{
    if (GetLocalInt(GetModule(), sFlag) == FALSE)
    {
        // Update flag and journal
        SetLocalInt(GetModule(), sFlag, TRUE);
        UpdateJournal(GetPCSpeaker());
    }
}
