#include "dla_inc_ride"

void main()
{
   AssignCommand(GetPCItemLastUnequippedBy(),  DLA_RefreshMountedArcheryPenalty());
   ExecuteScript("x2_mod_def_unequ", OBJECT_SELF);
}
