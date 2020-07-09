//::///////////////////////////////////////////////
//:: cac_a2_pfpatkb
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The option selected is the Attack
    bonus property
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 17, 2003
//:://////////////////////////////////////////////
#include "inc_potscforge"

void main()
{
        // * this variable set so that the generic Have Enough gold
        // * script knows which item property you are trying to add
        SetLocalInt(OBJECT_SELF, "X2_LAST_PROPERTY", IP_CONST_WS_ATTACK_BONUS);

}
