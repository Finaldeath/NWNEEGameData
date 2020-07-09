#include "ddf_util"
#include "ddf_journal"
#include "x0_i0_partywide"

void main()
{
    object oPC = GetPCSpeaker();

    object oModule = GetModule();

    if(GetLocalInt(GetModule(), "") == FALSE)
    {
        //GiveXPToAll(oPC, XP_SMALL);
    }
    SetLocalInt(GetModule(), "ddf_examined_harasi_documents", TRUE);
    UpdateJournal(oPC);

}
