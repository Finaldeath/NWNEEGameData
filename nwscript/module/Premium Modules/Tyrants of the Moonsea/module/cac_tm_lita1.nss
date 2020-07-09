// the player returns lita's ring to her, and gains favored client status in the store

#include "hf_in_plot"
#include "x0_i0_partywide"
#include "hf_in_alignment"

void main()
{
    object oPC = GetPCSpeaker();
    object oRing = GetItemPossessedByParty(oPC, "it_ring_lita");
    if (GetIsObjectValid(oRing))
    {
        DestroyObject(oRing);
    }
    SetLocalInt(OBJECT_SELF, "HF_STORE_PRICE_ADJUST", 10);
    PlotLevelSet(GetTag(OBJECT_SELF), 2);
    AdjustPlayerAlignment(oPC, ALIGNMENT_LAWFUL, 2);
}
