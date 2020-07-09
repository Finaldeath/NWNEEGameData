//::///////////////////////////////////////////////
//:: ac_o2_skeleton
//:: Skeleton pops out of sarcophagus
//:://////////////////////////////////////////////
/*
   Turns the placeable into a skeleton
   if a player comes near enough.
*/
//:://////////////////////////////////////////////
//:: Created By:   Anya Clancy (based on nw_o2_skeleton)
//:: Created On:   November 27, 2002
//:://////////////////////////////////////////////
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

void main()
{
   if (GetLocalInt(OBJECT_SELF, "fired")==1) return;
   object oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
   if (GetIsObjectValid(oCreature) == TRUE && GetDistanceToObject(oCreature) < 5.0)
   {
    SetLocalInt(OBJECT_SELF, "fired", 1);
    effect eMind = EffectVisualEffect(515);
    string sCreature = "NW_SKELWARR01";
    // * 10% chance of a skeleton chief instead
    if (Random(100) > 90)
    {
        sCreature = "NW_SKELCHIEF";
    }
    location lLoc = GetLocation(OBJECT_SELF);
    object oSpawn = CreateObject(OBJECT_TYPE_CREATURE, sCreature, GetLocation(OBJECT_SELF));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMind, OBJECT_SELF, 4.0);
    DelayCommand(3.0, ahcRemove(OBJECT_SELF));
    PlayAnimation(ANIMATION_PLACEABLE_OPEN);
   }
}
