//::///////////////////////////////////////////////
//:: inc_bootysystem
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Include file for the automated booty system
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

const int BOOTY_ANY = 1;
const int BOOTY_GENERIC = 2;
const int BOOTY_UNIQUE = 3;

const string S_2DAFILE = "potsc_booty";
const string S_UNIQRESREF = "BOOTY_ITEMRESREF_U_";
const string S_GNRCRESREF = "BOOTY_ITEMRESREF_G_";

const string S_UNIQFAILED = "BOOTY_UNIQUE_FAILED";
const string S_GNRCFAILED = "BOOTY_GENERIC_FAILED";

const string S_ITEMCOUNT = "BOOTY_ITEMCOUNT";
const string S_UNIQCOUNT = "BOOTY_UNIQCOUNT";
const string S_GNRCCOUNT = "BOOTY_GNRCCOUNT";

// Dynamicly generate the bootylist on the module from
// the potsc_booty.2DA file
void GenerateBootyList(object oModule = OBJECT_SELF);

// BOOTY_ANY - Either Generic or unique booty may spawn
// BOOTY_GENERIC - Only Low-Value Booty will spawn
// BOOTY_UNIQUE - Only High-Value Booty will spawn
object CreateBootyOnObject(object oTarget, int iFlag = BOOTY_ANY);

// Dynamicly generate the bootylist on the module from
// the potsc_booty.2DA file
void GenerateBootyList(object oModule)
{
    string sBootyResRef = "";
    string sBootyUnique = "";

    int iUnique = 0;
    int iCounterTotal = 0;
    int iCounterUnique = 0;
    int iCounterGeneric = 0;
    int iDoOnce = GetLocalInt(oModule, "inc_bootysystem");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "inc_bootysystem", TRUE);

        sBootyResRef = Get2DAString(S_2DAFILE, "RESREF", iCounterTotal);
        sBootyUnique = Get2DAString(S_2DAFILE, "UNIQUE", iCounterTotal);
        iUnique = StringToInt(sBootyUnique);

        while ((sBootyResRef != "") && (sBootyUnique != ""))
        {
            if (iUnique == 1)
            {
                SetLocalString(oModule, S_UNIQRESREF + IntToString(iCounterUnique), sBootyResRef);
                iCounterUnique++;
            }
            else
            {
                SetLocalString(oModule, S_GNRCRESREF + IntToString(iCounterGeneric), sBootyResRef);
                iCounterGeneric++;
            }

            iCounterTotal++;

            sBootyResRef = Get2DAString(S_2DAFILE, "RESREF", iCounterTotal);
            sBootyUnique = Get2DAString(S_2DAFILE, "UNIQUE", iCounterTotal);
            iUnique = StringToInt(sBootyUnique);
        }

        SetLocalInt(oModule, S_ITEMCOUNT, (iCounterTotal));
        SetLocalInt(oModule, S_UNIQCOUNT, (iCounterUnique));
        SetLocalInt(oModule, S_GNRCCOUNT, (iCounterGeneric));
    }
}

// Get A ResRef for a Unique Item.
string GetUniqueItem()
{
    object oModule = GetModule();
    int iTotal = GetLocalInt(oModule, S_UNIQCOUNT);
    int iRand = Random(iTotal);
    string sBootyResRef = "";
    int iUnique = FALSE;
    int iDone = FALSE;

    // Find a Random UNIQUE Item
    sBootyResRef = GetLocalString(oModule, S_UNIQRESREF + IntToString(iRand));

    if (sBootyResRef == "")
    {
        sBootyResRef = S_UNIQFAILED;
    }

    return sBootyResRef;
}

// Get A ResRef for a Generic Item.
string GetGenericItem()
{
    object oModule = GetModule();
    int iTotal = GetLocalInt(oModule, S_GNRCCOUNT);
    int iRand = Random(iTotal);
    string sBootyResRef = "";
    int iUnique = FALSE;
    int iDone = FALSE;

    // Find a Random Generic Item
    sBootyResRef = GetLocalString(oModule, S_GNRCRESREF + IntToString(iRand));

    //debug text
    //SendMessageToPC(GetFirstPC(), "** CREATE GENERIC '" + sBootyResRef
    //    + "' LIST INDEX :'" + IntToString(iRand) + "'");

    if (sBootyResRef == "")
    {
        sBootyResRef = S_GNRCFAILED;
    }

    return sBootyResRef;
}

// Get A ResRef for a Generic or Unique Item.
string GetRandomItem()
{
    string sBootyResRef;

    if (d2(1) == 1)
    {
        sBootyResRef = GetGenericItem();
    }
    else
    {
        sBootyResRef = GetUniqueItem();
    }

    return sBootyResRef;
}

// BOOTY_ANY - Either Generic or unique booty may spawn
// BOOTY_GENERIC - Only Generic Booty will spawn
// BOOTY_UNIQUE - Only Unique Booty will spawn until no uniques are left
// then it will create eight generics.
object CreateBootyOnObject(object oTarget, int iFlag)
{
    object oCreate = OBJECT_INVALID;
    string sBootyResRef = "";
    int iLoop = 0;

    if (iFlag == BOOTY_UNIQUE)
    {
        sBootyResRef = GetUniqueItem();
        oCreate = CreateItemOnObject(sBootyResRef, oTarget);
    }
    else if (iFlag == BOOTY_GENERIC)
    {
        sBootyResRef = GetGenericItem();
        oCreate = CreateItemOnObject(sBootyResRef, oTarget);
    }
    else if (iFlag == BOOTY_ANY)
    {
        sBootyResRef = GetRandomItem();
        oCreate = CreateItemOnObject(sBootyResRef, oTarget);
    }

    // create stacks of stackables
    if ((GetBaseItemType(oCreate) == BASE_ITEM_BOLT)
    || (GetBaseItemType(oCreate) == BASE_ITEM_ARROW)
    || (GetBaseItemType(oCreate) == BASE_ITEM_BULLET)
    || (GetBaseItemType(oCreate) == BASE_ITEM_DART)
    || (GetBaseItemType(oCreate) == BASE_ITEM_SHURIKEN)
    || (GetBaseItemType(oCreate) == BASE_ITEM_THROWINGAXE))
    {
        SetItemStackSize(oCreate, 50);
    }

    return oCreate;
}
