//::///////////////////////////////////////////////
//:: FileName ou_ac_plc_telep
//:: Teleport to a waypoint with the same tag as the placeable
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/2/2005 11:59:20 PM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void ahcRemove(object o7)
{
effect eLoop7=GetFirstEffect(o7);
while (GetIsEffectValid(eLoop7))
   {
   if (GetEffectType(eLoop7)== EFFECT_TYPE_VISUALEFFECT)
         RemoveEffect(o7, eLoop7);
      eLoop7=GetNextEffect(o7);
   }
}
//============================================
void ahcPeacefulFollowers2(object o1, object oPC)
{
object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);

if(oAnimal != OBJECT_INVALID)
{
SetIsTemporaryFriend(o1, oAnimal);
//AdjustReputation(oAnimal,o1,100);
//AdjustReputation(o1,oAnimal,100);
AssignCommand(oAnimal, ClearAllActions(TRUE));
}
if(oDominated != OBJECT_INVALID)
{
SetIsTemporaryFriend(o1, oDominated);
//AdjustReputation(oDominated,o1,100);
//AdjustReputation(o1,oDominated,100);
AssignCommand(oDominated, ClearAllActions(TRUE));

}
if(oFamiliar != OBJECT_INVALID)
{
SetIsTemporaryFriend(o1, oFamiliar);
//AdjustReputation(oFamiliar,o1,100);
//AdjustReputation(o1,oFamiliar,100);
AssignCommand(oFamiliar, ClearAllActions(TRUE));
}
}
//============================================
void ahcPeacefulFollowers(object o1, object oPC)
{
object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);


int i = 1;
    object oHench = GetHenchman(oPC, i);
    while(oHench != OBJECT_INVALID)
    {
        SetIsTemporaryFriend(o1, oHench);
        //AdjustReputation(oHench,o1,100);
        //AdjustReputation(o1,oHench,100);
        ahcPeacefulFollowers2(OBJECT_SELF,oHench);
        AssignCommand(oHench, ClearAllActions(TRUE));
        i++;
        oHench = GetHenchman(oPC, i);
    }

if(oAnimal != OBJECT_INVALID)
{
SetIsTemporaryFriend(o1, oAnimal);
//AdjustReputation(oAnimal,o1,100);
//AdjustReputation(o1,oAnimal,100);
AssignCommand(oAnimal, ClearAllActions(TRUE));
}
if(oDominated != OBJECT_INVALID)
{
SetIsTemporaryFriend(o1, oDominated);
//AdjustReputation(oDominated,o1,100);
//AdjustReputation(o1,oDominated,100);
AssignCommand(oDominated, ClearAllActions(TRUE));

}
if(oFamiliar != OBJECT_INVALID)
{
SetIsTemporaryFriend(o1, oFamiliar);
//AdjustReputation(oFamiliar,o1,100);
//AdjustReputation(o1,oFamiliar,100);
AssignCommand(oFamiliar, ClearAllActions(TRUE));
}
}
//============================================
void ahcFriend(object o1)
{
    object oPC = GetFirstPC();
    ChangeToStandardFaction(o1,STANDARD_FACTION_MERCHANT);
    //AdjustReputation(oPC,o1,60);
    SetIsTemporaryFriend(oPC, o1);
    //AssignCommand(oPC,ClearAllActions(TRUE));
    ahcPeacefulFollowers(OBJECT_SELF,oPC);
}

void main()
{
    object oPC = GetLastUsedBy();
    object oWaypoint = OBJECT_SELF;

    if (!GetIsPC(oPC))
    {
        return;
    }

    AssignCommand(oPC, ClearAllActions(TRUE));
    DelayCommand(1.0,
        AssignCommand(oPC, ActionJumpToObject(GetWaypointByTag(GetTag(oWaypoint)))));

    //ahcRemove(oJonas);
    //ahcFriend(oJonas);
    //ahcFriend(oJunior);
    //SetCreatureAppearanceType(oJunior, APPEARANCE_TYPE_HUMAN);
    //SetLocalInt(oJonas, "no_banter", 0);
    //SetLocalInt(oJunior, "no_banter", 0);
}
