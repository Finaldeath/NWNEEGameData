//::///////////////////////////////////////////////
//:: FileName os_ac_dead
//:: Make creature dead on spawn
//:: Must have creature leave lootable corpse for suitable time
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/16/2005 2:16:59 PM
//:://////////////////////////////////////////////
void main()
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDeath(), OBJECT_SELF);
}

