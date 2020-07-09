//:://////////////////////////////////////////////////////////////
//:: inc_id1_utility\                                           //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    EDIT
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: September 2005                                 //
//:://////////////////////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id_packages"

//////////////////////////////////////////////////////////////////
// Function Prototypes                                          //
//////////////////////////////////////////////////////////////////

// Converts an integer into a string of at least the specified
// number of digits, including the negative symbol.
// - iNum: The number to be converted into a string.
// - iDigits: The minimum number of digits in the output string.
// * Returns the string produced from the specified digits.
string IntToStringDigits(int iNum, int iDigits);

// Get the next CPU for processing purposes.
// - No input values.
// * Returns the next CPU object based on information stored
//   on the current CPU.
object GetNextCPU();

object GetCurrentDungeon();

int GetCurrentLevel();

int GetPartyLevel(object oPC, int bTotal = FALSE);

int GetPartySize(object oPC, int bTotal = FALSE);

int DecodeAlphaNumeric(string sNum);

string EncodeAlphaNumeric(int nNum);

void CleanItems(object oCreature);

int IsEquippableRace(int nRace);

int IntExponent(int nBase, int nExponent);
float FloatExponent(float fBase, int nExponent);
int IntRandomExponentialCurve(int nBase, int nNumber);
string RemoveIllegalCharacters(string sString);

void PayHenchmanTithe(object oPC, int nGold);

void SetExploredState(object oPC, string sPC, int nArea, int nLevel, int nState, object oDungeon);
int GetExploredState(object oPC, string sPC, int nArea, int nLevel, object oDungeon);
int GetPCListNum(object oPC, string sPC, object oDungeon);

string GetPCIdentifier(object oPC);

//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

// Converts an integer into a string of at least the specified
// number of digits, including the negative symbol.
// - iNum: The number to be converted into a string.
// - iDigits: The minimum number of digits in the output string.
// * Returns the string produced from the specified digits.
string IntToStringDigits(int iNum, int iDigits)
{
    int i;
    int iTemp = 1;
    string sTemp = "";

    // determine the number that falls into this number of digits
    for (i = 1; i < iDigits; i++)
    {
        iTemp *= 10;
    }

    // if iNum is a negative number
    if (iNum < 0)
    {
        // add the negative sign in front of the number
        sTemp = sTemp + "-";

        // reduce the number of characters available by one
        iTemp /= 10;
    }

    // if iNum is already at least the maximum number of characters
    if (abs(iNum) > iTemp)
    {
        // if iNum is already too big, just print it
        // this overrides the negative symbol already present if it's a negative number
        sTemp = IntToString(iNum);
    } else
    {
        // if the number need to be padded with 0s, pad until the number starts
        while (iTemp > abs(iNum))
        {
            if (!((iTemp == 1) && (iNum == 0)))
            {
                // pad with a 0
                sTemp = sTemp + "0";
            }

            // go to the next digit
            iTemp /= 10;
        }

        // add the number in the remaining characters
        sTemp = sTemp + IntToString(abs(iNum));
    }

    return sTemp;
}

// Get the next CPU for processing purposes.
// - No input values.
// * Returns the next CPU object based on information stored
//   on the current CPU.
object GetNextCPU()
{
    string sCPU = GetLocalString(OBJECT_SELF, "sNext");
    DebugMessage("Next CPU is " + sCPU);
    return GetObjectByTag(GetLocalString(OBJECT_SELF, "sNext"));
}

object GetCurrentDungeon()
{
    return GetLocalObject(GetModule(), "oCurrentDungeon");
}

