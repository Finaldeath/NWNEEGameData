// March 2006
// B W-Husey
// Wyvernvapour leaves

void main()
{
    SetPlotFlag(OBJECT_SELF,FALSE);
    effect eDis = EffectDisappear();
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDis,OBJECT_SELF);
    SetCutsceneMode(GetPCSpeaker(),FALSE);
}
