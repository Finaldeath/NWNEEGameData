
/*
   dla_trigbats
   gaoneng              March 5, 2006

   plug in trigger's OnEnter and play

   generates between 1 to 8 bats :)
   //Modified 5th March, B W-Husey (tweaks for in game - added sound)
   // Place with a batsound
*/

void main()
{
   object self = OBJECT_SELF,
          pc = GetEnteringObject();

   if (!GetIsPC(pc)) return; // if entering object is NOT pc, nothing happens (ok to fire it also if DM, etc)

   if (GetLocalInt(self, "GN_BATDELAY")) return; // minimum 6 seconds between each sequence
   SetLocalInt(self, "GN_BATDELAY", TRUE);       // so it doesn't get triggered repeatedly if PC walks to and fro
   DelayCommand(6.0, DeleteLocalInt(self, "GN_BATDELAY"));

   vector pos = GetPosition(pc) + Vector(0.0, 0.0, 3.5); // bats fly 3.5 meters above ground
   float facing = IntToFloat(Random(360)); // generate 2 random locations, with pc always near center
   object area = GetArea(self);
   object emit = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", Location(area, pos + IntToFloat(15 + d4())*AngleToVector(facing), facing));
   location target = Location(area, pos + IntToFloat(20 + d4())*AngleToVector(facing - 130.0 - IntToFloat(d100())), facing);

   int i, j = d6()+2; // randomly generate 3 to 8 bats
   for (i = 0; i < j; i++)
   {
       AssignCommand(emit, DelayCommand(IntToFloat(i)*0.2, ActionCastSpellAtLocation(1607, target, METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
   }
    object oSound = GetNearestObjectByTag("Batsound");
    SoundObjectPlay(oSound);

   DestroyObject(emit, 4.0);
}

