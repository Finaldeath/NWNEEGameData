//::///////////////////////////////////////////////
//:: cac_a2_pfacbonus
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The option selected is the AC
    bonus property
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: April 2005
//:://////////////////////////////////////////////
#include "inc_potscforge"

void main()
{
        // * this variable set so that the generic Have Enough gold
        // * script knows which item property you are trying to add
        SetLocalInt(OBJECT_SELF, "X2_LAST_PROPERTY", IP_CONST_WS_AC_BONUS);
}

