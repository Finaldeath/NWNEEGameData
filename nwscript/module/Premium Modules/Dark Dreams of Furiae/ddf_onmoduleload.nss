#include "ddf_util"

void main()
{
    debug("-- setting max hench ppl to 2");
    ExecuteScript("x2_mod_def_load", OBJECT_SELF);
    SetMaxHenchmen(2);

    object oModule = GetModule();
    if(GetLocalInt(oModule, "ddf_day_night") == 0)
    {
        SetLocalInt(oModule, "ddf_day_night", PARTY_TO_DAY);
    }
}
