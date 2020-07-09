#include "nw_i0_tool"
void main()
{
object oPC = GetPCSpeaker();

    object oItemToTake;
    oItemToTake = GetItemPossessedBy(oPC, "ac_perebones");
    if(GetIsObjectValid(oItemToTake) != 0)
    DestroyObject(oItemToTake);
    SetLocalInt(GetPCSpeaker(), "ac_peredus", 2);

}
