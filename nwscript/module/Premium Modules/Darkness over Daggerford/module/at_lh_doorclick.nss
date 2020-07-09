// player tries to enter illefarn from laughing hollow
// .. veiti appears to say the magic word

void main()
{
    object oClicker = GetClickingObject();

    if (GetIsPC(oClicker))
    {
        // vfx
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DISPEL), OBJECT_SELF);

        // veiti appears to talk about the door
        object oHench = GetNearestObjectByTag("db_veiti", oClicker);
        AssignCommand(oHench, ClearAllActions());
        AssignCommand(oClicker, ClearAllActions());
        AssignCommand(oHench, JumpToObject(oClicker));
        AssignCommand(oHench, DelayCommand(0.1, ActionStartConversation(oClicker, "ks_ar2500_door", FALSE, FALSE)));
    }
}
