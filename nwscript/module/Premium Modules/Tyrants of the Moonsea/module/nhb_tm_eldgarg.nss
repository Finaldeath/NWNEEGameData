void CreateGargoyle(object oPC)
{
object oTarget = GetObjectByTag( "GreaterGargoyle" );

object oArea = GetArea( oTarget );

vector vPosition = GetPosition( oTarget );

float fFacing = GetFacing( oTarget );

location lSpawn = Location( oArea, vPosition, fFacing+180.0 );

object oGargoyle = CreateObject(OBJECT_TYPE_PLACEABLE, "gargoylestatue", lSpawn);

}
void main()

{
object oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

if (GetIsObjectValid(oCreature) == TRUE && GetDistanceToObject(oCreature) > 10.0)

{
CreateGargoyle(oCreature);

SetPlotFlag(OBJECT_SELF, FALSE);

DestroyObject(OBJECT_SELF, 0.5);
   }
}

