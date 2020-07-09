//::///////////////////////////////////////////////
//:: FileName con_ac_givecake
//:: Give player Elvish Seedcake with healing power
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/23/2005 11:38:54 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    CreateItemOnObject("ac_itm_seedcake", GetPCSpeaker(), 1);

}
