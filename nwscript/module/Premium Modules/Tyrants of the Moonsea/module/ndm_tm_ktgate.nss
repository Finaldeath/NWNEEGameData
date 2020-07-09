//Play wood breaking sounds and damage effects when Kur-Tharsu Main Gate is damaged
void main()
{
     object oGate = GetNearestObjectByTag("KTPortcullis");

     //We want to apply effects to middle of gate
     vector vGate = GetPosition(oGate);
     vGate.z +=2.0;
     location lGate = Location(GetArea(oGate), vGate, 90.0);

     ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_SPARK_LARGE), lGate);
     PlaySound("as_cv_woodbreak1");
}
