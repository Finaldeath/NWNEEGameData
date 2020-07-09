// bale is dead; update his quest as the bright sword rises from his corpse

#include "hf_in_henchman"
#include "hf_in_plot"

void main()
{
    object oPC = GetFirstPC();

    // update the journal if the player is killing bale
    if (PlotLevelGet("Bale") == 3)
    {
        AddJournalQuestEntry("ThentiasResistanceArmy", 30, oPC);
    }

    // destroy the sword bale is holding because it turns into beirmoura
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    if (GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
    }

    // spawn beirmoura at bale's location
    location lSelf = GetLocation(OBJECT_SELF);
    object oSword = CreateObject(OBJECT_TYPE_CREATURE, "beirmoura", lSelf);

    // setup beirmoura's home location
    if (PlotLevelGet("Beirmoura") == 0)
    {
        PlotLevelSet("Beirmoura", 1);
    }
    object oHome = GetWaypointByTag("WP_THBI_SWORD");
    HenchmanSetHome(oSword, GetLocation(oHome));

    // play fancy vfx if the player is killing bale
    if (PlotLevelGet("Bale") == 3)
    {
        effect eSparkle = EffectVisualEffect(VFX_IMP_BREACH);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSparkle, oSword, 2.0f);
        effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, lSelf);
        PlaySound("sco_lgrinmind01");
    }
}
