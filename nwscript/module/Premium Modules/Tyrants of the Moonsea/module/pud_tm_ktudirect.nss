//Apply and remove effects in Orcus summoning cutscenes

#include "inc_ktgate"

void main()
{
    object oPortal = GetNearestObjectByTag("OrcusPortal");

    effect eOgre;
    effect ePortal;

    switch(GetUserDefinedEventNumber())
    {
        //Initial black circle around ogre mages
        case 4600 :
            eOgre = EffectVisualEffect(VFX_DUR_AURA_DISEASE);
            ApplyOgreEffects(eOgre);
        break;

        //Glyph  effect on Portal
        case 4601 :
            RemoveNamedEffectByCreator(EFFECT_TYPE_VISUALEFFECT, oPortal, OBJECT_SELF);
            ePortal = EffectVisualEffect(VFX_DUR_GLYPH_OF_WARDING);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePortal, oPortal);
        break;
        //Armor effect on ogre mages
        case 4602 :
             eOgre = EffectVisualEffect(VFX_DUR_PROT_EPIC_ARMOR);
             ApplyOgreEffects(eOgre);
        break;
    }
}
