//::///////////////////////////////////////////////
//:: FileName con_ac_takegp100
//::Take 100 gold pieces from PC.
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/25/2005 9:07:37 AM
//:://////////////////////////////////////////////
void main()
{

    // Remove some gold from the player
    TakeGoldFromCreature(100, GetPCSpeaker(), TRUE);
}
