#include "hf_in_spawn"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        SpawnEnter(oPC);
    }
    else
    {
        if (GetTag(oPC) == "OchreJelly")
        {
            // it would be silly for jellies to come out of the cave
            DestroyObject(oPC);
        }
    }
}
