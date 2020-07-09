// February 2006
// B W-Husey
// Barrows don't always have the same contents or benefits

#include "cu_magicvariable"
#include "cu_magic"
void main()
{
    int nRand = d10();
    object oPC = GetLastOpenedBy();
    if (GetLocalInt(OBJECT_SELF,"nEmptied")<1){
    switch (nRand)
    {
        case 1:
            ExecuteScript("dla_obconarmm1",OBJECT_SELF);
        break;
        case 2:
            ExecuteScript("dla_obconarmv1",OBJECT_SELF);
        break;
        case 3:
            ExecuteScript("dla_obconmisc2",OBJECT_SELF);
        break;
        case 4:
            ExecuteScript("dla_obcontreas2",OBJECT_SELF);
        break;
        case 5:
            GetVariable("Weapon",OBJECT_SELF,100,d2());
        break;
        case 6:
            GetMagic("Weapon1",OBJECT_SELF,100);
        break;
        case 7:
            GetMagic("Armour1",OBJECT_SELF,100);
        break;
        default:
        break;
    }
    nRand = d6();
    effect eEffect;
    effect eVis = EffectVisualEffect(VFX_FNF_DEMON_HAND);
    effect eVis2 = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
    switch (nRand)
    {
        case 1:
        eEffect = EffectBlindness();
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,oPC,30.0);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis2,oPC);
        FloatingTextStringOnCreature("The tomb is cursed!",oPC);
        break;
        case 2:
        eEffect = EffectCurse(1,0,1,0,2,2);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,oPC,300.0);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis2,oPC);
        FloatingTextStringOnCreature("The tomb is cursed!",oPC);
        break;
        default:
        break;
    }
    SetLocalInt(OBJECT_SELF,"nEmptied",1);   // Container has been raided
    }
}
