//::///////////////////////////////////////////////
//:: FileName con_ac_givefakep
//:: Vlad gives player fake portrait to exchange for real one.
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/21/2006 4:54:55 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    CreateItemOnObject("ac_fakeportrait", GetPCSpeaker(), 1);
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "ac_vlad_paint_quest", 1);
}
