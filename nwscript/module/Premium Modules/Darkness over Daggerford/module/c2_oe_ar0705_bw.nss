//::///////////////////////////////////////////////
//::
//:: c2_oe_ar0705_bw
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Enter script for area.
//::
//:: Play VFX on PC when teleported in.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 4/27/2005
//::
//:://////////////////////////////////////////////

void main()
{
    object oEnterer = GetEnteringObject();

    if (GetTag(oEnterer) == "bw_boonmoppet")
    {
        SetPlotFlag(oEnterer, FALSE);

        SetLocalInt(oEnterer, "HF_ARG", 4); // for convo
        SetLocalInt(oEnterer, "nBusy", 0); // for convo

        ChangeToStandardFaction(oEnterer, STANDARD_FACTION_MERCHANT);

        SetCommandable(TRUE, oEnterer);
    }

    if (GetLocalInt(oEnterer, "nIH_Ported") == 1)
    {
        DeleteLocalInt(oEnterer, "nIH_Ported");

        effect eVFX = EffectVisualEffect(VFX_IMP_UNSUMMON);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oEnterer);
    }

    if (GetIsPC(oEnterer))
    {
        if (GetLocalInt(OBJECT_SELF, "nUnlocked") == 0)
        {
            object oDoor = GetObjectByTag("AR0705_AR0700_EXIT");
            object oDoor2 = GetTransitionTarget(oDoor);

            SetLocked(oDoor2, FALSE);

            SetLocalInt(OBJECT_SELF, "nUnlocked", 1);
        }

        if (GetLocalInt(oEnterer, "nBoonMoppetQuest") == 1)
        {
            SetLocalInt(oEnterer, "nBoonMoppetQuest", 10);
        }
    }
}
