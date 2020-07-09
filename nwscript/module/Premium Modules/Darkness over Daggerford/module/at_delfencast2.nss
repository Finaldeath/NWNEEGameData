/////////////////////////
//at_delfencast
//This will make delfen cast a spell and make sujit the imp appear
//
//Author: phil mitchell (baron of gateford)
////////////////////////

void createsujit(location lDelfen)
{
  CreateObject(OBJECT_TYPE_ITEM,"pm_impchest2",lDelfen);
}

void main()
{
    object oPC=GetPCSpeaker();
    object oDelfen=GetNearestObjectByTag("pm_delfen");
    location lDelfen=GetLocation(OBJECT_SELF);
    object oChest = GetItemPossessedBy(OBJECT_SELF, "pm_impchest2");
    effect eEffect = EffectVisualEffect(VFX_FNF_DISPEL);
    effect eEffect2 = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
    ActionPauseConversation();
    DelayCommand(0.5,SetCutsceneMode(oPC,TRUE));
    DelayCommand(0.8,AssignCommand(OBJECT_SELF,ActionPutDownItem(oChest)));
    DelayCommand(1.0,AssignCommand(OBJECT_SELF,ActionMoveAwayFromObject(oChest,FALSE,1.0)));
    DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtLocation(SPELL_BALAGARNSIRONHORN,GetLocation(oChest))));
    DelayCommand(7.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,oChest));
    DelayCommand(9.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect2,oChest));
    //DelayCommand(4.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtLocation(SPELL_KNOCK,GetLocation(oChest))));
    DestroyObject(oChest,11.5);
    DelayCommand(11.0,createsujit(GetLocation(oChest)));
    DelayCommand(12.0,AssignCommand(OBJECT_SELF,ActionPickUpItem(oChest)));
    DelayCommand(13.0,SetCutsceneMode(oPC,FALSE));
    DelayCommand(13.5,ActionResumeConversation());

}
