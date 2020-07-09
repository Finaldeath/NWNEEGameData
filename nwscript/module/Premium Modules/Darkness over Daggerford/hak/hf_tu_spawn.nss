// "PJ" spawn trigger; use this as the onEnter event of areas or triggers

#include "hf_in_spawn"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        SpawnEnter(oPC);
    }
}
