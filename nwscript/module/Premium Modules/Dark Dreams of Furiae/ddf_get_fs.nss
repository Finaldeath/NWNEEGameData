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

    debug("getting the newspaper...");

    object oPC = GetLastUsedBy();
    string sPaperTag = "fs_nspr_i" + IntToString(GetCurrentDay());

    // 2019-08-22 JY
    // Give everyone a copy of the paper...
    // https://app.asana.com/0/842177838074622/1124015019348101

    object oFactionMember = GetFirstFactionMember(oPC);

    while(GetIsObjectValid(oFactionMember))
    {

        if(HasItem(oFactionMember, sPaperTag) == FALSE)
        {
            // Create copy of base newspaper.

            //object oNewspaper = CreateObject(OBJECT_TYPE_ITEM, FS_RESREF, GetLocation(oPC), FALSE, sPaperTag);
            object oNewspaper = CreateItemOnObject("furiaesentinel", oFactionMember, 1, sPaperTag);

            SetName(oNewspaper, "Furiae Sentinel: Day " + IntToString(GetCurrentDay()));
            SetLocalInt(oNewspaper, "DDF_CURRENT_DAY", GetCurrentDay());

            int nDay = GetLocalInt(oNewspaper, "DDF_CURRENT_DAY");
            debug("tag: " + sPaperTag + " day: " + IntToString(nDay));
            //ActionGiveItem(oNewspaper, oPC);
        }

        oFactionMember = GetNextFactionMember(oFactionMember);
    }
    SpeakString("You got a copy of today's newspaper.");
}
