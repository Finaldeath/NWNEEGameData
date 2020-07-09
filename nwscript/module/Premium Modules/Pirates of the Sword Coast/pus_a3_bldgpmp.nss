//::///////////////////////////////////////////////
//:: pus_a3_bldgpmp
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The skull and bones Blidge pump has been
    activated by a player.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
void main()
{
    object oModule = GetModule();
    object oPC = GetLastUsedBy();
    object oPump = OBJECT_SELF;
    object oArea = GetArea(oPump);
    effect eVIS = EffectVisualEffect(VFX_IMP_HEAD_COLD);

    int iWater = GetLocalInt(oArea, "A3_WATERLEVEL");
    int iPump = 20;

    if (iWater > 0)
    {
        if (iWater < iPump)
        {
            iPump = iWater;
        }

        // clear any required warning flags
        if (iWater < 10)
        {
            SetLocalInt(oModule, "A3_SIEGEWARN_VLOW", FALSE);
        }
        if (iWater < 60)
        {
            SetLocalInt(oModule, "A3_SIEGEWARN_MED", FALSE);
        }
        if (iWater < 90)
        {
            SetLocalInt(oModule, "A3_SIEGEWARN_HIGH", FALSE);
        }
        if (iWater < 110)
        {
            SetLocalInt(oModule, "A3_SIEGEWARN_VHIGH", FALSE);
        }

        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);

        AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 2.0f));
        DelayCommand(0.1f, SetCommandable(FALSE, oPC));
        DelayCommand(2.0f, SetCommandable(TRUE, oPC));

        SetLocalInt(oArea, "A3_WATERLEVEL", (iWater - iPump));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVIS, oPump);

        DelayCommand(2.0f, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    }
    else
    {
        FloatingTextStringOnCreature("The water is too low to effectively pump.", oPC);
    }
}
