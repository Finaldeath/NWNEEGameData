//::///////////////////////////////////////////////
//:: FileName oe_ac_chasemaze
//:: PC asleep in maze and then Pettywick starts convo
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 3:25:02 PM
//:://////////////////////////////////////////////
#include "hf_in_henchman"

void InvisFollowers(object oPC)
{
    int i = 0;
    object oCreature;

    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);

    for(i = ASSOCIATE_TYPE_ANIMALCOMPANION; i <= ASSOCIATE_TYPE_DOMINATED; i++)
    {
        oCreature = GetAssociate(i,oPC);
        if(oCreature != OBJECT_INVALID)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oCreature, 10.0);
        }
    }

    int h = 1;
    object oHench = GetHenchman(oPC, h);
    while(oHench != OBJECT_INVALID)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oHench, 10.0);
        h++;
        oHench = GetHenchman(oPC, h);
    }
}

void ahcJumpAssociateToLocation(object oPC)
{
    object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    object oWaypoint = GetWaypointByTag("wp_maze_hench");

    effect eSleep = EffectVisualEffect(VFX_IMP_SLEEP);

    if(oAnimal != OBJECT_INVALID)
    {
        AssignCommand(oAnimal, ClearAllActions());
        AssignCommand(oAnimal, ActionJumpToLocation(GetLocation(oWaypoint)));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSleep, oAnimal, 30.0);
        AssignCommand(oAnimal, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,30.0));
    }
    if(oDominated != OBJECT_INVALID)
    {
        DestroyObject(oDominated);
        //AssignCommand(oDominated, ClearAllActions());
       // AssignCommand(oDominated, ActionJumpToLocation(GetLocation(oWaypoint)));
       // ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSleep, oDominated, 30.0);
       // AssignCommand(oDominated, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,30.0));
    }
    if(oFamiliar != OBJECT_INVALID)
    {
        AssignCommand(oFamiliar, ClearAllActions());
        AssignCommand(oFamiliar, ActionJumpToLocation(GetLocation(oWaypoint)));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSleep, oFamiliar, 30.0);
        AssignCommand(oFamiliar, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,30.0));
    }
    if(oSummoned != OBJECT_INVALID)
    {
        AssignCommand(oSummoned, ClearAllActions());
        AssignCommand(oSummoned, ActionJumpToLocation(GetLocation(oWaypoint)));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSleep, oSummoned, 30.0);
        AssignCommand(oSummoned, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,30.0));
    }

    int i = 1;
    object oHench = GetHenchman(oPC, i);
    while(oHench != OBJECT_INVALID)
    {
        AssignCommand(oHench, ClearAllActions());
        AssignCommand(oHench, ActionJumpToLocation(GetLocation(oWaypoint)));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSleep, oHench, 30.0);
        AssignCommand(oHench, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,30.0));
        DelayCommand(10.0,HenchmanFire(oHench, oPC));
        i++;
        oHench = GetHenchman(oPC, i);
    }
}

void main()
{
    object oPC = GetEnteringObject();

    if (!(GetIsPC(oPC))) return;
    if (GetLocalInt(OBJECT_SELF,"fired")==1) return;

    object oPettywick = GetObjectByTag("ac_pettywick");
    object oDummyPettwick = GetObjectByTag("DummyPettywick");

    SetLocalInt(OBJECT_SELF,"fired",1);
    SetLocalInt(oPC, "been_in_maze", 1);
    SetLocalInt(oPettywick, "has_met_pc", 1);

    InvisFollowers(oPC);
    ahcJumpAssociateToLocation(oPC);
    FadeFromBlack(oPC);

    DelayCommand(1.0, AssignCommand(oPC, SetFacing(DIRECTION_EAST)));
    DelayCommand(1.2, AssignCommand(oPC, SetCameraFacing(0.0, 15.0)));
    DelayCommand(1.5, AssignCommand(oDummyPettwick, ActionStartConversation(oPC)));
}
