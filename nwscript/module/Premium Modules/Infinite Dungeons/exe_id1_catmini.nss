#include "inc_id1_debug"

// object GetNextCPU()
#include "inc_id1_utility"

const int ID1_STEP_SIZE = 100;
const int ID1_LOOK_AHEAD = 50;

void main()
{
    // starting position
    int nStart = GetLocalInt(GetModule(), "nQueueMin");
    int nCount = 0;

    int nCreature;
    string sCreature;
    int nThemeNum;


    int nLine;
    string sRead;
    int nRead;
    string s2DA = "miniboss";
    int nMinCR;
    int nMaxCR;
    int bIntelligent;
    int bMediumSize;

    object oMicroCPU;


    // cycle through entries in the list
    string sResRef = "default";
    while ((sResRef != "") && (nCount < ID1_STEP_SIZE))
    {
        // get the resref of the current object
        sResRef = Get2DAString("miniboss", "ResRef", nStart + nCount);

        if (sResRef != "")
        {
            DebugMessage("  Miniboss 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);

            // add creature to list
            nCreature = GetLocalInt(GetModule(), "nMiniBoss");
            nCreature++;
            SetLocalInt(GetModule(), "nMiniBoss", nCreature);
//            SetLocalInt(GetModule(), "nMiniBoss" + IntToString(nCreature) + "Line", nStart + nCount);

            nThemeNum = GetLocalInt(GetModule(), "nTheme1MiniBoss");
            nThemeNum++;
            SetLocalInt(GetModule(), "nTheme1MiniBoss", nThemeNum);
            SetLocalInt(GetModule(), "nTheme1MiniBoss" + IntToString(nThemeNum), nCreature);

            sCreature = "MiniBoss" + IntToString(nCreature);

            SetLocalInt(GetModule(), "nMiniBoss_" + sResRef, nCreature);
            SetLocalString(GetModule(), "s" + sCreature + "ResRef", sResRef);


            // read in remaining creature details
            oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU58");
            SetLocalInt(oMicroCPU, "nLine", nStart + nCount);
            SetLocalString(oMicroCPU, "sCreature", sCreature);
            SetLocalString(oMicroCPU, "s2DA", "miniboss");
            DelayCommand(0.01, ExecuteScript("exe_id1_miccre", oMicroCPU));








/*
            // EDIT: add in creature generation information
            SetLocalInt(GetModule(), "b" + sCreature + "Generated", TRUE);

            nLine = GetLocalInt(GetModule(), "n" + sCreature + "Line");

            // store names
            sRead = Get2DAString(s2DA, "Name_Singular", nLine);
            SetLocalString(GetModule(), "s" + sCreature + "NameSingular", sRead);
            DebugMessage("  Singular is " + sRead);
            sRead = Get2DAString(s2DA, "Name_Plural", nLine);
            SetLocalString(GetModule(), "s" + sCreature + "NamePlural", sRead);
            DebugMessage("  Plural is " + sRead);

            // store base CR
            sRead = Get2DAString(s2DA, "MinCR", nLine);
            if (sRead == "1/8")
            {
                nRead = -2;
            } else if (sRead == "1/4")
            {
                nRead = -1;
            } else if (sRead == "1/2")
            {
                nRead = 0;
            } else
            {
                nRead = StringToInt(sRead);
            }
            if (nRead < -2)
            {
                nRead = -2;
            }
            if (nRead > 99)
            {
                nRead = 99;
            }
            SetLocalInt(GetModule(), "n" + sCreature + "MinCR", nRead);
            DebugMessage("  Setting n" + sCreature + "MinCR to " + IntToString(nRead));
            nMinCR = nRead;

            // store max CR
            sRead = Get2DAString(s2DA, "MaxCR", nLine);
            if (sRead == "1/8")
            {
                nRead = -2;
            } else if (sRead == "1/4")
            {
                nRead = -1;
            } else if (sRead == "1/2")
            {
                nRead = 0;
            } else
            {
                nRead = StringToInt(sRead);
            }
            if (nRead < nMinCR)
            {
                nRead = nMinCR;
            }
            if (nRead > 99)
            {
                nRead = 99;
            }
            SetLocalInt(GetModule(), "n" + sCreature + "MaxCR", nRead);
            DebugMessage("  Setting n" + sCreature + "MaxCR to " + IntToString(nRead));
            nMaxCR = nRead;

            // intelligent
            sRead = Get2DAString(s2DA, "Intelligent", nLine);
            nRead = StringToInt(sRead);
            SetLocalInt(GetModule(), "b" + sCreature + "Intelligent", nRead);
            DebugMessage("  Setting b" + sCreature + "Intelligent to " + IntToString(nRead));
            bIntelligent = nRead;

            // medium size
            sRead = Get2DAString(s2DA, "MediumSize", nLine);
            nRead = StringToInt(sRead);
            SetLocalInt(GetModule(), "b" + sCreature + "MediumSize", nRead);
            DebugMessage("  Setting b" + sCreature + "MediumSize to " + IntToString(nRead));
            bMediumSize = nRead;

            // level up class
            sRead = Get2DAString(s2DA, "Class", nLine);
            if (sRead == "")
            {
                nRead = -1;
            } else
            {
                nRead = StringToInt(sRead);
            }
            SetLocalInt(GetModule(), "n" + sCreature + "Class", nRead);
            DebugMessage("  Setting class to " + IntToString(nRead));

            // level up class starting HD
            sRead = Get2DAString(s2DA, "ClassStartHD", nLine);
            if (sRead == "")
            {
                nRead = -1;
            } else
            {
                nRead = StringToInt(sRead);
            }
            SetLocalInt(GetModule(), "n" + sCreature + "ClassStartHD", nRead);
            DebugMessage("  Setting level up class start HD to " + IntToString(nRead));

            // treasure - gold
            sRead = Get2DAString(s2DA, "TreasureGold", nLine);
            nRead = StringToInt(sRead);
            SetLocalInt(GetModule(), "b" + sCreature + "TreasureGold", nRead);
            DebugMessage("  Setting TreasureGold to " + IntToString(nRead));

            // treasure - gems
            sRead = Get2DAString(s2DA, "TreasureGems", nLine);
            nRead = StringToInt(sRead);
            SetLocalInt(GetModule(), "b" + sCreature + "TreasureGems", nRead);
            DebugMessage("  Setting TreasureGems to " + IntToString(nRead));

            // treasure - items
            sRead = Get2DAString(s2DA, "TreasureItems", nLine);
            nRead = StringToInt(sRead);
            SetLocalInt(GetModule(), "b" + sCreature + "TreasureItems", nRead);
            DebugMessage("  Setting TreasureItems to " + IntToString(nRead));

            // equip weapon
            sRead = Get2DAString(s2DA, "EquipWeapon", nLine);
            nRead = StringToInt(sRead);
            SetLocalInt(GetModule(), "b" + sCreature + "EquipWeapon", nRead);
            DebugMessage("  Setting EquipWeapon to " + IntToString(nRead));

            // equip armor
            sRead = Get2DAString(s2DA, "EquipArmor", nLine);
            nRead = StringToInt(sRead);
            SetLocalInt(GetModule(), "b" + sCreature + "EquipArmor", nRead);
            DebugMessage("  Setting EquipArmor to " + IntToString(nRead));

            // sub type
            sRead = Get2DAString(s2DA, "SubType", nLine);
            nRead = StringToInt(sRead);
            SetLocalInt(GetModule(), "b" + sCreature + "SubType", nRead);

            // catalog subtypes
            if (nRead == TRUE)
            {
                sResRef = GetLocalString(GetModule(), "s" + sCreature + "ResRef");
                DebugMessage("  Subtypes are present. Reading file " + sResRef);

                nRead = 0;
                sRead = Get2DAString(sResRef, "ResRef", nRead);
                DebugMessage("  sRead is " + sRead);
                while (sRead != "")
                {
                    nRead++;
                    SetLocalInt(GetModule(), "n" + sCreature + "SubTypeNum", nRead);

                    // resref
                    DebugMessage("    Setting subtype " + IntToString(nRead) + " to " + sRead);
                    SetLocalString(GetModule(), "s" + sCreature + "SubType" + IntToString(nRead) + "ResRef", sRead);

                    // class
                    sRead = Get2DAString(sResRef, "Class", nRead - 1);
                    DebugMessage("    Setting class " + IntToString(nRead) + " to " + sRead);
                    if (sRead == "")
                    {
                        SetLocalInt(GetModule(), "n" + sCreature + "SubType" + IntToString(nRead) + "Class", -1);
                    } else
                    {
                        SetLocalInt(GetModule(), "n" + sCreature + "SubType" + IntToString(nRead) + "Class", StringToInt(sRead));
                    }

                    sRead = Get2DAString(sResRef, "ResRef", nRead);
                }
            }
*/











        }

        nCount++;
    }

    // if a null string was returned
    if (sResRef == "")
    {
        DebugMessage("  Miniboss 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);

        nStart = nStart + nCount;

        // check the next set of entries to see if any more exist
        int nCount = 0;
        while ((sResRef == "") && (nCount < ID1_LOOK_AHEAD))
        {
            // increment counter
            nCount++;

            // grab resref
            sResRef = Get2DAString("miniboss", "OBJECT_RESREF", nStart + nCount);
            DebugMessage("  Miniboss 2DA line " + IntToString(nStart + nCount) + " is " + sResRef);
        }

        // if another entry was found
        if (sResRef != "")
        {
            DebugMessage("    Object found at entry " + IntToString(nStart + nCount));

            // set new start point
            SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

            // examine entries at new start point
            DelayCommand(0.01, ExecuteScript("exe_id1_catmini", GetNextCPU()));
        } else // if no entry was found
        {
            DebugMessage("    No more minibosses found.");

            SetLocalInt(GetModule(), "nQueueMin", 0);

            SetLocalInt(GetModule(), "bTheme1MiniBossGenerated", TRUE);

            // return to the catalog
            DelayCommand(0.01, ExecuteScript("exe_id1_cathold", GetNextCPU()));
        }
    } else // if all examined entries were used
    {
        DebugMessage("    Examining next set of entries.");

        // set new starting point
        SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

        // examine entries at new start point
        DelayCommand(0.01, ExecuteScript("exe_id1_catmini", GetNextCPU()));
    }
}

/*
// store names
sRead = Get2DAString("miniboss", "Name_Singular", nStart + nCount);
SetLocalString(GetModule(), "s" + sCreature + "NameSingular", sRead);
sRead = Get2DAString("miniboss", "Name_Plural", nStart + nCount);
SetLocalString(GetModule(), "s" + sCreature + "NamePlural", sRead);

DebugMessage("  Line " + IntToString(nStart + nCount) + ": Object " + sResRef + " with name " + sRead);
DebugMessage("    Adding " + sCreature);

// store base CR
sRead = Get2DAString("miniboss", "BaseCR", nStart + nCount);
if (sRead == "1/8")
{
    nRead = -2;
} else if (sRead == "1/4")
{
    nRead = -1;
} else if (sRead == "1/2")
{
    nRead = 0;
} else
{
    nRead = StringToInt(sRead);
}
if (nRead < -2)
{
    nRead = -2;
}
if (nRead > 99)
{
    nRead = 99;
}
SetLocalInt(GetModule(), "n" + sCreature + "MinCR", nRead);
DebugMessage("    Setting n" + sCreature + "MinCR to " + IntToString(nRead));
nMinCR = nRead;

// store max CR
sRead = Get2DAString("miniboss", "MaxCR", nStart + nCount);
if (sRead == "1/8")
{
    nRead = -2;
} else if (sRead == "1/4")
{
    nRead = -1;
} else if (sRead == "1/2")
{
    nRead = 0;
} else
{
    nRead = StringToInt(sRead);
}
if (nRead < nMinCR)
{
    nRead = nMinCR;
}
if (nRead > 99)
{
    nRead = 99;
}
SetLocalInt(GetModule(), "n" + sCreature + "MaxCR", nRead);
DebugMessage("    Setting n" + sCreature + "MaxCR to " + IntToString(nRead));
nMaxCR = nRead;

// store base HD
sRead = Get2DAString("miniboss", "BaseHD", nStart + nCount);
SetLocalInt(GetModule(), "n" + sCreature + "BaseHD", nRead);
DebugMessage("    Setting n" + sCreature + "MinHD to " + IntToString(nRead));

// store max HD
sRead = Get2DAString("miniboss", "MaxHD", nStart + nCount);
SetLocalInt(GetModule(), "n" + sCreature + "MaxHD", nRead);
DebugMessage("    Setting n" + sCreature + "MaxHD to " + IntToString(nRead));

// intelligent
sRead = Get2DAString("miniboss", "Intelligent", nStart + nCount);
nRead = StringToInt(sRead);
SetLocalInt(GetModule(), "b" + sCreature + "Intelligent", nRead);
DebugMessage("    Setting b" + sCreature + "Intelligent to " + IntToString(nRead));
bIntelligent = nRead;

// medium size
sRead = Get2DAString("miniboss", "MediumSize", nStart + nCount);
nRead = StringToInt(sRead);
SetLocalInt(GetModule(), "b" + sCreature + "MediumSize", nRead);
DebugMessage("    Setting b" + sCreature + "MediumSize to " + IntToString(nRead));
bMediumSize = nRead;

// level up class
sRead = Get2DAString("miniboss", "Class", nStart + nCount);
if (sRead == "")
{
    nRead = -1;
} else
{
    nRead = StringToInt(sRead);
}
SetLocalInt(GetModule(), "n" + sCreature + "Class", nRead);
DebugMessage("    Setting class to " + IntToString(nRead));

// level up class starting HD
sRead = Get2DAString("miniboss", "ClassStartHD", nStart + nCount);
if (sRead == "")
{
    nRead = -1;
} else
{
    nRead = StringToInt(sRead);
}
SetLocalInt(GetModule(), "n" + sCreature + "ClassStartHD", nRead);
DebugMessage("    Setting level up class start HD to " + IntToString(nRead));

// treasure - gold
sRead = Get2DAString("miniboss", "TreasureGold", nStart + nCount);
nRead = StringToInt(sRead);
SetLocalInt(GetModule(), "b" + sCreature + "TreasureGold", nRead);
DebugMessage("    Setting TreasureGold to " + IntToString(nRead));

// treasure - gems
sRead = Get2DAString("miniboss", "TreasureGems", nStart + nCount);
nRead = StringToInt(sRead);
SetLocalInt(GetModule(), "b" + sCreature + "TreasureGems", nRead);
DebugMessage("    Setting TreasureGems to " + IntToString(nRead));

// treasure - items
sRead = Get2DAString("miniboss", "TreasureItems", nStart + nCount);
nRead = StringToInt(sRead);
SetLocalInt(GetModule(), "b" + sCreature + "TreasureItems", nRead);
DebugMessage("    Setting TreasureItems to " + IntToString(nRead));

// equip weapon
sRead = Get2DAString("miniboss", "EquipWeapon", nStart + nCount);
nRead = StringToInt(sRead);
SetLocalInt(GetModule(), "b" + sCreature + "EquipWeapon", nRead);
DebugMessage("    Setting EquipWeapon to " + IntToString(nRead));

// equip armor
sRead = Get2DAString("miniboss", "EquipArmor", nStart + nCount);
nRead = StringToInt(sRead);
SetLocalInt(GetModule(), "b" + sCreature + "EquipArmor", nRead);
DebugMessage("    Setting EquipArmor to " + IntToString(nRead));

// sub type
sRead = Get2DAString("miniboss", "SubType", nStart + nCount);
nRead = StringToInt(sRead);
SetLocalInt(GetModule(), "b" + sCreature + "SubType", nRead);

// catalog subtypes
if (nRead == TRUE)
{
    DebugMessage("Subtypes are present. Reading file " + sResRef);

    nRead = 0;
    sRead = Get2DAString(sResRef, "ResRef", nRead);
    while (sRead != "")
    {
        nRead++;
        SetLocalInt(GetModule(), "n" + sCreature + "SubTypeNum", nRead);

        // resref
        DebugMessage("Setting subtype " + IntToString(nRead) + " to " + sRead);
        SetLocalString(GetModule(), "s" + sCreature + "SubType" + IntToString(nRead) + "ResRef", sRead);

        // class
        sRead = Get2DAString(sResRef, "Class", nRead - 1);
        DebugMessage("Setting class " + IntToString(nRead) + " to " + sRead);
        if (sRead == "")
        {
            SetLocalInt(GetModule(), "n" + sCreature + "SubType" + IntToString(nRead) + "Class", -1);
        } else
        {
            SetLocalInt(GetModule(), "n" + sCreature + "SubType" + IntToString(nRead) + "Class", StringToInt(sRead));
        }

        sRead = Get2DAString(sResRef, "ResRef", nRead);
    }
}*/

