
#include "_inc_cutscene"

const string ALLENDRY1 = "Sahuagin! What be the meaning o' this, missy!?";
const string RAHMAN1 = "You have insulted the power of Rahman Madani!";
const string RAHMAN2 = "Prepare to suffer a fate worse then death, wretched merfolk!";
const string TASINA1 = "Stop right there, wizard...";
const string TASINA2 = "You've made the mistake of crossing a priestess of the sea.";
const string ALLENDRY2 = "Enough, sea-witch! The Midnight Rose be mine, and ye no longer be welcome aboard her!";
const string TASINA3 = "Why do men always insist on being such pig-headed fools!?";
const string TASINA4 = "I'd rather not have the rest of you share their fate so stop this nonsense at once!";
const string TASINA5 = "...Now, what am I supposed to do with the likes of you?";

void UnequipItems(object oPC);
void ConvProtector(object oNPCSpeaker);

void main()
{
    // make the PC copy in the water right away, to avoid it being seen and heard later
    object oWP_PCwtr1 = GetWaypointByTag("cut_wp_pcW1");
    object oWP_PCwtr2 = GetWaypointByTag("cut_wp_pcW2");
    object oWP_PCwtr3 = GetWaypointByTag("cut_wp_pcW3");
    object oWP_PCwtr4 = GetWaypointByTag("cut_wp_pcW4");

    object oWaterPC1 = cs_CopyPC(GetLocation(oWP_PCwtr1), FALSE, 0, "pc_inwater_0");
    object oWaterPC2 = cs_CopyPC(GetLocation(oWP_PCwtr2), FALSE, 1, "pc_inwater_1");
    object oWaterPC3 = cs_CopyPC(GetLocation(oWP_PCwtr3), FALSE, 2, "pc_inwater_2");
    object oWaterPC4 = cs_CopyPC(GetLocation(oWP_PCwtr4), FALSE, 3, "pc_inwater_3");

    // Once, the player was seen standing and not playing the dead animation.
    // I suspect that the unequip code interfered with it, so I'll delay the
    // dead animation by a greater amount. Hopefully this prevents this
    // issue from happening again.
    cs_PlayAnimation(5.0f, oWaterPC1, ANIMATION_LOOPING_DEAD_BACK, 1.0f, 300.0f);
    cs_PlayAnimation(5.0f, oWaterPC2, ANIMATION_LOOPING_DEAD_BACK, 1.0f, 300.0f);
    cs_PlayAnimation(5.0f, oWaterPC3, ANIMATION_LOOPING_DEAD_FRONT, 1.0f, 300.0f);
    cs_PlayAnimation(5.0f, oWaterPC4, ANIMATION_LOOPING_DEAD_FRONT, 1.0f, 300.0f);

    UnequipItems(oWaterPC1);
    UnequipItems(oWaterPC2);
    UnequipItems(oWaterPC3);
    UnequipItems(oWaterPC4);

    cs_ApplyVFXToObject(0.5, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oWaterPC1);
    cs_ApplyVFXToObject(0.5, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oWaterPC2);
    cs_ApplyVFXToObject(0.5, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oWaterPC3);
    cs_ApplyVFXToObject(0.5, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oWaterPC4);



    object oPC = GetLocalObject(GetModule(), "MAGICPCOBJECT");
    object oDoor = GetObjectByTag("a0mr_seige_cutdoor");

    object oWP_Spawn = GetWaypointByTag("wp_spawn");
    object oWP_Start = GetWaypointByTag("cut_wp_start");
    object oWP_Tasina1 = GetWaypointByTag("cut_wp_tasina");
    object oWP_Tasina2 = GetWaypointByTag("cut_wp_tasina2");
    object oWP_Allendry = GetWaypointByTag("cut_wp_allendry");
    object oWP_Snitch = GetWaypointByTag("cut_wp_snitch");
    object oWP_Rahman = GetWaypointByTag("cut_wp_rahman");

    object oWP_PC1 = GetWaypointByTag("cut_wp_pc1");
    object oWP_PC2 = GetWaypointByTag("cut_wp_pc2");
    object oWP_PC3 = GetWaypointByTag("cut_wp_pc3");
    object oWP_PC4 = GetWaypointByTag("cut_wp_pc4");

    effect eLightning = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    effect eLightIMP = EffectVisualEffect(VFX_IMP_FROST_S);
    effect eVFX_Stop = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
    effect eVFX_Hold = EffectVisualEffect(VFX_DUR_ICESKIN);
    effect eDeath = EffectDeath(TRUE, TRUE);
    effect eGhost = EffectCutsceneGhost();

    location lStart = GetLocation(oWP_Start);

    object oAllendry = CreateObject(OBJECT_TYPE_CREATURE, "a0_allendrycut",
                GetLocation(oWP_Spawn));
    object oTasina = CreateObject(OBJECT_TYPE_CREATURE, "a0_tasinacut",
                GetLocation(oWP_Spawn));
    object oRahman = CreateObject(OBJECT_TYPE_CREATURE, "a0_rahmancut",
                GetLocation(oWP_Spawn));
    object oSnitch = CreateObject(OBJECT_TYPE_CREATURE, "a0_snitchcut",
                GetLocation(oWP_Spawn));

    object oBridgePC1 = cs_CopyPC(GetLocation(oWP_Spawn), FALSE, 0);
    object oBridgePC2 = cs_CopyPC(GetLocation(oWP_Spawn), FALSE, 1);
    object oBridgePC3 = cs_CopyPC(GetLocation(oWP_Spawn), FALSE, 2);
    object oBridgePC4 = cs_CopyPC(GetLocation(oWP_Spawn), FALSE, 3);

    object oSplash = GetObjectByTag("a0_mrseige2_splash");

    AssignCommand(oAllendry, SetIsDestroyable(FALSE, FALSE, FALSE));

    // Start cutscene
    cs_CameraUseCameraWaypoint(0.5, 1);
    cs_CameraDoFade(1.0f, CS_FADE_TYPE_FROM_BLACK);
    cs_CameraSetFacing(0.75, 35.0f, 10.0f, 70.0f, CAMERA_TRANSITION_TYPE_SLOW);

    cs_ApplyEffectToObject(2.0f, DURATION_TYPE_PERMANENT, eGhost, oAllendry);
    cs_ApplyEffectToObject(2.0f, DURATION_TYPE_PERMANENT, eGhost, oRahman);
    cs_ApplyEffectToObject(2.0f, DURATION_TYPE_PERMANENT, eGhost, oTasina);
    cs_ApplyEffectToObject(2.0f, DURATION_TYPE_PERMANENT, eGhost, oSnitch);

    cs_ApplyEffectToObject(2.0f, DURATION_TYPE_PERMANENT, eGhost, oBridgePC1);
    cs_ApplyEffectToObject(2.0f, DURATION_TYPE_PERMANENT, eGhost, oBridgePC2);
    cs_ApplyEffectToObject(2.0f, DURATION_TYPE_PERMANENT, eGhost, oBridgePC3);
    cs_ApplyEffectToObject(2.0f, DURATION_TYPE_PERMANENT, eGhost, oBridgePC4);

    // The first PC, Rahman, Tasina, and Allendry run out on deck.
    cs_ActionOpenDoor(2.4f, oDoor, oDoor);

    cs_ActionJumpToObject(3.0f, oAllendry, oWP_Start);
    cs_ActionMoveToObject(3.5f, oAllendry, oWP_Allendry, TRUE, 0.0f);
    cs_ActionJumpToObject(4.0f, oRahman, oWP_Start);
    cs_ActionMoveToObject(4.5f, oRahman, oWP_Rahman, TRUE, 0.0f);
    cs_ActionJumpToObject(5.0f, oBridgePC1, oWP_Start);
    cs_ActionMoveToObject(5.5f, oBridgePC1, oWP_PC1, TRUE, 0.0f);
    cs_ActionJumpToObject(6.0f, oTasina, oWP_Start);
    cs_ActionMoveToObject(6.5f, oTasina, oWP_Tasina1, TRUE, 0.0f);
    cs_ActionJumpToObject(7.0f, oSnitch, oWP_Start);
    cs_ActionMoveToObject(7.5f, oSnitch, oWP_Snitch, TRUE, 0.0f);
    cs_ActionJumpToObject(8.0f, oBridgePC2, oWP_Start);
    cs_ActionMoveToObject(8.5f, oBridgePC2, oWP_PC2, TRUE, 0.0f);
    cs_ActionJumpToObject(9.0f, oBridgePC3, oWP_Start);
    cs_ActionMoveToObject(9.5f, oBridgePC3, oWP_PC3, TRUE, 0.0f);
    cs_ActionJumpToObject(10.0f, oBridgePC4, oWP_Start);
    cs_ActionMoveToObject(10.5f, oBridgePC4, oWP_PC4, TRUE, 0.0f);

    cs_ActionSetFacing(4.0f, oAllendry, DIRECTION_WEST);
    cs_ActionSetFacing(5.0f, oRahman, DIRECTION_WEST);
    cs_ActionSetFacing(6.0f, oBridgePC1, DIRECTION_WEST);
    cs_ActionSetFacing(7.0f, oTasina, DIRECTION_WEST);
    cs_ActionSetFacing(8.0f, oSnitch, DIRECTION_WEST);
    cs_ActionSetFacing(9.0f, oBridgePC2, DIRECTION_WEST);
    cs_ActionSetFacing(10.0f, oBridgePC3, DIRECTION_WEST);
    cs_ActionSetFacing(11.0f, oBridgePC4, DIRECTION_WEST);

    // Allendry and Rahman prepare for a fight.
    cs_SpeakString(10.1f, oAllendry, ALLENDRY1);
    cs_ActionPlayAnimation(10.1f, oAllendry, ANIMATION_LOOPING_TALK_FORCEFUL,
        1.0f, 6.0f);

    cs_SpeakString(14.1f, oRahman, RAHMAN1);
    cs_ActionPlayAnimation(14.1f, oRahman, ANIMATION_LOOPING_TALK_LAUGHING,
        1.0f, 6.0f);

    //tasina petrifys rahman and runs out to her sahaugin troops
    cs_SetFacingPoint(16.0f, oTasina, GetPosition(oRahman));
    cs_SpeakString(18.0f, oRahman, RAHMAN2);
    cs_CameraSetFacing(19.0, 24.0f, 10.0f, 70.0f, CAMERA_TRANSITION_TYPE_CRAWL);
    cs_ActionCastFakeSpellAtObject(21.1f, oTasina, SPELL_HOLD_PERSON, oRahman);
    cs_ActionCastFakeSpellAtObject(22.7f, oRahman, SPELL_PLANAR_ALLY, oWP_Tasina2);

    cs_ApplyEffectToObject(23.0f, DURATION_TYPE_PERMANENT, eVFX_Hold, oRahman);
    cs_ApplyEffectToObject(23.6f, DURATION_TYPE_PERMANENT, eVFX_Stop, oRahman);

    cs_SpeakString(24.2f, oTasina, TASINA2);
    cs_ActionMoveToObject(26.2f, oTasina, oWP_Tasina2, TRUE, 0.0f);
    cs_SetFacing(29.8f, oTasina, DIRECTION_EAST);

    // Allendry grabs for his cross bow and makes a threatening gesture
    cs_SpeakString(32.1f, oAllendry, ALLENDRY2);
    DelayCommand(33.0f, AssignCommand(oAllendry,
        ActionEquipMostDamagingRanged()));

    // Tasina kills alledry with lighting
    cs_ActionCastFakeSpellAtObject(34.1f, oTasina, SPELL_CALL_LIGHTNING,
        oAllendry);

    cs_ActionPlayAnimation(35.1f, oAllendry, ANIMATION_FIREFORGET_VICTORY1);

    cs_ApplyEffectToObject(36.3f, DURATION_TYPE_INSTANT, eLightning, oAllendry);
    cs_ActionPlayAnimation(36.2f, oAllendry, ANIMATION_FIREFORGET_SPASM, 1.3f, 3.0f);
    cs_ApplyEffectToObject(36.8f, DURATION_TYPE_INSTANT, eLightIMP, oAllendry);
    cs_ApplyEffectToObject(36.9f, DURATION_TYPE_PERMANENT, eDeath, oAllendry);

    cs_SpeakString(40.7f, oTasina, TASINA3);
    cs_ActionPlayAnimation(40.7f, oTasina, ANIMATION_LOOPING_TALK_PLEADING, 0.8f, 5.0f);

    cs_SpeakString(45.1f, oTasina, TASINA4);
    cs_ActionPlayAnimation(45.1f, oTasina, ANIMATION_LOOPING_PAUSE_TIRED, 0.8f, 4.0f);

    cs_SpeakString(49.1f, oTasina, TASINA5);
    cs_ActionPlayAnimation(49.1f, oTasina, ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD);

    // Modified in the case that the PC that tasina trys to interact with is already
    // conversation (the crafting system seems to break this quite effectively).
    DelayCommand(53.0f, ConvProtector(oTasina));
}

