// the player recharges a wand

void main()
{
    object oPC = GetPCSpeaker();

    // is the player an arcanist?
    if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC) <= 0 &&
        GetLevelByClass(CLASS_TYPE_SORCERER, oPC) <= 0 &&
        GetLevelByClass(CLASS_TYPE_BARD, oPC) <= 0)
    {
        if (!GetHasSkill(SKILL_USE_MAGIC_DEVICE, oPC))
        {
            FloatingTextStringOnCreature("...Only arcane magic users can use Wazu's Wand...", oPC);
            return;
        }
    }

    // recharge wands in the player's possession
    int nDone = 0;
    object oWand = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oWand))
    {
        if (GetBaseItemType(oWand) == BASE_ITEM_MAGICWAND)
        {
            int nCharges = GetItemCharges(oWand);
            if (nCharges < 25)
            {
                SetIdentified(oWand, TRUE);
                int n = d4(2);
                SetItemCharges(oWand, nCharges+n);
                SendMessageToPC(oPC, "Wazu's Wand: Added " + IntToString(n) + " charges to " + GetName(oWand));
                nDone++;
            }
        }
        oWand = GetNextItemInInventory(oPC);
    }

    // fancy vfx
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 3.0));
    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    DelayCommand(3.0, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_SONIC), oPC);

    // report results to player
    if (nDone > 0)
    {
        FloatingTextStringOnCreature("...Number of wands charged: " + IntToString(nDone) + "...", oPC);
    }
    else
    {
        FloatingTextStringOnCreature("...You do not have any wands...", oPC);
    }
}

