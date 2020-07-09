//::///////////////////////////////////////////////
//:: FileName ac_givedaxitem
//:: This gives the PC Daxiong the Necromancer's Item Identifier.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/27/2005 11:57:51 AM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    CreateItemOnObject("ac_identifier", GetPCSpeaker(), 1);
    SetLocalInt(OBJECT_SELF, "iIntCheck", 1);
}
