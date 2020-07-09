void main()
{
object oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

if (GetIsObjectValid(oCreature) == TRUE && GetDistanceToObject(oCreature) < 3.0)

{
effect eMind = EffectVisualEffect(VFX_COM_CHUNK_STONE_SMALL);

object oTarget = OBJECT_SELF;

object oArea = GetArea( oTarget );

vector vPosition = GetPosition( oTarget );

float fFacing = GetFacing( oTarget );

location lSpawn = Location( oArea, vPosition, fFacing+180.0 );

object oGargoyle = CreateObject(OBJECT_TYPE_CREATURE, "eldergargoyle", lSpawn);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eMind, OBJECT_SELF);

PlaySound("as_cv_claybreak2");

SetPlotFlag(OBJECT_SELF, FALSE);

DestroyObject(OBJECT_SELF, 0.5);
   }
}

