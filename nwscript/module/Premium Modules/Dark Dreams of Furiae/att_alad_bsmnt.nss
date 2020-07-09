#include "ddf_util"
#include "x0_i0_common"

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) == TRUE)
    {
        object oModule = GetModule();
        if(GetLocalInt(oModule, "entered_aladara_basement") == FALSE)
        {
            SetLocalInt(oModule, "entered_aladara_basement", TRUE);
            //GiveXPToAll(oPC, XP_SMALL);
        }
    }

}