int GetPartyLevel(object oPC, int bTotal = FALSE)
{
    // if only a single party is being considered
    if (bTotal == FALSE)
    {
        DebugMessage("Examining single party.");

        int nFactionMember = 0;
        int nFactionLevel = 0;

        object oFactionMember = GetFirstFactionMember(oPC, TRUE);

        if (oFactionMember != OBJECT_INVALID)
        {
            // add each faction member
            while (oFactionMember != OBJECT_INVALID)
            {
                nFactionMember++;
                nFactionLevel += GetHitDice(oFactionMember);

                DebugMessage("  Faction member " + IntToString(nFactionMember) + " is level " + IntToString(nFactionLevel));

                oFactionMember = GetNextFactionMember(oPC, TRUE);
            }
        } else // if this fails
        {
            nFactionMember = 1;
            nFactionLevel = GetHitDice(oPC);
        }

        if (nFactionMember < 1)
        {
            nFactionMember = 1;
        }

        if (nFactionLevel < 1)
        {
            nFactionLevel = 1;
        }

        return nFactionLevel / nFactionMember;
    } else // if all PCs are being considered
    {
        DebugMessage("Examining all PCs.");

        // get next pc
        object oPlayer = GetFirstPC();
        int nPlayerNumber = 0;
        int nPlayerLevel = 0;

        // add each player
        while (oPlayer != OBJECT_INVALID)
        {
            nPlayerNumber++;
            nPlayerLevel += GetHitDice(oPlayer);

            DebugMessage("  Player number " + IntToString(nPlayerNumber) + " is level " + IntToString(nPlayerLevel));

            oPlayer = GetNextPC();
        }

        if (nPlayerNumber < 1)
        {
            nPlayerNumber = 1;
        }

        if (nPlayerLevel < 1)
        {
            nPlayerLevel = 1;
        }

        return nPlayerLevel / nPlayerNumber;
    }
}

int GetPartySize(object oPC, int bTotal = FALSE)
{
    if (bTotal == FALSE)
    {
        float fPartySize = 0.0;

        // get the first party member
        object oPartyMember = GetFirstFactionMember(oPC, FALSE);

        if (oPartyMember != OBJECT_INVALID)
        {
            // cycle through all party members
            while (oPartyMember != OBJECT_INVALID)
            {
                // if this member is a PC
                if (GetIsPC(oPartyMember) == TRUE)
                {
                    fPartySize += 1.0;
                } else // if this member is an NPC
                {
                    fPartySize += 0.5;
                }

                // cycle to the next party member
                oPartyMember = GetNextFactionMember(oPC, FALSE);
            }
        } else // if this fails for some reason
        {
            fPartySize = 1.0;
        }

        return FloatToInt(fPartySize);
    } else
    {
        int nFaction = 0;
        float fPartySize = 0.0;
        object oFactionLeader;
        object oFactionMember;
        int nCount;
        int bPresent;
        object oOldLeader;

        // get first pc
        object oPlayer = GetFirstPC();

        while (oPlayer != OBJECT_INVALID)
        {
            DebugMessage("  Current faction " + IntToString(nFaction));

            // get faction leader
            oFactionLeader = GetFactionLeader(oPlayer);

            nCount = 1;
            bPresent = FALSE;
            while ((nCount <= nFaction) && (bPresent == FALSE))
            {
                DebugMessage("    Comparing to faction " + IntToString(nCount));

                oOldLeader = GetLocalObject(GetModule(), "oFactionLeader" + IntToString(nCount));

                // if this faction is already present
                if (GetFactionEqual(oFactionLeader, oOldLeader) == TRUE)
                {
                    DebugMessage("      Faction already present.");

                    bPresent = TRUE;
                } else
                {
                    DebugMessage("      Factions do not match.");

                    nCount++;
                }
            }

            if (bPresent == FALSE)
            {
                DebugMessage("    Faction not present.");

                nFaction++;

                // record faction leader
                SetLocalObject(GetModule(), "oFactionLeader" + IntToString(nFaction), oFactionLeader);

                // get all faction members
                oFactionMember = GetFirstFactionMember(oFactionLeader, FALSE);

                // cycle through all faction members
                while (oFactionMember != OBJECT_INVALID)
                {
                    // if this member is a PC
                    if (GetIsPC(oFactionMember) == TRUE)
                    {
                        DebugMessage("Valid PC faction member.");

                        fPartySize += 1.0;
                    } else // if this member is an NPC
                    {
                        DebugMessage("Valid NPC faction member.");

                        fPartySize += 0.5;
                    }

                    // cycle to the next party member
                    oFactionMember = GetNextFactionMember(oFactionLeader, FALSE);
                }
            }

            // get the next player
            oPlayer = GetNextPC();
        }

        return FloatToInt(fPartySize);
    }
}

