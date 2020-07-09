#include "ddf_util"
#include "ddf_journal"
#include "x0_i0_common"

void main()
{
    if (GetLocalInt(GetModule(), "ddf_talked_to_slaves") == FALSE)
    {
        object oPC = GetPCSpeaker();
        SetLocalInt(GetModule(), "ddf_talked_to_slaves", TRUE);
        //GiveXPToAll(oPC, XP_SMALL);
        UpdateJournal(oPC);
    }
}
