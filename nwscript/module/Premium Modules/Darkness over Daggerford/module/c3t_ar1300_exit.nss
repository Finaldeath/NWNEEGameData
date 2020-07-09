// player exits the liam's hold area via a world map transition
// ... might trigger a new quest messenger to arrive at the stronghold
// ... also might trigger Yani to arrive

#include "inc_stronghold"

void main()
{
    object oPC = GetClickingObject();
    if (GetIsPC(oPC))
    {
        // a stronghold messenger might appear when the player is away
        QuestAreaExit(oPC);

        // yani can now appear
        if (GetLocalInt(GetModule(), "yani_appears") == 1)
        {
            SetLocalInt(GetModule(), "yani_appears", 2);
        }

        // run the standard world map transition
        ExecuteScript("c3t_atc_to_map", OBJECT_SELF);
    }
}