int DecodeAlphaNumeric(string sNum)
{
    if (sNum == "1")
    {
        return 1;
    } else if (sNum == "2")
    {
        return 2;
    } else if (sNum == "3")
    {
        return 3;
    } else if (sNum == "4")
    {
        return 4;
    } else if (sNum == "5")
    {
        return 5;
    } else if (sNum == "6")
    {
        return 6;
    } else if (sNum == "7")
    {
        return 7;
    } else if (sNum == "8")
    {
        return 8;
    } else if (sNum == "9")
    {
        return 9;
    } else if (sNum == "a")
    {
        return 10;
    } else if (sNum == "b")
    {
        return 11;
    } else if (sNum == "c")
    {
        return 12;
    } else if (sNum == "d")
    {
        return 13;
    } else if (sNum == "e")
    {
        return 14;
    } else if (sNum == "f")
    {
        return 15;
    } else if (sNum == "g")
    {
        return 16;
    } else if (sNum == "h")
    {
        return 17;
    } else if (sNum == "i")
    {
        return 18;
    } else if (sNum == "j")
    {
        return 19;
    } else if (sNum == "k")
    {
        return 20;
    } else if (sNum == "l")
    {
        return 21;
    } else if (sNum == "m")
    {
        return 22;
    } else if (sNum == "n")
    {
        return 23;
    } else if (sNum == "o")
    {
        return 24;
    } else if (sNum == "p")
    {
        return 25;
    } else if (sNum == "q")
    {
        return 26;
    } else if (sNum == "r")
    {
        return 27;
    } else if (sNum == "s")
    {
        return 28;
    } else if (sNum == "t")
    {
        return 29;
    } else if (sNum == "u")
    {
        return 30;
    } else if (sNum == "v")
    {
        return 31;
    } else if (sNum == "w")
    {
        return 32;
    } else if (sNum == "x")
    {
        return 33;
    } else if (sNum == "y")
    {
        return 34;
    } else if (sNum == "z")
    {
        return 35;
    } else if (sNum == "A")
    {
        return 36;
    } else if (sNum == "B")
    {
        return 37;
    } else if (sNum == "C")
    {
        return 38;
    } else if (sNum == "D")
    {
        return 39;
    } else if (sNum == "E")
    {
        return 40;
    } else if (sNum == "F")
    {
        return 41;
    } else if (sNum == "G")
    {
        return 42;
    } else if (sNum == "H")
    {
        return 43;
    } else if (sNum == "I")
    {
        return 44;
    } else if (sNum == "J")
    {
        return 45;
    } else if (sNum == "K")
    {
        return 46;
    } else if (sNum == "L")
    {
        return 47;
    } else if (sNum == "M")
    {
        return 48;
    } else if (sNum == "N")
    {
        return 49;
    } else if (sNum == "O")
    {
        return 50;
    } else if (sNum == "P")
    {
        return 51;
    } else if (sNum == "Q")
    {
        return 52;
    } else if (sNum == "R")
    {
        return 53;
    } else if (sNum == "S")
    {
        return 54;
    } else if (sNum == "T")
    {
        return 55;
    } else if (sNum == "U")
    {
        return 56;
    } else if (sNum == "V")
    {
        return 57;
    } else if (sNum == "W")
    {
        return 58;
    } else if (sNum == "X")
    {
        return 59;
    } else if (sNum == "Y")
    {
        return 60;
    } else if (sNum == "Z")
    {
        return 61;
    }

    return 0;
}

