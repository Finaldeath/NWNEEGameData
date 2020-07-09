//::///////////////////////////////////////////////
//:: mac_potscdflt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Module activate item event handler.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_map_system"

void main()
{
    object oItem = GetItemActivated();
    object oActivator = GetItemActivator();
    object oTarget = GetItemActivatedTarget();

    location lTarget = GetItemActivatedTargetLocation();
    string sMSG = "";

    float fHealing = (GetMaxHitPoints(oActivator) - GetCurrentHitPoints(oActivator)) * 0.75f;
    effect eHeal = EffectHeal(FloatToInt(fHealing));
    effect eVFXEat = EffectVisualEffect(VFX_IMP_GOOD_HELP);
    eHeal = EffectLinkEffects(eVFXEat, eHeal);

    if (GetIsPC(oActivator) == TRUE)
    {
        // does the object belong to the PotSC crafting system?
        if ((GetTag(oItem) == "a1_leather") || (GetTag(oItem) == "a1_catgut") ||
            (GetTag(oItem) == "a1_ichor") || (GetTag(oItem) == "a1_stick_long") ||
            (GetTag(oItem) == "a1_rawmeat") || (GetTag(oItem) == "a1_feather") ||
            (GetTag(oItem) == "a1_flint") || (GetTag(oItem) == "a1_stone") ||
            (GetTag(oItem) == "a1_stick") || (GetTag(oItem) == "a1_tinder"))
        {
            SetLocalString(oActivator, "CRAFT_ITEM", GetTag(oItem));
            AssignCommand(oActivator, ActionStartConversation(oActivator,
                "a1_survivalitems", TRUE, FALSE));
        }

        // Is the Object food?
        else if ((GetTag(oItem) == "a1_cookedfish")||(GetTag(oItem) == "a1_cookedmeat")
            ||(GetTag(oItem) == "trs_g_jnk_020")||(GetTag(oItem) == "trs_g_jnk_047")
            ||(GetTag(oItem) == "trs_g_jnk_033"))
        {
            if(GetIsInCombat(oActivator) == FALSE)
            {
                AssignCommand(oActivator, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oActivator);
                DestroyObject(oItem);
            }
            else
            {
                FloatingTextStringOnCreature("You cannot eat while in combat.", oActivator);
            }
        }
        // Is the Object a raft component?
        else if ((GetTag(oItem) == "a1_sacredwood")||(GetTag(oItem) == "a1_raftplans"))
        {
            AssignCommand(oActivator, ActionStartConversation(oActivator,
                "a1_raft", TRUE, FALSE));
        }
        // Is the Object a Treasure Map?
        else if ((GetTag(oItem) == "map_blkbrd") || (GetTag(oItem) == "map_scepter")
          || (GetTag(oItem) == "map_flower") || (GetTag(oItem) == "trs_u_sys_map004")
          || (GetTag(oItem) == "trs_u_sys_map002") || (GetTag(oItem) == "trs_u_sys_map007")
          || (GetTag(oItem) == "trs_u_sys_map001") || (GetTag(oItem) == "trs_u_sys_map006")
          || (GetTag(oItem) == "trs_u_sys_map005") || (GetTag(oItem) == "trs_u_sys_iotd")
          || (GetTag(oItem) == "trs_u_sys_map003"))
        {
            ActivateMap(oActivator, oItem);
        }

        // Peices of Blackbeards map
        if ((GetTag(oItem) == "trs_u_sys_map009") || (GetTag(oItem) == "trs_u_sys_map010")
          || (GetTag(oItem) == "trs_u_sys_map011") || (GetTag(oItem) == "trs_u_sys_map012"))
        {
            // If they have all the peices, put them together to make the final map
            if ((GetItemPossessedBy(oActivator, "trs_u_sys_map009") != OBJECT_INVALID)
             && (GetItemPossessedBy(oActivator, "trs_u_sys_map010") != OBJECT_INVALID)
             && (GetItemPossessedBy(oActivator, "trs_u_sys_map011") != OBJECT_INVALID)
             && (GetItemPossessedBy(oActivator, "trs_u_sys_map012") != OBJECT_INVALID))
            {
                DestroyObject(GetItemPossessedBy(oActivator, "trs_u_sys_map009"));
                DestroyObject(GetItemPossessedBy(oActivator, "trs_u_sys_map010"));
                DestroyObject(GetItemPossessedBy(oActivator, "trs_u_sys_map011"));
                DestroyObject(GetItemPossessedBy(oActivator, "trs_u_sys_map012"));

                sMSG = "Arranging the pieces together, you create the map to Blackeye's Silver!";
                FloatingTextStringOnCreature(sMSG, oActivator);

                CreateItemOnObject("trs_u_sys_map008", oActivator);
            }
            // They don't have all the peices yet
            else
            {
                sMSG = "You can't seem to make heads or tails of Blackeye's map without all the pieces...";
                FloatingTextStringOnCreature(sMSG, oActivator);
            }
        }
    }
}
