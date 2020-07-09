// player enters the navigation cabin

#include "inc_navicabi"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        NaviCabiOnEnter(oPC);
    }
}