string EncodeAlphaNumeric(int nNum)
{
    if (nNum == 1)
    {
        return "1";
    } else if (nNum == 2)
    {
        return "2";
    } else if (nNum == 3)
    {
        return "3";
    } else if (nNum == 4)
    {
        return "4";
    } else if (nNum == 5)
    {
        return "5";
    } else if (nNum == 6)
    {
        return "6";
    } else if (nNum == 7)
    {
        return "7";
    } else if (nNum == 8)
    {
        return "8";
    } else if (nNum == 9)
    {
        return "9";
    } else if (nNum == 10)
    {
        return "a";
    } else if (nNum == 11)
    {
        return "b";
    } else if (nNum == 12)
    {
        return "c";
    } else if (nNum == 13)
    {
        return "d";
    } else if (nNum == 14)
    {
        return "e";
    } else if (nNum == 15)
    {
        return "f";
    } else if (nNum == 16)
    {
        return "g";
    } else if (nNum == 17)
    {
        return "h";
    } else if (nNum == 18)
    {
        return "i";
    } else if (nNum == 19)
    {
        return "j";
    } else if (nNum == 20)
    {
        return "k";
    } else if (nNum == 21)
    {
        return "l";
    } else if (nNum == 22)
    {
        return "m";
    } else if (nNum == 23)
    {
        return "n";
    } else if (nNum == 24)
    {
        return "o";
    } else if (nNum == 25)
    {
        return "p";
    } else if (nNum == 26)
    {
        return "q";
    } else if (nNum == 27)
    {
        return "r";
    } else if (nNum == 28)
    {
        return "s";
    } else if (nNum == 29)
    {
        return "t";
    } else if (nNum == 30)
    {
        return "u";
    } else if (nNum == 31)
    {
        return "v";
    } else if (nNum == 32)
    {
        return "w";
    } else if (nNum == 33)
    {
        return "x";
    } else if (nNum == 34)
    {
        return "y";
    } else if (nNum == 35)
    {
        return "z";
    } else if (nNum == 36)
    {
        return "A";
    } else if (nNum == 37)
    {
        return "B";
    } else if (nNum == 38)
    {
        return "C";
    } else if (nNum == 39)
    {
        return "D";
    } else if (nNum == 40)
    {
        return "E";
    } else if (nNum == 41)
    {
        return "F";
    } else if (nNum == 42)
    {
        return "G";
    } else if (nNum == 43)
    {
        return "H";
    } else if (nNum == 44)
    {
        return "I";
    } else if (nNum == 45)
    {
        return "J";
    } else if (nNum == 46)
    {
        return "K";
    } else if (nNum == 47)
    {
        return "L";
    } else if (nNum == 48)
    {
        return "M";
    } else if (nNum == 49)
    {
        return "N";
    } else if (nNum == 50)
    {
        return "O";
    } else if (nNum == 51)
    {
        return "P";
    } else if (nNum == 52)
    {
        return "Q";
    } else if (nNum == 53)
    {
        return "R";
    } else if (nNum == 54)
    {
        return "S";
    } else if (nNum == 55)
    {
        return "T";
    } else if (nNum == 56)
    {
        return "U";
    } else if (nNum == 57)
    {
        return "V";
    } else if (nNum == 58)
    {
        return "W";
    } else if (nNum == 59)
    {
        return "X";
    } else if (nNum == 60)
    {
        return "Y";
    } else if (nNum == 61)
    {
        return "Z";
    }

    return "0";
}

int GetCurrentLevel()
{
    return GetLocalInt(GetModule(), "nCurrentLevel");
}

void CleanItems(object oCreature)
{
    int nSlot;
    object oItem;
    for (nSlot = 0; nSlot <= 13; nSlot++)
    {
        DestroyObject(GetItemInSlot(nSlot, oCreature));
    }
    oItem = GetFirstItemInInventory(oCreature);
    while(GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oCreature);
    }
}

