// module heartbeat event
// .. handles player getting tired

#include "hf_in_rest"

void main()
{
    object oPC = GetFirstPC();
    RestCheckTired(oPC);
    ExecuteScript("x3_mod_def_hb", OBJECT_SELF);
}