//::///////////////////////////////////////////////
//:: FileName ou_ac_takeallinv
//:: When player clicks on the chest, they take all items out of it.
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/17/2005 2:50:30 PM
//:://////////////////////////////////////////////
void main()
{
    object oC = OBJECT_SELF;
    object oPC = GetLastUsedBy();

    object oItem = GetFirstItemInInventory();
    while(GetIsObjectValid(oItem))
    {
        AssignCommand(oPC,ActionTakeItem(oItem, oC));
        oItem = GetNextItemInInventory();
    }
    FloatingTextStringOnCreature("You have recovered all your items.", oPC);
    SetLocalInt(oPC, "iRecoveredItems", 1);
}
