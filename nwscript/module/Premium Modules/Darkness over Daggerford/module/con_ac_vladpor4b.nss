//::///////////////////////////////////////////////
//:: FileName con_ac_vladport4
//:: Set quest completion for retrieving portrait
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 3:22:44 PM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "ac_vlad_paint_quest", 4);
    object oItemToTake = GetItemPossessedBy(oPC, "ac_portrait_grts");

    //Take painting and give gold
    GiveGoldToCreature(oPC, 100);
    if(GetIsObjectValid(oItemToTake) != 0)
    {
    DestroyObject(oItemToTake);
    }
}
