//::///////////////////////////////////////////////
//:: Name: Misc Tools
//:: FileName: inc_misctools
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This include file contains misc tools that did not fit into other
inc_ categories.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: April 20, 2005
//:://////////////////////////////////////////////

#include "inc_id_constants"
//---------------------------- START PROTOTYPES -------------------------------

//Builds a unique ID between "-99" and "999".
// Illegal values passed return "000"
string Convert3Digit(int i);

// Gets the default database for oObject.
// If oObject is invalid the module will be used.
string GetDBName(object oObject = OBJECT_INVALID);

//Sets the default database for oObject.
// If oObject is invalid the module will be used.
void SetDBName(string sDBName,object oObject = OBJECT_INVALID);

// Simple wrapper checking a DoOnce varible with the Dungeon Level.
void SetDoOnce(object oObject,string sID, int nState = 1);

// Simple wrapper checking a DoOnce varible with the Dungeon Level.
int GetDoOnce(object oObject,string sID);

// Does a 2d10 Roll and returns one of the 4 supplied ints.
int Table2d10i(int iCommon = 1,int iUncommon = 2,int iRare = 3 ,int iVRare = 4);

// Does a 2d10 Roll and returns one of the 4 supplied strings.
string Table2d10s(string sCommon,string sUncommon,string sRare,string sVRare);

// Returns the average party level of oPC.
//This includes PCs and Henchmen but no other associates.
int GetAveragePartyLevel(object oPC);

// Returns the party size of oPC.
// This includes PCs and Henchmen but no other associates.
// Setting nPCOnly to TRUE will result in only PC's being counted.
int GetNumberInParty(object oPC, int nPCOnly = FALSE);

// Sends a message to the leader of oPC's faction.
// The number sent is the same number used to determine dungeon scaling.
void NotifyAveragePartyLevel(object oPC);

// Returns a random value from the 2da.
// This 2da must be set up for this function to work.
// nRoll can be set to a specific value.
// if nRoll is left at 0 a random result based on a d100 will be returned.
string GetD100TableResult(string s2da, string sColumn, int nRoll = 0);


// Returns the "Town" variable set on the area.
// 0 = Dungeons/Dangerous Areas (Default)
// 1 = Town main zone
// 2 = Town subzones
int GetIsInTown(object oPC = OBJECT_SELF);

// Checks to see if all PCs are in town.
// This is looped version of GetIsInTown.
int AllPCsInTown();

// Returns TRUE if all PCs are in oArea.
// DM's are not considered.
int AllPCsInArea(object oArea = OBJECT_SELF);

// Searches oPC's Party (including associates) for an item tagged sItemTag.
// Returns the object if found.
// Returns OBJECT_INVALID if no matching object is found.
object GetPartyHasItem(object oPC, string sItemTag);

// Returns the XP required to gain nLevel.
// nLevel must be a value between 1 and 40.
int GetXPRequiredForLevel(int nLevel);

// Returns the XP required for a PC to gain a level.
int GetMinLevelXP(object oPC,int nLevelToGain = 1);

// Wrapper function for CopyItem.
void VoidCopyItem(object oItem, object oTargetInventory = OBJECT_INVALID,int bCopyVars=FALSE);

// Returns a random ABILITY_*
int GetRandomAbility();

// Determines if another party member is resting.
int IsAnotherPartyMemberResting(object oRester);

// This function is used for creating LARGE amounts of gold.
// Above the 50000 limit.
void CreateGoldLargeAmount(int iGold, object oInventory = OBJECT_SELF);

// Returns oPC or its master if is an associate.
object GetIsPartyMemberOrAssociate(object oPC);

// This function handles the scaling DC for traps and locks.
int IDRandomlyScaledDC(object oPC);

//----------------------------- END PROTO TYPES --------------------------------
string Convert3Digit(int i)
{
    string sReturn = IntToString(i);
    if (i >= 0)
    {
        if (i < 10)         sReturn = "00" + sReturn;
        else if (i < 100)   sReturn = "0" + sReturn;
        else if (i >= 1000) sReturn = "000"; //ERROR
    }
    else
    {
        sReturn = IntToString(abs(i));
        if (i < 10)         sReturn = "-0" + sReturn;
        else if (i < 100)   sReturn = "-" + sReturn;
        else                sReturn = "000"; //Error
    }
    return sReturn;
}

