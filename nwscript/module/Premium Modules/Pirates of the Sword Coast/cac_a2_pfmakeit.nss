//::///////////////////////////////////////////////
//:: cac_a2_pfmakeit
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Modifies the current item with the currently
    selected item property.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 2003
//:://////////////////////////////////////////////
//:: Modified By: Keith Hayward
//:: Modified On: April 2004
//:://////////////////////////////////////////////
#include "inc_potscforge"

void CopyUpgradeItem(object oItem, object oPC);
void MakeNewWeapon(object oForge);

int nCutsceneNumber = 114;

void main()
{
    object oForge = GetNearestObjectByTag("a2_prugforge");
    MakeNewWeapon(oForge);
    wsDeRegisterItem();
}

void CopyUpgradeItem(object oItem, object oHolder)
{
   object oNewItem = CopyItem(oItem, oHolder, TRUE);
   //---------------------------------------------------------------------------
   // GZ: Bugfix for #35259 - Item properties staying around
   //---------------------------------------------------------------------------
   IPRemoveAllItemProperties(oNewItem,DURATION_TYPE_TEMPORARY);
}

void MakeNewWeapon(object oForge)
{
    object oPC = GetPCSpeaker();
    object oItem = wsGetRegisteredItem();
    object oPrugdush = OBJECT_SELF;
    location lForge = GetLocation(oForge);

    wsEnhanceItem(oItem, oPC);
    AssignCommand(oPrugdush, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2));
    PlaySound("sim_bonholy");
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_BREACH), lForge);
}
