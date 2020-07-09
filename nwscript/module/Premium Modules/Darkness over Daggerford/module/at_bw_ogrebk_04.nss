#include "nw_i0_generic"

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "nWH_OgreDeal", 1);   // agreed to kill gnolls

    int j = 1;
    if (GetLocalInt(oPC, "nWH_SpokeGnolls") == 1)
    {
        // must decide between sides
        j = 5;
    }
    AddJournalQuestEntry("j204", j, oPC);
}