// Find a valid PC to cary on the conversation, or skip it entirely
// and go to the next part of the act0 to act 1 cutscene.
void ConvProtector(object oNPCSpeaker)
{
    object oPC0, oPC1, oPC2, oPC3;
    oPC0 = cs_GetPCObject(0);
    oPC1 = cs_GetPCObject(1);
    oPC2 = cs_GetPCObject(2);
    oPC3 = cs_GetPCObject(3);

    if ((GetIsObjectValid(oPC0) == TRUE) && (IsInConversation(oPC0) == FALSE))
    {
        cs_ActionStartConversation(0.0f, oNPCSpeaker, oPC0, "a0_tasinab");
    }
    else if ((GetIsObjectValid(oPC1) == TRUE) && (IsInConversation(oPC1) == FALSE))
    {
        cs_ActionStartConversation(0.0f, oPC1, oPC1, "a0_tasinab");
    }
    else if ((GetIsObjectValid(oPC2) == TRUE) && (IsInConversation(oPC2) == FALSE))
    {
        cs_ActionStartConversation(53.0f, oNPCSpeaker, oPC2, "a0_tasinab");
    }
    else if ((GetIsObjectValid(oPC3) == TRUE) && (IsInConversation(oPC3) == FALSE))
    {
        cs_ActionStartConversation(53.0f, oNPCSpeaker, oPC2, "a0_tasinab");
    }
    else
    {
        ExecuteScript("cut_mrseige3", OBJECT_SELF);
    }
}

void UnequipItems(object oPC)
{
    object oRightHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    object oLeftHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    object oHelmet = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);

    DestroyObject(oRightHand);
    DestroyObject(oLeftHand);
    DestroyObject(oHelmet);
}

