#include "ddf_util"
#include "ddf_journal"
#include "x0_i0_common"

void main()
{
    if (GetLocalInt(GetModule(), "ddf_examined_bloody_ledger") == FALSE)
    {
        // Update the flag and our journal and give some XP
        object oPC = GetFirstPC();
        SetLocalInt(GetModule(), "ddf_examined_bloody_ledger", TRUE);
        UpdateJournal(oPC);
        //GiveXPToAll(oPC, XP_SMALL);

        ActionStartConversation(GetPlaceableLastClickedBy(), "plac_003");
    }
}
