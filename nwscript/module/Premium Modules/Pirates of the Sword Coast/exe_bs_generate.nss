//::///////////////////////////////////////////////
//:: exe_bs_generate
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Generate papers, based on the local variables
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_genbooks"
#include "inc_genscrolls"

const string S_BOOK_COUNT = "POTSC_BOOK_COUNT";
const string S_SCROLL_COUNT  = "POTSC_SCROLL_COUNT";

void main()
{
    object oSelf = OBJECT_SELF;
    int iBooks = GetLocalInt(oSelf, S_BOOK_COUNT);
    int iScrolls = GetLocalInt(oSelf, S_SCROLL_COUNT);
    int iDoOnce = GetLocalInt(oSelf, "exe_bs_generate");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oSelf, "exe_bs_generate", TRUE);

        CreateBooksOnObject(oSelf, Random(iBooks + 1));
        CreateScrollsOnObject(oSelf, Random(iScrolls + 1));
    }
}
