// January 2006
// B W-Husey
// Trigger spawns undead at specific points with effects, but only the second time
// the PC enters it (as long as 30 seconds after first time)
#include "cu_functions"
void main()
{
    object oPC=GetEnteringObject();
    int nTimer = GetLocalInt(OBJECT_SELF,"nTimer");
    if (GetIsDefPC(oPC) && nTimer == 0) //only check if is PC and >30 seconds since last entered
    {
        SetLocalInt(OBJECT_SELF,"nTimer",1);
        DelayCommand(30.0,SetLocalInt(OBJECT_SELF,"nTimer",0)); // reset timer in 30 seconds
        int nCounter = GetLocalInt(OBJECT_SELF,"nCounter");//number of times entered
        if (nCounter ==1)
        {

            effect eSpawn = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
            location lSpawn1 = GetLocation(GetWaypointByTag("WP_PFULSpawn1"));
            location lSpawn2 = GetLocation(GetWaypointByTag("WP_PFULSpawn2"));
            location lSpawn3 = GetLocation(GetWaypointByTag("WP_PFULSpawn3"));
            location lSpawn4 = GetLocation(GetWaypointByTag("WP_PFULSpawn4"));
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSpawn, lSpawn1);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSpawn, lSpawn2);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSpawn, lSpawn3);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSpawn, lSpawn4);
            CreateObject(OBJECT_TYPE_CREATURE,"nw_skelwarr02",lSpawn1,FALSE);
            CreateObject(OBJECT_TYPE_CREATURE,"nw_skelwarr02",lSpawn2,FALSE);
            CreateObject(OBJECT_TYPE_CREATURE,"nw_skelwarr02",lSpawn3,FALSE);
            CreateObject(OBJECT_TYPE_CREATURE,"nw_skelwarr01",lSpawn4,FALSE);
            DestroyObject(OBJECT_SELF);
        }
        else SetLocalInt(OBJECT_SELF,"nCounter",GetLocalInt(OBJECT_SELF,"nCounter")+1);
        //***************debug line
//        SendMessageToPC(oPC,"Counter = "+IntToString(nCounter));
   }
        //***************debug line
//        SendMessageToPC(oPC,"Timer = "+IntToString(nTimer));
}
