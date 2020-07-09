//::///////////////////////////////////////////////
//:: FileName con_ac_chesqst3
//:: Give PC cheese receipt and gold and increase cheese quest variable to 3
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/11/2005 2:13:19 PM
//:://////////////////////////////////////////////
void main()
{
    CreateItemOnObject("ac_cheesercpt", GetPCSpeaker(), 1);
    CreateItemOnObject("ac_cheesegold", GetPCSpeaker(), 1);
    SetLocalInt(GetPCSpeaker(), "ac_cheese_quest", 3);

}
