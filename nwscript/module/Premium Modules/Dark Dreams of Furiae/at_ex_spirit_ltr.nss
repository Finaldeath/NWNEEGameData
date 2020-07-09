#include "ddf_util"
#include "ddf_journal"
#include "x0_i0_common"

void main()
{
    if(GetLocalInt(GetModule(), "ddf_examined_spirit_letter") != TRUE)
    {
        //GiveXPToAll(GetPCSpeaker(), XP_SMALL);
    }

    SetLocalInt(GetModule(), "ddf_examined_spirit_letter", TRUE);
    UpdateJournal(GetPCSpeaker());
}
