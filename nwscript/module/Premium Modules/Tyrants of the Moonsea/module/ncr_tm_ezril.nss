//Eremuth flees when reduced to 1 hit point

#include "hf_in_plot"

void ClearFollowersReputation(object oPC, object oTarget)
{
    int h = 1;
    int i;

    object oCreature;
    object oHench = GetHenchman(oPC, h);

    while(oHench != OBJECT_INVALID)
    {
        AssignCommand(oHench,ClearAllActions(TRUE));
        ClearPersonalReputation(oTarget,oHench);
        ClearPersonalReputation(oHench,oTarget);
        h++;
        oHench = GetHenchman(oPC, h);
    }

    for(i = ASSOCIATE_TYPE_ANIMALCOMPANION; i <= ASSOCIATE_TYPE_DOMINATED; i++)
    {
        oCreature = GetAssociate(i,oPC);
        if(oCreature != OBJECT_INVALID)
        {
            AssignCommand(oCreature,ClearAllActions(TRUE));
            ClearPersonalReputation(oTarget,oCreature);
            ClearPersonalReputation(oCreature,oTarget);
       }
    }
}

void SetObjectVisualTransformVoid(object oCreature, int nTransform, float fValue)
{
    SetObjectVisualTransform(oCreature, nTransform, fValue);
}

void main()
{
    if(GetCurrentHitPoints() == 1 && GetLocalInt(OBJECT_SELF, "iFlee") == 0)
    {
        object oPC = GetFirstPC();

        SetLocalInt(OBJECT_SELF, "iFlee", 1);
        SetPlotFlag(OBJECT_SELF, TRUE);
        ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_MERCHANT);
        ClearAllActions(TRUE);

        SurrenderToEnemies();
        ClearPersonalReputation(oPC, OBJECT_SELF);
        ClearPersonalReputation(OBJECT_SELF, oPC);
        ClearFollowersReputation(oPC, OBJECT_SELF);

        if(PlotLevelGet("Thoyana") == 1)
        {
            AddJournalQuestEntry("MurderInElmwood", 50, oPC);
        }
        else
        {
            AddJournalQuestEntry("MurderInElmwood", 55, oPC);
        }

        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),
                            OBJECT_SELF);

        DelayCommand(0.1, SetObjectVisualTransformVoid(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_SCALE, 1.0));
        DelayCommand(0.2, SetCreatureAppearanceType(OBJECT_SELF, 15036)); // Malaugrym appearance
        DelayCommand(0.3, SetPortraitResRef(OBJECT_SELF, "po_malaugrym_"));
        DelayCommand(1.0, PlaySound("c_malaugrym_bat1"));
        DelayCommand(2.5,
            SpeakString("No! I will not die here! The Blade of Netheril must be protected!",
                        TALKVOLUME_SHOUT));
        DelayCommand(5.0,
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                EffectVisualEffect(VFX_FNF_SUMMONDRAGON), GetLocation(OBJECT_SELF)));
        DelayCommand(5.5,
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                EffectVisualEffect(VFX_FNF_PWSTUN), GetLocation(OBJECT_SELF)));

        SetLocalInt(OBJECT_SELF, "HF_EXIT_STARTED", 1);
        DestroyObject(OBJECT_SELF, 6.0);
    }
    else
    {
        ExecuteScript("nw_c2_default3", OBJECT_SELF);
    }
}
