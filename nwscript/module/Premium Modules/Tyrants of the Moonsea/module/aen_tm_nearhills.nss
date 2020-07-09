// the shind road random area prevents "nearing hillsfar" from unlocking
// on the world map because using an area transition exit rather than a
// world map exit, so we unlock the current area when it is first entered

#include "hf_in_worldmap"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nEntered") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nEntered", 1);
            UnlockMapLocation("ShindRdEHF");
        }
    }
}