string GetDBName(object oObject)
{
    if (!GetIsObjectValid(oObject))
    {
        oObject = GetModule();
    }
    return GetLocalString(oObject,"DataBase");
}

void SetDBName(string sDBName,object oObject)
{
    if (!GetIsObjectValid(oObject))
    {
        oObject = GetModule();
    }
    SetLocalString(oObject,"DataBase",sDBName);
}

void SetDoOnce(object oObject,string sID, int nState)
{
    if (!nState)
    {
        DeleteLocalInt(oObject,NAME_CON_DO_ONCE+sID);
    }
    else
    {
        SetLocalInt(oObject,NAME_CON_DO_ONCE+sID,nState);
    }
}

int GetDoOnce(object oObject,string sID)
{
    return GetLocalInt(oObject,NAME_CON_DO_ONCE+sID);
}

int Table2d10i(int iCommon,int iUncommon,int iRare,int iVRare)
{
    switch (d10(2))
    {
        case 2:case 20:
        {
            return iVRare;
            break;
        }
        case 3:case 4:case 18:case 19:
        {
            return iRare;
            break;
        }
        case 5:case 6:case 7:case 15:case 16:case 17:
        {
            return iUncommon;
            break;
        }
        case 8:case 9:case 10:case 11:case 12:case 13:case 14:
        {
            return iCommon;
            break;
        }
    };
    return 0;// Added for compile reasons.
}

string Table2d10s(string sCommon,string sUncommon,string sRare,string sVRare)
{
    switch (d10(2))
    {
        case 2:case 20:
        {
            return sVRare;
            break;
        }
        case 3:case 4:case 18:case 19:
        {
            return sRare;
            break;
        }
        case 5:case 6:case 7:case 15:case 16:case 17:
        {
            return sUncommon;
            break;
        }
        case 8:
        case 9:
        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
        {
            return sCommon;
            break;
        }
    };
    return "";// Added for compile reasons.
}

int GetAveragePartyLevel(object oPC)
{
    object oParty = GetFirstFactionMember(oPC,FALSE);
    int nLevel, nNum, nAvg;
    while(GetIsObjectValid(oParty))
    {
        if (GetIsPC(oParty) || GetAssociateType(oParty) == ASSOCIATE_TYPE_HENCHMAN)
        {
            nLevel += GetHitDice(oParty);
            nNum += 1;
        }
        oParty = GetNextFactionMember(oPC,FALSE);
    }
    nAvg = nLevel/nNum;
    if (nAvg < 1)           nAvg = 1;
    else if (nAvg > 40)     nAvg = 40;
    return nAvg;
}

int GetNumberInParty(object oPC, int nPCOnly)
{
    object oParty = GetFirstFactionMember(oPC,nPCOnly);
    int nNum;
    while(GetIsObjectValid(oParty))
    {
        if (GetIsPC(oParty) || GetAssociateType(oParty) == ASSOCIATE_TYPE_HENCHMAN)
        {
            nNum += 1;
        }
        oParty = GetNextFactionMember(oPC,nPCOnly);
    }
    return nNum;
}

void NotifyAveragePartyLevel(object oPC)
{
    object oLeader = GetFactionLeader(oPC);
    int iAPL = GetAveragePartyLevel(oPC);
    SendMessageToPC(oLeader,"Average Party Level is: "+IntToString(iAPL));
}

string GetD100TableResult(string s2da, string sColumn, int nRoll)
{
    if (nRoll == 0)
    {
        nRoll = d100();
    }
    return Get2DAString(s2da,sColumn,nRoll);
}

int GetIsInTown(object oPC)
{
    return GetLocalInt(GetArea(oPC),"Town");
}

int AllPCsInTown()
{
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        if (!GetIsInTown(oPC))
        {
            return FALSE;
        }
        oPC = GetNextPC();
    }
    return TRUE;
}

