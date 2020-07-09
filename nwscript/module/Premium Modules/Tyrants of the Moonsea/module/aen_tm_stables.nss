// angrym jumps around when selling horses but always returns to the shop

#include "hf_in_util"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        object oAngrym = GetObjectInArea("Angrym", oPC);
        if (GetIsObjectValid(oAngrym))
        {
            object oWP = GetWaypointByTag("WP_THAS_SHOP_ANGRYM");
            location lLoc = GetLocation(oWP);
            AssignCommand(oAngrym, JumpToLocation(lLoc));
        }
    }
}
