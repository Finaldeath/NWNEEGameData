#include "hf_in_cutscene"

void CreateSujit(location lDelfen)
{
    CreateObject(OBJECT_TYPE_CREATURE,"pm_sujit",lDelfen);
}

void FreeSujit(object oPC)
{
    object oChest = GetObjectByTag("a2_pm_impchest");
    effect eEffect = EffectVisualEffect(VFX_FNF_DISPEL);
    effect eEffect2 = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);

    //ActionDoCommand(SetFacingPoint(GetPosition(oChest)));
    AssignCommand(oPC, ActionMoveToObject(GetWaypointByTag("PC_CS_DELFEN")));
    AssignCommand(oPC, ActionDoCommand(SetFacing(DIRECTION_NORTH)));
    ActionMoveAwayFromObject(oChest,FALSE,1.0);
    ActionWait(1.0);
    ActionCastFakeSpellAtLocation(SPELL_BALAGARNSIRONHORN,GetLocation(oChest));
    ActionWait(1.0);
    ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,oChest));
    ActionWait(2.0);
    ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect2,oChest));
    ActionDoCommand(CreateSujit(GetLocation(oChest)));
    ActionDoCommand(DestroyObject(oChest));
    ActionDoCommand(UnFreezeAssociates(oPC));
    ActionDoCommand(DeleteLocalObject(GetModule(), "oCutsceneCreator"));
    ActionDoCommand(SetCutsceneMode(oPC,FALSE));
    ActionResumeConversation();
}

void main()
{
    object oPC=GetPCSpeaker();
    object oDelfen=GetNearestObjectByTag("pm_delfen");

    //object oChest = GetItemPossessedBy(OBJECT_SELF, "a2_pm_impchest");

    object oChest = GetItemPossessedBy(GetPCSpeaker(), "a2_pm_impchest");

    if(GetIsObjectValid(oChest))
    {
        SetCutsceneMode(oPC,TRUE);
        SetLocalObject(GetModule(), "oCutsceneCreator", OBJECT_SELF);
        FreezeAssociates(oPC, TRUE);
        SetLocalInt(GetModule(), "nGaveChestToErik", 1);
        ActionTakeItem(oChest, GetPCSpeaker());
        ActionPauseConversation();
        ActionMoveToObject(GetWaypointByTag("DELFEN_CS"));
        ActionPutDownItem(oChest);
        //ActionMoveAwayFromObject(oChest,FALSE,1.0);
        ActionDoCommand(FreeSujit(oPC));
     }
}
