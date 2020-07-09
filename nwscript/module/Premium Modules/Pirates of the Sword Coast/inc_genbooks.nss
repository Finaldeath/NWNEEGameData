//::///////////////////////////////////////////////
//:: inc_genbooks
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Include file for the automated book system
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

const string S_2DABOOKFILE = "potsc_books";
const string S_BOOKRESREF = "BOOKS_ITEMRESREF_";
const string S_BOOKFAILED = "BOOK_FAILED";
const string S_BOOKCOUNT = "BOOK_COUNT";

// Dynamicly generate the bootylist on the module from
// the potsc_booty.2DA file
void GenerateBookList(object oModule = OBJECT_SELF);

// oTarget = The Object to create books on
// iCount = The number of books to create
void CreateBooksOnObject(object oTarget, int iCount);

// Dynamicly generate the booklist on the module
// from the potsc_books.2DA file
void GenerateBookList(object oModule)
{
    string sBookResRef = "";
    int iCounterTotal = 0;

    int iDoOnce = GetLocalInt(oModule, "inc_genbooks");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "inc_genbooks", TRUE);
        sBookResRef = Get2DAString(S_2DABOOKFILE, "RESREF", iCounterTotal);

        while (sBookResRef != "")
        {
            SetLocalString(oModule, S_BOOKRESREF + IntToString(iCounterTotal), sBookResRef);
            iCounterTotal++;
            sBookResRef = Get2DAString(S_2DABOOKFILE, "RESREF", iCounterTotal);
        }

        SetLocalInt(oModule, S_BOOKCOUNT, (iCounterTotal));
    }
}

// Get A ResRef for a Random Book.
string GetRandomBook()
{
    object oModule = GetModule();
    int iTotal = GetLocalInt(oModule, S_BOOKCOUNT);
    int iRand = Random(iTotal);
    string sBookResRef = "";
    int iUnique = FALSE;
    int iDone = FALSE;

    // Find a Random Generic Item
    sBookResRef = GetLocalString(oModule, S_BOOKRESREF + IntToString(iRand));

    //debug text
    //SendMessageToPC(GetFirstPC(), "** CREATE GENERIC '" + sBootyResRef
    //    + "' LIST INDEX :'" + IntToString(iRand) + "'");

    if (sBookResRef == "")
    {
        sBookResRef = S_BOOKFAILED;
    }

    return sBookResRef;
}

// oTarget = The Object to create books on
// iCount = The number of books to create
void CreateBooksOnObject(object oTarget, int iCount)
{
    object oCreate = OBJECT_INVALID;
    string sBookResRef = "";
    int iLoop = 0;

    while (iLoop < iCount)
    {
        sBookResRef = GetRandomBook();
        oCreate = CreateItemOnObject(sBookResRef, oTarget);

        iLoop++;
    }
}
