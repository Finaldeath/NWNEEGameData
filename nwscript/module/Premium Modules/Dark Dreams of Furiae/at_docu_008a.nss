#include "ddf_util"
#include "x0_i0_partywide"


void main()
{
    object oPC = GetPCSpeaker();

    //GiveXPToAll(oPC, XP_MEDIUM);
    AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, ALIGNMENT_SLIGHT, TRUE);
    SetLocalInt(GetModule(), "ddf_docu_008_destroyed", TRUE);

}
