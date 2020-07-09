//::///////////////////////////////////////////////
//:: odmg_ac_surrendr
//:: NPC surrenders when damaged to below x hitpoints
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: November 11, 2005
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void ahcPeacefulFollowers2(object o1, object oPC)
{
object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);

if(oAnimal != OBJECT_INVALID)
{
SetIsTemporaryFriend(o1, oAnimal);
AdjustReputation(oAnimal,o1,100);
AdjustReputation(o1,oAnimal,100);
AssignCommand(oAnimal, ClearAllActions(TRUE));
}
if(oDominated != OBJECT_INVALID)
{
SetIsTemporaryFriend(o1, oDominated);
AdjustReputation(oDominated,o1,100);
AdjustReputation(o1,oDominated,100);
AssignCommand(oDominated, ClearAllActions(TRUE));

}
if(oFamiliar != OBJECT_INVALID)
{
SetIsTemporaryFriend(o1, oFamiliar);
AdjustReputation(oFamiliar,o1,100);
AdjustReputation(o1,oFamiliar,100);
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
        AdjustReputation(oHench,o1,100);
        AdjustReputation(o1,oHench,100);
        ahcPeacefulFollowers2(OBJECT_SELF,oHench);
        AssignCommand(oHench, ClearAllActions(TRUE));
        i++;
        oHench = GetHenchman(oPC, i);
    }

if(oAnimal != OBJECT_INVALID)
{
SetIsTemporaryFriend(o1, oAnimal);
AdjustReputation(oAnimal,o1,100);
AdjustReputation(o1,oAnimal,100);
AssignCommand(oAnimal, ClearAllActions(TRUE));
}
if(oDominated != OBJECT_INVALID)
{
SetIsTemporaryFriend(o1, oDominated);
AdjustReputation(oDominated,o1,100);
AdjustReputation(o1,oDominated,100);
AssignCommand(oDominated, ClearAllActions(TRUE));

}
if(oFamiliar != OBJECT_INVALID)
{
SetIsTemporaryFriend(o1, oFamiliar);
AdjustReputation(oFamiliar,o1,100);
AdjustReputation(o1,oFamiliar,100);
AssignCommand(oFamiliar, ClearAllActions(TRUE));
}
}

//============================================
void ahcRemove(object o7)
{
    effect eLoop7=GetFirstEffect(o7);
    while (GetIsEffectValid(eLoop7))
    {
        RemoveEffect(o7, eLoop7);
        eLoop7=GetNextEffect(o7);
    }
}

void ahcFriend(object o1)
{
    object oPC = GetFirstPC();
    ChangeToStandardFaction(o1, STANDARD_FACTION_MERCHANT);
    AdjustReputation(oPC, o1, 60);
    SetIsTemporaryFriend(oPC, o1);
    AssignCommand(oPC, ClearAllActions(TRUE));
    ahcPeacefulFollowers(OBJECT_SELF, oPC);
}
//============================================

void main()
{
    if (GetCurrentHitPoints(OBJECT_SELF)< 21 &&
        GetLocalInt(OBJECT_SELF, "nSurrendered") == 0)
    {
    SetLocalInt(OBJECT_SELF, "nSurrendered", 1);
    object oPC = GetNearestCreature( CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC );
    //SetCutsceneMode(oPC, TRUE);
    AssignCommand(oPC, ClearAllActions(TRUE));
    ClearAllActions(TRUE);
    SurrenderToEnemies();
    //ClearPersonalReputation(oPC, OBJECT_SELF);
   // ahcFriend(OBJECT_SELF);
   // ahcRemove(OBJECT_SELF);

    if (!GetIsEnemy(oPC, OBJECT_SELF))
    {
        // prevent PC or pals from accidentally killing me
        SetPlotFlag(OBJECT_SELF, TRUE);
        DelayCommand(10.0, SetPlotFlag(OBJECT_SELF, FALSE));
    }

   // SetLocalInt(OBJECT_SELF,"start_convo",1);
    DelayCommand(2.0, ActionStartConversation(oPC, "at_dragsurrendr"));
    }
}
