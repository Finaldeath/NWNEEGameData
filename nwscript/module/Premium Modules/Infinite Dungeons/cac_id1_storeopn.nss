#include "inc_id1_flags"
#include "inc_id1_debug"

void main()
{
    // open current creatures store
    object oPC = GetPCSpeaker();
    object oStore = GetLocalObject(OBJECT_SELF, "oStore");

    if (oStore == OBJECT_INVALID)
    {
        DebugMessage("Store was not created.");
    }

    // grab flags for markup and markdown
    int nMarkUp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_MARKUP) - 100;
    int nMarkDown = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_MARKDOWN) - 100;
    DebugMessage("Store markup was " + IntToString(nMarkUp) + " and markdown was " + IntToString(nMarkDown));

    OpenStore(oStore, oPC, nMarkUp, nMarkDown);
}
