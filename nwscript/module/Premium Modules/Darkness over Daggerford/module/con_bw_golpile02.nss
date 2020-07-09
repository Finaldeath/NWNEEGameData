//::///////////////////////////////////////////////
//::
//:: con_bw_golpile02
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

void SummonPal(location lSum);

void main()
{
    object oPC = GetPCSpeaker();

    location lLoc = GetLocation(OBJECT_SELF);
    effect ePoof = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePoof, lLoc);

    object oBits1 = GetNearestObjectByTag("bw_golembits", OBJECT_SELF, 1);
    object oBits2 = GetNearestObjectByTag("bw_golembits", OBJECT_SELF, 2);
    object oBits3 = GetNearestObjectByTag("bw_golembits", OBJECT_SELF, 3);

    DestroyObject(oBits1);
    DestroyObject(oBits2, 0.2);
    DestroyObject(oBits3, 0.3);
    DestroyObject(OBJECT_SELF, 0.8);

    DelayCommand(0.5, SummonPal(lLoc));

    SetLocalInt(OBJECT_SELF, "HF_ARG", 2);
}

void SummonPal(location lSum)
{
    CreateObject(OBJECT_TYPE_CREATURE, "bw_golem", lSum);
}
