//::///////////////////////////////////////////////
//::
//:: c2_oe_ar2505a
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Enter script for area.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 10/17/2005
//::
//:://////////////////////////////////////////////

#include "hf_in_spawn"

void main()
{
   object oEnterer = GetEnteringObject();

    if (GetIsPC(oEnterer))
    {
        SpawnEnter(oEnterer);

        SetLocalInt(oEnterer, "nIH_BeenTLair", 1);
    }
}
