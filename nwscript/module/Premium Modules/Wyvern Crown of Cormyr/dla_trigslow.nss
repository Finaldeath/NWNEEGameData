// January 2006
// B W-Husey
// dla_trigslow
// Entering object must save vs disease or be slowed.
// As less spores are released the save gets easier for anyone who enters the trigger
// It doesn't affect snakes

void main()
{
    object oPC = GetEnteringObject();
    if ((GetStringLeft(GetTag(oPC),5)!= "Black") && (GetStringLeft(GetTag(oPC),5)!= "Spitt"))
    {
        object oMush = GetNearestObjectByTag("SlowMush");
        int nDC = GetLocalInt(oMush,"nDisease");
        effect eVis = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
        if (FortitudeSave(oPC,nDC,SAVING_THROW_TYPE_DISEASE)==0)
        {
            effect eDis = EffectSlow();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDis,oPC,30.0);
        }
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oMush);
        SetLocalInt(oMush,"nDisease",nDC-1);
        if (nDC<3) DestroyObject(OBJECT_SELF);
        }
}
