#include "hf_in_spawn"

void main()
{
    object oPC = GetEnteringObject();
    object oLula = GetObjectByTag("db_lula");
    if (!GetIsPC(oPC)) return;
    if (GetIsDay() || GetIsDawn()) return;
    //commented out by Luspr on 9/9/06 as lula should spawn more than once
    //the oe script for Daggerford is clearing her up if it is daytime, and
    //this line was preventing her respawning
    //if (GetLocalInt(GetModule(), "lula_met")!= 0) return;
    //this line added to prevent multiple spawns
    if (GetIsObjectValid(oLula)) return;
    SpawnEnter(oPC);

}
