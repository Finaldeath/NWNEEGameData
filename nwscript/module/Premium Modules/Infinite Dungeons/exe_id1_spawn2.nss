#include "inc_id1_utility"
#include "inc_id1_creature"

void main()
{
    // get data
    object oCreature = GetLocalObject(OBJECT_SELF, "oCreature");

    DebugMessage("");
    DebugMessage("Leveling up creature OnSpawn.");

    int nCreatureType = GetLocalInt(oCreature, "nCreatureType");
    DebugMessage("  Creature type is " + IntToString(nCreatureType));

    object oDungeon = GetCurrentDungeon();
    string sCreature = GetLocalString(oCreature, "sVariable");
    DebugMessage("  Creature variable is " + sCreature);
    string sTag = GetTag(oCreature);
    DebugMessage("  Creature tag is " + sTag);

    int bEquipWeapon = FALSE;
    int bEquipArmor = FALSE;
    int nAttributes = -1;
    if (nCreatureType == 3)
    {
        bEquipWeapon = GetLocalInt(oCreature, "bEquipWeapon");
        bEquipArmor = GetLocalInt(oCreature, "bEquipArmor");
    } else
    {
        // get creature number
        object oDungeon = GetCurrentDungeon();
        string sCreature = GetLocalString(oCreature, "sVariable");
        int nCreature = GetLocalInt(oDungeon, "n" + sCreature);
        nAttributes = GetLocalInt(oDungeon, "nListCreature" + IntToString(nCreature) + "Attributes");
        bEquipWeapon = GetIsEquipWeapon(nAttributes);
        bEquipArmor = GetIsEquipArmor(nAttributes);
    }
    DebugMessage("  nAttributes is " + IntToString(nAttributes) + ", bEquipWeapon is " + IntToString(bEquipWeapon) + ", bEquipArmor is " + IntToString(bEquipArmor));

    if ((bEquipWeapon == TRUE) || (bEquipArmor == TRUE))
    {
        // get equipment bonus
        int nBonus = GetHitDice(oCreature) / 5;
        DebugMessage("  nBonus is " + IntToString(nBonus));

        // equip with proper equipment
        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU124");
        SetLocalInt(oMicroCPU, "nProcess", 0);
        SetLocalInt(oMicroCPU, "nBonus", nBonus);
        SetLocalInt(oMicroCPU, "bWeapon", bEquipWeapon);
        SetLocalInt(oMicroCPU, "bArmor", bEquipArmor);
        SetLocalObject(oMicroCPU, "oCreature", oCreature);
        DelayCommand(0.01, ExecuteScript("exe_id1_micequip", oMicroCPU));
    }

    DelayCommand(0.02, DestroyObject(OBJECT_SELF));
}
