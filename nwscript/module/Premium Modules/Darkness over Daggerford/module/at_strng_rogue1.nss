// player uses the lens of true seeing to identify inventory

void main()
{
    object oPC = GetPCSpeaker();
    int nCount = 0;

    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        if (GetIdentified(oItem) == FALSE)
        {
            nCount++;
            SetIdentified(oItem, TRUE);
            SendMessageToPC(oPC, "Identified: " + GetName(oItem));
        }
        oItem = GetNextItemInInventory(oPC);
    }
    FloatingTextStringOnCreature("... Items Identified: " + IntToString(nCount) + " ...", oPC);
}
