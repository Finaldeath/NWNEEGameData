//::///////////////////////////////////////////////
//:: FileName con_ac_booktaken
//:: See if player has already taken book
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/14/2005 7:55:59 PM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    SetLocalInt(OBJECT_SELF, "book_taken", 1);
    CreateItemOnObject("ac_itm_diaryelve", GetPCSpeaker());
    CreateItemOnObject("ac_itm_basementk", GetPCSpeaker());
}
