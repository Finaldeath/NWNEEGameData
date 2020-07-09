//::///////////////////////////////////////////////
//:: phb_a1_trogfire
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summon some troglodytes to start the fire if
    it's out.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////
#include "inc_trogfight"

void main()
{
    if (IsFireActive() == FALSE)
    {
        CallFireTrogs();
    }
}