int AllPCsInArea(object oArea)
{
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        // Don't count DM's
        if (!GetIsDM(oPC))
        {
            // If we find a PC outside oArea return FALSE immediately.
            if (GetArea(oPC) != oArea)
            {
                return FALSE;
            }
        }
        oPC = GetNextPC();
    }
    // No PCs found outside oArea.
    return TRUE;
}

object GetPartyHasItem(object oPC, string sItemTag)
{
    object oParty = GetFirstFactionMember(oPC,FALSE);
    object oObject;
    while(GetIsObjectValid(oPC))
    {
        oObject = GetItemPossessedBy(oParty,sItemTag);
        if (GetIsObjectValid(oObject))
        {
            return oObject;
        }
        oParty = GetFirstFactionMember(oPC,FALSE);
    }
    return OBJECT_INVALID;
}

int GetXPRequiredForLevel(int nLevel)
{
    if (nLevel < 1 || nLevel > 40)
    {
        //Error
        return 0;
    };
    return ((nLevel * (nLevel - 1)) / 2) * 1000;
}

int GetMinLevelXP(object oPC,int nLevel)
{
    int nHD = GetHitDice(oPC) + nLevel;
    int nXP = GetXP(oPC);
    int nMinXPForLevel = ((nHD * (nHD - 1)) / 2) * 1000;
    if (nXP > nMinXPForLevel)
    {
        // oPC already has more XPs than required.
        return 0;
    }
    return nMinXPForLevel -= nXP;
}

void VoidCopyItem(object oItem, object oTargetInventory,int bCopyVars)
{
    CopyItem(oItem,oTargetInventory,bCopyVars);
}

int GetRandomAbility()
{
    int nRoll = d6();
    int nAbility;
    switch (nRoll)
    {
        case 1:
        {
            nAbility = ABILITY_STRENGTH;
            break;
        }
        case 2:
        {
            nAbility = ABILITY_DEXTERITY;
            break;
        }
        case 3:
        {
            nAbility = ABILITY_CONSTITUTION;
            break;
        }
        case 4:
        {
            nAbility = ABILITY_INTELLIGENCE;
            break;
        }
        case 5:
        {
            nAbility = ABILITY_WISDOM;
            break;
        }
        case 6:
        {
            nAbility = ABILITY_CHARISMA;
            break;
        }
    }
    return nAbility;
}

int IsAnotherPartyMemberResting(object oRester)
{
    object oPC = GetFirstFactionMember(oRester);
    while(GetIsObjectValid(oPC))
    {
        if (GetIsResting(oPC))
        {
            return TRUE;
        }
        oPC = GetNextFactionMember(oRester);
    }
    return FALSE;
}

void CreateGoldLargeAmount(int nGold, object oInventory)
{
    while (nGold > 50000)
    {
        CreateItemOnObject(RESREF_ITEM_GOLD,oInventory,50000);
        nGold -= 50000;
    }
    CreateItemOnObject(RESREF_ITEM_GOLD,oInventory,nGold);
}

object GetIsPartyMemberOrAssociate(object oPC)
{
    if (!GetIsPC(oPC))
    {
        if (GetIsObjectValid(GetMaster(oPC)))
        {
            oPC = GetMaster(oPC);
        }
        else
        {
            return OBJECT_INVALID; // Returns this if a non PC or PC Associate
        }
    }
    return oPC;
}

int IDRandomlyScaledDC(object oPC)
{
    int iDC = GetAveragePartyLevel(oPC);
    if (iDC <= 10)
    {
        iDC = (iDC/2);
        if (iDC < 1)
        {
            iDC = 1;
        }
        iDC += Random(11) - 5;
        // Possible Values 16 to 30
    }
    else if (iDC <= 20)
    {
        iDC += Random(11) - 5;
        // Possible Values 26 to 45
    }
    else // EPIC
    {
        iDC += Random(21) - 10;
        // Possible Values 31 to 70
    }
    // We will
    iDC += 20; // This should be the "normal" level.
    return iDC;
}
