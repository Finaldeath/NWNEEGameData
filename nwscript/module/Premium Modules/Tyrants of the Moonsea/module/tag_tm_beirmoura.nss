// item event script for "the bright sword" that summons beirmoura

#include "x0_i0_position"
#include "x2_inc_switches"
#include "hf_in_henchman"

const string sBeirmouraResRef = "thebrightsword";

// creates beirmoura and hires her as a henchman
object summonSwordCreature(object oPC)
{
    location lSelf = GetStepRightLocation(oPC);
    object oSword = CreateObject(OBJECT_TYPE_CREATURE, "beirmoura", lSelf);

    object oHome = GetWaypointByTag("WP_THBI_SWORD");
    HenchmanSetHome(oSword, GetLocation(oHome));
    HenchmanHire(oSword, oPC);

    effect eSparkle = EffectVisualEffect(VFX_IMP_BREACH);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSparkle, oSword, 2.0f);

    effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, GetLocation(oSword));

    PlaySound("sco_lgrinmind01");
    return oSword;
}

// finds the sword item in the given character's inventory
object getSwordItem(object oPC)
{
    object oSword = OBJECT_INVALID;
    int nSlot;
    for (nSlot = 0; nSlot < NUM_INVENTORY_SLOTS; ++nSlot)
    {
        object oItem = GetItemInSlot(nSlot, oPC);
        if (GetIsObjectValid(oItem))
        {
            if (GetResRef(oItem) == sBeirmouraResRef)
            {
                oSword = oItem;
                break;
            }
        }
    }

    if (!GetIsObjectValid(oSword))
    {
        object oItem = GetFirstItemInInventory(oPC);
        while (oItem != OBJECT_INVALID)
        {
            if (GetResRef(oItem) == sBeirmouraResRef)
            {
                oSword = oItem;
                break;
            }
            oItem = GetNextItemInInventory(oPC);
        }
    }

    return oSword;
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;

    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
    {
        oPC   = GetItemActivator();
        oItem = GetItemActivated();
    }

    if (GetIsPC(oPC))
    {
        // summon beirmoura and destroy the sword she is carrying
        object oBeirmoura = summonSwordCreature(oPC);
        if (GetIsObjectValid(oBeirmoura))
        {
            object oSword = getSwordItem(oBeirmoura);
            if (GetIsObjectValid(oSword))
            {
                DestroyObject(oSword);
            }
        }

        // give the player's sword to beirmoura
        object oSword = getSwordItem(oPC);
        if (GetIsObjectValid(oSword) && GetIsObjectValid(oBeirmoura))
        {
            object oCopy = CopyItem(oSword, oBeirmoura, TRUE);
            if (GetIsObjectValid(oCopy))
            {
                SetIdentified(oCopy, TRUE);
                AssignCommand(oBeirmoura, ActionEquipItem(oCopy, INVENTORY_SLOT_RIGHTHAND));
                DestroyObject(oSword);
            }
        }
    }
}
