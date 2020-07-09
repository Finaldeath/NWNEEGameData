// January 2006
// B W-Husey
// Third wave of Witch Lord's forces arrive.
// The Witch Lord 'teleports out'

/*
void ActionKill(object oKill = OBJECT_INVALID)
{
    SetImmortal(oKill,FALSE);
    DestroyObject(oKill);
}
*/

void main()
{
    location lLeft  = GetLocation(GetWaypointByTag("WP_EnemyLeft"));
    location lRight = GetLocation(GetWaypointByTag("WP_EnemyRight"));
    int nCount=0;
    object oWitch = GetLocalObject(GetAreaFromLocation(lLeft), "BattleWL");

    while (nCount < 2)
      {
             CreateObject(OBJECT_TYPE_CREATURE,"BattleHGS",lLeft,FALSE,"EnemyLeft");
             CreateObject(OBJECT_TYPE_CREATURE,"BattleHGS",lLeft,FALSE,"EnemyRight");
             CreateObject(OBJECT_TYPE_CREATURE,"BattleCurst",lLeft,FALSE,"EnemyLeft");
        nCount++;
      }
             CreateObject(OBJECT_TYPE_CREATURE,"BattleCurst",lLeft,FALSE,"EnemyRight");
             CreateObject(OBJECT_TYPE_CREATURE,"nightmarebattle",lLeft,FALSE,"EnemyLeft");
             CreateObject(OBJECT_TYPE_CREATURE,"nightmarebattle",lLeft,FALSE,"EnemyRight");

    CreateObject(OBJECT_TYPE_CREATURE,"BattleHGL",lLeft,FALSE,"EnemyLeft");
    CreateObject(OBJECT_TYPE_CREATURE,"BattleHGW",lLeft,FALSE,"EnemyLeft");
//    CreateObject(OBJECT_TYPE_CREATURE,"BattleSkel",lLeft,FALSE,"EnemyRight");

//    effect eVis1 = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
//    effect eVis2 = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
//    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis1,oWitch);
//    DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis1,oWitch));
//    DelayCommand(2.6,ActionKill(oWitch));

}
