// debug script to find the henchmen and teleport them to the player's location
// .. they will be created if they don't exist in the module already

void FindHenchman(object oPC, string sTag)
{
    object oHench = GetObjectByTag(sTag);
    if (!GetIsObjectValid(oHench))
    {
        SendMessageToPC(oPC, "ERROR - Henchman not found: " + sTag + "... creating.");
        CreateObject(OBJECT_TYPE_CREATURE, sTag, GetLocation(oPC));
    }
    else
    {
        object oArea = GetArea(oHench);
        string sName = GetTag(oArea);
        SendMessageToPC(oPC, "Henchman was in area " + sName);
        AssignCommand(oHench, ClearAllActions(TRUE));
        AssignCommand(oHench, JumpToObject(oPC, 0));
    }
}

void main()
{
    object oPC = GetFirstPC();
    SetMaxHenchmen(3);
    FindHenchman(oPC, "pm_raegen");
    FindHenchman(oPC, "ks_purfbin");
}
