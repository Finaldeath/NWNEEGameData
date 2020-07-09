#include "hf_in_spawn"

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nActive") == 1)
        {
            SpawnEnter(oPC);
        }
    }
}
