// January 2006
// B W-Husey
// Entering object must save vs disease or be diseased.
// As less spores are released the save gets easier for anyone who enters the trigger
// It doesn't affect snakes

void main()
{
    object oPC = GetEnteringObject();
    if ((GetStringLeft(GetTag(oPC),5)!= "Black") && (GetStringLeft(GetTag(oPC),5)!= "Spitt"))
    {
        object oMush = GetNearestObjectByTag("DiseaseMush");
        int nDC = GetLocalInt(oMush,"nDisease");
        effect eVis = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
        if (FortitudeSave(oPC,nDC,SAVING_THROW_TYPE_DISEASE)==0)
        {
            effect eDis = EffectDisease(DISEASE_GHOUL_ROT);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDis,oPC,200.0);
        }
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oMush);
        SetLocalInt(oMush,"nDisease",nDC-1);
        if (nDC<3) DestroyObject(OBJECT_SELF);
        }
}
