#include "ddf_journal"

void main()
{
    object oEnter = GetEnteringObject();

    // If a player entered the volume
    if (GetIsPC(oEnter))
    {
        SetLocalInt(GetModule(), "ddf_entered_chop_shop", TRUE);
        UpdateJournal(oEnter);
    }
}
