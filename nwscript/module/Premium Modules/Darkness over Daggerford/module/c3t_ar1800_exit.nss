// player exits the lizard marsh; make sure they don't have polymorph

#include "inc_polymorph"

void main()
{
    object oPC = GetClickingObject();
    if (GetIsPC(oPC))
    {
        PolymorphAreaExit(oPC);
        ExecuteScript("c3t_atc_to_map", OBJECT_SELF);
    }
}