int IsEquippableRace(int nRace)
{
    switch (nRace)
    {
        case RACIAL_TYPE_DWARF:
            return TRUE;
            break;

        case RACIAL_TYPE_ELF:
            return TRUE;
            break;

        case RACIAL_TYPE_FEY:
            return TRUE;
            break;

        case RACIAL_TYPE_GIANT:
            return TRUE;
            break;

        case RACIAL_TYPE_GNOME:
            return TRUE;
            break;

        case RACIAL_TYPE_HALFELF:
            return TRUE;
            break;

        case RACIAL_TYPE_HALFLING:
            return TRUE;
            break;

        case RACIAL_TYPE_HALFORC:
            return TRUE;
            break;

        case RACIAL_TYPE_HUMAN:
            return TRUE;
            break;

        case RACIAL_TYPE_HUMANOID_GOBLINOID:
            return TRUE;
            break;

        case RACIAL_TYPE_HUMANOID_MONSTROUS:
            return TRUE;
            break;

        case RACIAL_TYPE_HUMANOID_ORC:
            return TRUE;
            break;

        case RACIAL_TYPE_HUMANOID_REPTILIAN:
            return TRUE;
            break;

        case RACIAL_TYPE_OUTSIDER:
            return TRUE;
            break;

        case RACIAL_TYPE_SHAPECHANGER:
            return TRUE;
            break;

        case RACIAL_TYPE_UNDEAD:
            return TRUE;
            break;
    }

    return FALSE;
}

// calculates nBase^nExponent
int IntExponent(int nBase, int nExponent)
{
    DebugMessage("Calculating " + IntToString(nBase) + " to the power of " + IntToString(nExponent));

    if (nExponent < 1)
    {
        DebugMessage("  Exponent was less than 1.");

        return 1;
    } else
    {
        int nCount = 1;
        int nTotal = nBase;
        DebugMessage("  Exponent " + IntToString(nCount) + " is " + IntToString(nTotal));

        while (nCount < nExponent)
        {
            nTotal *= nBase;

            nCount++;

            DebugMessage("  Exponent " + IntToString(nCount) + " is " + IntToString(nTotal));
        }

        return nTotal;
    }
}

// calculates fBase^nExponent
float FloatExponent(float fBase, int nExponent)
{
    DebugMessage("Calculating " + FloatToString(fBase) + " to the power of " + IntToString(nExponent));

    if (nExponent < 1)
    {
        DebugMessage("  Exponent was less than 1.");

        return 1.0;
    } else
    {
        int nCount = 1;
        float fTotal = fBase;
        DebugMessage("  Exponent " + IntToString(nCount) + " is " + FloatToString(fTotal));

        while (nCount < nExponent)
        {
            fTotal *= fBase;

            nCount++;

            DebugMessage("  Exponent " + IntToString(nCount) + " is " + FloatToString(fTotal));
        }

        return fTotal;
    }
}

// gets a random value along the exponential curve of nBase^nNumber
int IntRandomExponentialCurve(int nBase, int nNumber)
{
    DebugMessage("");
    DebugMessage("Exponential curve calculation.");

    DebugMessage("  Base is " + IntToString(nBase));
    DebugMessage("  Max exponent is " + IntToString(nNumber));

    // test exponents
    int nTotal = IntExponent(nBase, nNumber);
    DebugMessage("  Max value is " + IntToString(nTotal));

    int nRandom = Random(nTotal - 1) + 1;
    DebugMessage("  Random num was " + IntToString(nRandom));

    int nValue;
    int nExponent = 1;
    int bFound = FALSE;
    int nFinal;
    while ((bFound == FALSE) && (nExponent <= nNumber))
    {
        nValue = IntExponent(nBase, nExponent);
        DebugMessage(IntToString(nBase) + " to the power of " + IntToString(nExponent) + " is " + IntToString(nValue));
        DebugMessage("    Comparing random value " + IntToString(nRandom) + " to " + IntToString(nValue));

        if (nRandom < nValue)
        {
            bFound = TRUE;
        } else
        {
            nExponent++;
        }
    }

    if (bFound == TRUE)
    {
        DebugMessage("  Result found.");
        nFinal = nNumber - nExponent + 1;
        DebugMessage("  Exponent was " + IntToString(nExponent) + " resulting in final value of " + IntToString(nFinal));
    } else
    {
        DebugMessage("  No result found.");

        nFinal = 0;
    }

    return nFinal;
}

