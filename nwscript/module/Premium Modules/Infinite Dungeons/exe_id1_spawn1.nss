#include "inc_id1_utility"

void main()
{
    // get data
    int nLevel = GetLocalInt(OBJECT_SELF, "nLevel");
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
    int nCreature = -1;
    int nCR;
    int nCreatureClass;
    int nClassStartHD;
    int nClass = -1;

    if (nCreatureType == 3)
    {
        DebugMessage("  Retrieving data off creature.");

        nCR = GetLocalInt(oCreature, "nCR"); // desired CR
        nClassStartHD = GetLocalInt(oCreature, "nClassStartHD"); // HD at which specified class starts
        nClass = GetLocalInt(oCreature, "nClass"); // specified class to level the creature up in
    } else
    {
        DebugMessage("  Retrieving data off dungeon.");

        nCreature = GetLocalInt(oDungeon, "n" + sCreature);

        // get the CR the creature is to be levelled to
        nCR = GetLocalInt(oDungeon, "n" + sCreature + "CR");

        // get the class start HD
        nClassStartHD = GetLocalInt(oDungeon, "nListCreature" + IntToString(nCreature) + "ClassStartHD");

        // determine the level up class for this creature, of the subtype if necessary
        nClass = GetLocalInt(oDungeon, "nListCreature" + IntToString(nCreature) + "Class");
    }

    // get the basic creature class
    nCreatureClass = GetClassByPosition(1, oCreature);

    DebugMessage("  Variable returned was " + sCreature);
    DebugMessage("  Creature tag is " + sTag);
    DebugMessage("  Creature list number " + IntToString(nCreature));
    DebugMessage("  Desired CR is " + IntToString(nCR));
    DebugMessage("  Creature class is " + IntToString(nCreatureClass));

    // if an invalid class was returned
    if (nClass == -1)
    {
        DebugMessage("    Invalid class. Checking for alternative classes.");
        nClass = GetClassByPosition(3, oCreature);
        if (nClass == CLASS_TYPE_INVALID)
        {
            DebugMessage("    Third class is invalid. Checking second.");
            nClass = GetClassByPosition(2, oCreature);
            if (nClass == CLASS_TYPE_INVALID)
            {
                DebugMessage("    Second class is invalid. Setting class to creature class.");
                nClass = nCreatureClass;
            } else
            {
                DebugMessage("    Second class is valid.");
            }
        } else
        {
            DebugMessage("    Third class is valid.");
        }
    }
    DebugMessage("  Normal class is " + IntToString(nClass));

    DebugMessage("  ClassStartHD is " + IntToString(nClassStartHD));

    // get the basic creature level up package
    int nCreaturePackage = GetBaseLevelUpPackage(nCreatureClass);
    DebugMessage("  Creature package is " + IntToString(nCreaturePackage));

    // get the class level up package
    int nPackage = GetGuardianEnemyPackage(nClass);
    DebugMessage("  Guardian/Enemy package is " + IntToString(nPackage));

    // level up to the minimum number of HD
    int nCurrentHD = nLevel;
    float fCR = GetChallengeRating(oCreature);
    while ((fCR <=  IntToFloat(nCR - 1)) && (nCurrentHD <= (nLevel + 5)) && (nCurrentHD != 0))
    {
        if ((nClassStartHD == -1) || ((nClassStartHD != -1) && (nCurrentHD < nClassStartHD)))
        {
            DebugMessage("      Leveling up creature class.");
            nCurrentHD = LevelUpHenchman(oCreature, nCreatureClass, TRUE, nCreaturePackage);
        } else
        {
            DebugMessage("      Leveling up normal class.");
            nCurrentHD = LevelUpHenchman(oCreature, nClass, TRUE, nPackage);
        }
        DebugMessage("    Leveled to " + IntToString(nCurrentHD));

        // determine challenge rating
        fCR = GetChallengeRating(oCreature);
        DebugMessage("    Challenge rating is " + FloatToString(fCR));
    }

    if (nCurrentHD <= 0)
    {
        DebugMessage("  Levelup failed. Advancing to equip.");

        // go to levelup microprocess
        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU124");
        SetLocalObject(oMicroCPU, "oCreature", oCreature);
        DelayCommand(0.01, ExecuteScript("exe_id1_spawn2", oMicroCPU));
    } else if (fCR > IntToFloat(nCR - 1))
    {
        DebugMessage("  Levelup completed. Advancing to equip.");

        // go to levelup microprocess
        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU124");
        SetLocalObject(oMicroCPU, "oCreature", oCreature);
        DelayCommand(0.01, ExecuteScript("exe_id1_spawn2", oMicroCPU));
    } else
    {
        DebugMessage("  Continuing levelup.");

        // go to levelup microprocess
        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU124");
        SetLocalInt(oMicroCPU, "nLevel", nCurrentHD);
        SetLocalObject(oMicroCPU, "oCreature", oCreature);
        DelayCommand(0.01, ExecuteScript("exe_id1_spawn1", oMicroCPU));
    }

    DelayCommand(0.02, DestroyObject(OBJECT_SELF));
}
