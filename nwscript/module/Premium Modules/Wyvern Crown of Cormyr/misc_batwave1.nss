// January 2006
// B W-Husey
// First wave of Witch Lord's forces arrive.
// Few but powerful to keep AI load down

void main()
{
    location lLeft = GetLocation(GetWaypointByTag("WP_EnemyLeft"));
    location lRight = GetLocation(GetWaypointByTag("WP_EnemyRight"));
    int nCount=0;

    while (nCount < 2)
      {
             CreateObject(OBJECT_TYPE_CREATURE,"BattleOS",lLeft,FALSE,"EnemyLeft");
             CreateObject(OBJECT_TYPE_CREATURE,"BattleOS",lRight,FALSE,"EnemyRight");
            CreateObject(OBJECT_TYPE_CREATURE,"BattleHGS",lLeft,FALSE,"EnemyLeft");
            CreateObject(OBJECT_TYPE_CREATURE,"BattleHGS",lRight,FALSE,"EnemyRight");
            CreateObject(OBJECT_TYPE_CREATURE,"BattleHGS",lRight,FALSE,"EnemyRight");
        nCount++;
      }
             CreateObject(OBJECT_TYPE_CREATURE,"BattleOL",lLeft,FALSE,"EnemyLeft");
             CreateObject(OBJECT_TYPE_CREATURE,"BattleHGW",lLeft,FALSE,"EnemyLeft");
             object oMage = CreateObject(OBJECT_TYPE_CREATURE,"BattleMage",lRight,FALSE,"EnemyRight");
             CreateObject(OBJECT_TYPE_CREATURE,"BattleHGL",lLeft,FALSE,"EnemyLeft");
             CreateObject(OBJECT_TYPE_CREATURE,"BattleHGiant",lLeft,FALSE,"EnemyLeft");
             CreateObject(OBJECT_TYPE_CREATURE,"BattleHGiant",lLeft,FALSE,"EnemyRight");

    DelayCommand(2.0,AssignCommand(oMage,ActionCastSpellAtObject(SPELL_STONESKIN,OBJECT_SELF,METAMAGIC_EXTEND,TRUE,15,PROJECTILE_PATH_TYPE_DEFAULT,TRUE)));
}
