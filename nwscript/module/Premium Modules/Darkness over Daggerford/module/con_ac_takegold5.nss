//::///////////////////////////////////////////////
//:: FileName con_ac_takegold5
//::Take 5 gold pieces from PC.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/20/2005 9:07:37 AM
//:://////////////////////////////////////////////
void main()
{

    // Remove some gold from the player
    TakeGoldFromCreature(5, GetPCSpeaker(), TRUE);
}
