#include "ddf_util"

void main()
{
    /*
    object oModule = GetModule();

     if(GetLocalInt(oModule, "luce_001_done") == TRUE)
     {
        // are we in the guard place?

        if(GetCurrentArea(GetPCSpeaker()) != AREA_GUARD_POST)
        {
            SpeakString("...");
            return;
        }
     }
     */


    ExecuteScript("nw_c2_default4", OBJECT_SELF);
}