string RemoveIllegalCharacters(string sString)
{
    string sNewString = "";
    int nLength = GetStringLength(sString);

    DebugMessage("Original is " + sString + " with length " + IntToString(nLength));

    int nPos = 0;
    string sSub;
    while (nPos < nLength)
    {
        sSub = GetSubString(sString, nPos, 1);
        DebugMessage("Substring is " + sSub);

        if ((sSub != " ") && (sSub != "(") && (sSub != ")") && (sSub != ":") && (sSub != "-") && (sSub != "[") && (sSub != "]"))
        {
            sNewString += sSub;
        }

        nPos++;
    }

    DebugMessage("Final string is " + sNewString);

    return sNewString;
}

void PayHenchmanTithe(object oPC, int nGold)
{
    DebugMessage("Gold amount is " + IntToString(nGold));

    int nGoldPayment = 0;
    int nCount = 1;
    object oHenchman = GetHenchman(oPC, nCount);
    while (oHenchman != OBJECT_INVALID)
    {
        nGoldPayment += GetLocalInt(oHenchman, "nPayment");
        nCount++;
        oHenchman = GetHenchman(oPC, nCount);
    }
    if (nGoldPayment > 0)
    {
        SendMessageToPC(oPC, "Paying henchmen " + IntToString(nGoldPayment) + "% of gold.");
        int nValue = (nGold * nGoldPayment) / 100;
        AssignCommand(GetObjectByTag("DungeonAngel"), TakeGoldFromCreature(nValue, oPC, TRUE));
    }
}

void SetExploredState(object oPC, string sPC, int nArea, int nLevel, int nState, object oDungeon)
{
    int nPC = GetPCListNum(oPC, sPC, oDungeon);

    if (nPC != 0)
    {
        string sPlayerArea = "Player" + IntToString(nPC) + "Area" + IntToString(nArea) + "Level" + IntToString(nLevel);
        DebugMessage("sPlayerArea is " + sPlayerArea);

        SetLocalInt(oDungeon, "n" + sPlayerArea + "Explored", nState);
    }
}

int GetPCListNum(object oPC, string sPC, object oDungeon)
{
    if (oPC != OBJECT_INVALID)
    {
        sPC = GetPCIdentifier(oPC);
    }

    // get PC number
    int nPC = 0;
    DebugMessage("sPC is " + sPC);
    if (sPC != "")
    {
        nPC = GetLocalInt(oDungeon, "nPlayer_" + sPC);
        DebugMessage("nPlayer_" + sPC + " is " + IntToString(nPC));
        if (nPC == 0)
        {
            nPC = GetLocalInt(oDungeon, "nPlayerNum");
            nPC++;
            SetLocalInt(oDungeon, "nPlayerNum", nPC);
            DebugMessage("Adding player to player exploration list at number " + IntToString(nPC));

            SetLocalString(oDungeon, "sPlayer" + IntToString(nPC) + "Identifier", sPC);
            SetLocalInt(oDungeon, "nPlayer_" + sPC, nPC);
            DebugMessage("Setting nPlayer_" + sPC + " to " + IntToString(nPC));
        }
    }

    return nPC;
}

int GetExploredState(object oPC, string sPC, int nArea, int nLevel, object oDungeon)
{
    int nPC = GetPCListNum(oPC, sPC, oDungeon);

    int nExplore = 0;
    if (nPC != 0)
    {
        string sPlayerArea = "Player" + IntToString(nPC) + "Area" + IntToString(nArea) + "Level" + IntToString(nLevel);
        DebugMessage("sPlayerArea is " + sPlayerArea);

        nExplore = GetLocalInt(oDungeon, "n" + sPlayerArea + "Explored");
    }


    return nExplore;
}

string GetPCIdentifier(object oPC)
{
    string sPublicCDKey = GetPCPublicCDKey(oPC, FALSE);

    if (sPublicCDKey == "") // Player is playing in single player mode.
    {
        sPublicCDKey = GetPCPublicCDKey(oPC, TRUE);
    }

    string sPlayerName = GetName(oPC);
    string sPCIdentifier = sPlayerName + sPublicCDKey;

    return sPCIdentifier;
}

//void main(){}

