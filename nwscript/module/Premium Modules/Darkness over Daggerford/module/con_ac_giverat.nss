//::///////////////////////////////////////////////
//:: FileName con_ac_giverat
//:: Put sack containing Roo in player's inventory, and destroy Roo
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/2/2006 7:59:11 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    object oPC = GetPCSpeaker();
    CreateItemOnObject("ac_ratinsack", oPC, 1);
    DestroyObject(GetObjectByTag("ac_rootherat"));
    SetLocalInt(oPC, "ac_rootake", 1);
}
