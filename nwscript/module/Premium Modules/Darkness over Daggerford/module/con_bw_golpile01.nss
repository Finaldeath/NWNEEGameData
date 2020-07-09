//::///////////////////////////////////////////////
//::
//:: con_bw_golpile01
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: Conversation script.
//::
//:: Create Stone Golem.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 11/4/2005
//::
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();

    string sItem = GetLocalString(OBJECT_SELF, "sItem");
    object oItem = GetItemPossessedBy(oPC, sItem);

    DestroyObject(oItem);

    PlaySound("as_sw_stonelk1");

    //location lLoc = GetLocation(OBJECT_SELF);
    //effect ePoof = EffectVisualEffect();

    effect eVFX = EffectVisualEffect(VFX_DUR_GLOW_WHITE);

    object oBits1 = GetNearestObjectByTag("bw_golembits", OBJECT_SELF, 1);
    object oBits2 = GetNearestObjectByTag("bw_golembits", OBJECT_SELF, 2);
    object oBits3 = GetNearestObjectByTag("bw_golembits", OBJECT_SELF, 3);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, oBits1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, oBits2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, oBits3);

    SetLocalInt(OBJECT_SELF, "HF_ARG", 1);
}
