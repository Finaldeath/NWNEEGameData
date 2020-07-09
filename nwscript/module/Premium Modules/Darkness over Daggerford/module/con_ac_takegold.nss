//::///////////////////////////////////////////////
//:: FileName con_ac_takegold
//:: 100 gold taken from PC
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/16/2005 11:20:11 PM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    object oPC = GetPCSpeaker();
    TakeGoldFromCreature(100,oPC);

}
