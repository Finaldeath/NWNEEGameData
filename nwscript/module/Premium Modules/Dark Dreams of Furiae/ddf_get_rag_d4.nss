#include "ddf_util"
#include "nw_i0_plot"

void main()
{
    // Does player already have a copy?
    // Create a copy of the base item
    // apply the date as a local var to the copy
    // update the name of the copy to include the date
    // add this copied item to the player's inventory.
    // pop a message "you got today's paper"

    // has today's paper

    //debug("getting the rag...");

    object oPC = GetPCSpeaker();// GetLastUsedBy();
    string sPaperTag = "rag_nspr_i4";// + IntToString(GetCurrentDay());

    if(HasItem(oPC, sPaperTag))
    {
        SpeakString("You already have that rag.");
        return;
    }


    // Create copy of base newspaper.

    //object oNewspaper = CreateObject(OBJECT_TYPE_ITEM, FS_RESREF, GetLocation(oPC), FALSE, sPaperTag);
    object oNewspaper = CreateItemOnObject("renegaderag", oPC, 1, sPaperTag);

    SetName(oNewspaper, "Renegade Rag: Day 4");// + IntToString(GetCurrentDay()));
    SetLocalInt(oNewspaper, "DDF_CURRENT_DAY", 4);

    int nDay = GetLocalInt(oNewspaper, "DDF_CURRENT_DAY");
    debug("tag: " + sPaperTag + " day: " + IntToString(nDay));
    //ActionGiveItem(oNewspaper, oPC);
    SpeakString("You got a copy of the rag.");
}
