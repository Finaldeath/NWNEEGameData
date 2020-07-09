#include "inc_id1_debug"
#include "inc_id1_creature"

void main()
{
    int nLine = GetLocalInt(OBJECT_SELF, "nLine");
    string sCreature = GetLocalString(OBJECT_SELF, "sCreature");
    DebugMessage("Cataloging " + sCreature);
    string s2DA = GetLocalString(OBJECT_SELF, "s2DA");
    int nCreature = GetLocalInt(OBJECT_SELF, "nCreature");

    string sRead;
    int nRead;

    // name singular
    sRead = Get2DAString(s2DA, "Name_Singular", nLine);
    SetLocalString(GetModule(), "s" + sCreature + "NameSingular", sRead);
    DebugMessage("  Singular is " + sRead);

    // name plural
    sRead = Get2DAString(s2DA, "Name_Plural", nLine);
    SetLocalString(GetModule(), "s" + sCreature + "NamePlural", sRead);
    DebugMessage("  Plural is " + sRead);

    // min cr
    sRead = Get2DAString(s2DA, "MinCR", nLine);
    if (sRead == "1/4")
    {
        nRead = -1;
    } else if (sRead == "1/2")
    {
        nRead = 0;
    } else
    {
        nRead = StringToInt(sRead);
    }
    if (nRead < -1)
    {
        nRead = -1;
    }
    if (nRead > 50)
    {
        nRead = 50;
    }
    SetLocalInt(GetModule(), "n" + sCreature + "MinCR", nRead);
    DebugMessage("  Setting n" + sCreature + "MinCR to " + IntToString(nRead));
    int nMinCR = nRead;

    // max cr
    sRead = Get2DAString(s2DA, "MaxCR", nLine);
    if (sRead == "1/4")
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
    if (nRead > 50)
    {
        nRead = 50;
    }
    SetLocalInt(GetModule(), "n" + sCreature + "MaxCR", nRead);
    DebugMessage("  Setting n" + sCreature + "MaxCR to " + IntToString(nRead));
    int nMaxCR = nRead;

    // class
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

    // class start hd
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

    // attributes (medium-size, intelligent, spellcaster, gold, gems, items, weapon, armor)
    sRead = Get2DAString(s2DA, "Attributes", nLine);
    nRead = StringToInt(sRead);
    SetLocalInt(GetModule(), "n" + sCreature + "Attributes", nRead);
    DebugMessage("  Setting attributes to " + sRead);

    // themes (in order)
    sRead = Get2DAString(s2DA, "Themes", nLine);
    SetLocalString(GetModule(), "s" + sCreature + "Themes", "1" + sRead);
    DebugMessage("  Setting themes to 1" + sRead);

    // subtypes
    string sResRef = GetLocalString(GetModule(), "s" + sCreature + "ResRef");
    string sSubString = GetSubString(sResRef, 0, 7);
    DebugMessage("  Substring of " + sResRef + " is " + sSubString);
    if (sSubString == "SubType")
    {
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

//    if (s2DA == "creatures")
//    {
        DebugMessage("  Adding to CR list. Min CR is " + IntToString(nMinCR) + ", Max CR is " + IntToString(nMaxCR));
        int nCount = nMinCR;
        int nNum;
        string sCategoryString;
        if (s2DA == "creatures")
        {
            sCategoryString = "Creature";
        } else
        {
            sCategoryString = "MiniBoss";
        }
        string sString;
        while (nCount <= nMaxCR)
        {
            sString = "nGeneric" + IntToString(nCount) + sCategoryString;
            nNum = GetLocalInt(GetModule(),  sString + "Num");
            nNum++;
            SetLocalInt(GetModule(), sString + "Num", nNum);
            SetLocalInt(GetModule(), sString + IntToString(nNum), nCreature);
            DebugMessage("    Set " + sString + IntToString(nNum) + " to " + IntToString(nCreature));

            nCount++;
        }
//    }

    DestroyObject(OBJECT_SELF);
}
