//::///////////////////////////////////////////////
//:: Name x2_def_ondamage
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDamaged script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    object oAttacker=GetLastDamager();
    object oWeapon=GetLastWeaponUsed(oAttacker);
    effect eSlow=EffectSlow();
    effect eVisual=EffectVisualEffect(VFX_IMP_SLOW);
    effect eAcid=EffectDamage(d10(1),DAMAGE_TYPE_MAGICAL);
    if(GetTag(oWeapon)=="db_garlicslicer")
    {
        SendMessageToPC(oAttacker,"The garlic slicer visibly causes the vampire to stagger and slow.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVisual,OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSlow,OBJECT_SELF,6.0f);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eAcid,OBJECT_SELF);
    }

    //--------------------------------------------------------------------------
    // GZ: 2003-10-16
    // Make Plot Creatures Ignore Attacks
    //--------------------------------------------------------------------------
    if (GetPlotFlag(OBJECT_SELF))
    {
        return;
    }

    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------
    ExecuteScript("nw_c2_default6", OBJECT_SELF);
}
