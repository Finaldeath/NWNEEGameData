//::///////////////////////////////////////////////
//::
//:: con_bw_stat01
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: Conversation script.
//::
//:: Move block, open door in Illefarn (Hall of Kings).
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 10/28/2005
//::
//:://////////////////////////////////////////////

void CreateBlockTop(location lLoc);

void main()
{
    object oPC = GetPCSpeaker();

    string sItem = GetLocalString(OBJECT_SELF, "sItem");
    object oItem = GetItemPossessedBy(oPC, sItem);

    DestroyObject(oItem);

    PlaySound("as_sw_stonelk1");
    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);

    object oDoor = GetNearestObjectByTag("ar2503_hok_door");
    object oBlock = GetNearestObjectByTag("bw_stone_block");

    float fDist = GetDistanceToObject(oBlock);

    if ((fDist > 0.0f) && (fDist < 15.0f))
    {
        DelayCommand(0.2, AssignCommand(oBlock, PlaySound("as_dr_x2tib1cl")));

        SetPlotFlag(oBlock, FALSE);

        effect eDust = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
        DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDust, oBlock));

        effect eDam = EffectDamage(500);
        DelayCommand(0.4, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oBlock));

        location lLoc = GetLocation(oBlock);
        DelayCommand(0.5, CreateBlockTop(lLoc));
    }

    DelayCommand(1.8, SetLocked(oDoor, FALSE));

    SetLocalInt(OBJECT_SELF, "HF_ARG", 1);
}

void CreateBlockTop(location lLoc)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, "dag_blocktop", lLoc);
}
