// the player has released the penguin from its cage

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    // nagnorm's key is useless, so get rid of it
    object oKey = GetItemPossessedBy(oPC, "ks_it_nagkey");
    DestroyObject(oKey);

    // penguin jumps into player's arms
    CreateItemOnObject("a2_penguin", oPC, 1);
    PlotLevelSet(GetTag(OBJECT_SELF), 2);
    DestroyObject(OBJECT_SELF);
}
