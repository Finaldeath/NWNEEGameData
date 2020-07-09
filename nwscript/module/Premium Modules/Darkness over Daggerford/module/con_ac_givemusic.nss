//::///////////////////////////////////////////////
//:: FileName con_ac_givemusic
//:: Script to give sheet music item to PC
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/16/2005 10:46:06 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    CreateItemOnObject("ac_sheetmusic", GetPCSpeaker(), 1);
    SetLocalInt(OBJECT_SELF, "got_music", 1);
}
