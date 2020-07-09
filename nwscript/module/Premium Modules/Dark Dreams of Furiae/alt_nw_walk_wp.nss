#include "NW_I0_GENERIC"
#include "nw_i0_henchman"
#include "ddf_util"

void main()
{
    WalkWayPoints();

    if(GetIsObjectValid(GetHenchman(GetPCSpeaker())) == TRUE)
    {
        SetFormerMaster(GetPCSpeaker(), GetHenchman(GetPCSpeaker()));
        object oHench = GetHenchman(GetPCSpeaker());
        RemoveHenchman(GetPCSpeaker(), GetHenchman(GetPCSpeaker()));
        AssignCommand(oHench, ClearAllActions());
    }

    //debug("finished dialog...");

    SetLocalInt(GetPCSpeaker(), "Stop_Convo" + GetTag(OBJECT_SELF), TRUE);

    SetWorkingForPlayer(GetPCSpeaker());
    SetBeenHired();
    ExecuteScript("NW_CH_JOIN", OBJECT_SELF);

}
