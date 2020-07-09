//::///////////////////////////////////////////////
//:: inc_genscrolls
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Include file for the automated scroll system
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

const string S_2DASCROLLFILE = "potsc_scrolls";
const string S_SCROLLRESREF = "SCROLLS_ITEMRESREF_";
const string S_SCROLLFAILED = "SCROLL_FAILED";
const string S_SCROLLCOUNT = "SCROLL_COUNT";

// Dynamicly generate the bootylist on the module from
// the potsc_booty.2DA file
void GenerateScrollList(object oModule = OBJECT_SELF);

// oTarget = The Object to create scrolls on
// iCount = The number of scrolls to create
void CreateScrollsOnObject(object oTarget, int iCount);

// Dynamicly generate the scrolllist on the module
// from the potsc_scrolls.2DA file
void GenerateScrollList(object oModule)
{
    string sScrollResRef = "";
    int iCounterTotal = 0;

    int iDoOnce = GetLocalInt(oModule, "inc_genscrolls");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "inc_genscrolls", TRUE);
        sScrollResRef = Get2DAString(S_2DASCROLLFILE, "RESREF", iCounterTotal);

        while (sScrollResRef != "")
        {
            SetLocalString(oModule, S_SCROLLRESREF + IntToString(iCounterTotal), sScrollResRef);
            iCounterTotal++;
            sScrollResRef = Get2DAString(S_2DASCROLLFILE, "RESREF", iCounterTotal);
        }

        SetLocalInt(oModule, S_SCROLLCOUNT, (iCounterTotal));
    }
}

// Get A ResRef for a Random scroll.
string GetRandomScroll()
{
    object oModule = GetModule();
    int iTotal = GetLocalInt(oModule, S_SCROLLCOUNT);
    int iRand = Random(iTotal);
    string sScrollResRef = "";
    int iUnique = FALSE;
    int iDone = FALSE;

    // Find a Random Generic Item
    sScrollResRef = GetLocalString(oModule, S_SCROLLRESREF + IntToString(iRand));

    //debug text
    //SendMessageToPC(GetFirstPC(), "** CREATE GENERIC '" + sBootyResRef
    //    + "' LIST INDEX :'" + IntToString(iRand) + "'");

    if (sScrollResRef == "")
    {
        sScrollResRef = S_SCROLLFAILED;
    }

    return sScrollResRef;
}

// oTarget = The Object to create scrolls on
// iCount = The number of scrolls to create
void CreateScrollsOnObject(object oTarget, int iCount)
{
    object oCreate = OBJECT_INVALID;
    string sScrollResRef = "";
    int iLoop = 0;

    while (iLoop < iCount)
    {
        sScrollResRef = GetRandomScroll();
        oCreate = CreateItemOnObject(sScrollResRef, oTarget);

        iLoop++;
    }
}
