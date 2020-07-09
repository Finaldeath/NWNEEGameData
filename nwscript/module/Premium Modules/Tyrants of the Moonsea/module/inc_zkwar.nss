#include "hf_in_cutscene"
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

//If all three of Orcus' lieutenants (Harthoon, Kauvra, Quah-Nomag) are
//overcome in Zhentil Keep warzone, award 500xp
void NotifyLieutentantDefeat()
{
    int nLieutentantsDefeated = PlotLevelGet("LieutenantsDefeated");

    nLieutentantsDefeated++;

    if(nLieutentantsDefeated == 3)
    {
        object oPC = GetFirstPC();
        FloatingTextStringOnCreature("500xp: Orcus Lieutenants Defeated!", oPC);
        GiveXPToCreature(oPC, 500);
    }

    PlotLevelSet("LieutenantsDefeated", nLieutentantsDefeated);
}

void RemoveHenchmenNegativeEffects(object oPC)
{
    int i = 1;
    object oHenchman = GetHenchman(oPC, i);
    while (GetIsObjectValid(oHenchman))
    {
        CutsceneRemoveNegativeEffects(oHenchman);
        oHenchman = GetHenchman(oPC, ++i);
    }
}

/*void main()
{

} */
