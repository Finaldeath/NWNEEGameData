// smith vanishes

#include "hf_in_plot"
#include "hf_in_xp"

void main()
{
    // play some effects and die

    effect eHoly = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
    effect eBlast = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);

    ClearAllActions(TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHoly, OBJECT_SELF);
    DelayCommand(0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBlast, OBJECT_SELF));

    DelayCommand(0.2f, SetCommandable(FALSE, OBJECT_SELF));

    DestroyObject(OBJECT_SELF, 1.0f);

    // deactivate forge

    object oForge = GetNearestObjectByTag("Forge");
    AssignCommand(oForge, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));

    // stop area sounds of the forge

    object oSound1 = GetNearestObjectByTag("FireMedium");
    object oSound2 = GetNearestObjectByTag("Furnace");
    object oSound3 = GetNearestObjectByTag("MagicChants");

    SoundObjectSetVolume(oSound1, 0);
    SoundObjectStop(oSound1);

    SoundObjectSetVolume(oSound2, 0);
    SoundObjectStop(oSound2);

    SoundObjectSetVolume(oSound3, 0);
    SoundObjectStop(oSound3);
}
