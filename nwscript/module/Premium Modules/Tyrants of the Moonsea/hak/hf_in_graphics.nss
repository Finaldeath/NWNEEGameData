void DrawPoint(object oArea, float x, float y, float z, int vfx)
{
    location lLoc = Location(oArea, Vector(x, y, z), 0.0);
    effect eVfx = EffectVisualEffect(vfx);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVfx, lLoc);
}

void DrawCircle(location lLoc, float r, int vfx)
{
    object oArea = GetAreaFromLocation(lLoc);
    vector v = GetPositionFromLocation(lLoc);
    float xCenter = v.x;
    float yCenter = v.y;
    float zCenter = v.z;
    float y;
    int x;
    int xMax = FloatToInt(r);
    for (x=1; x<=xMax; x++)
    {
        y = sqrt(r*r - x*x);
        DrawPoint(oArea, (xCenter+x), (yCenter+y), zCenter, vfx);
        DrawPoint(oArea, (xCenter+y), (yCenter+x), zCenter, vfx);
        DrawPoint(oArea, (xCenter+y), (yCenter-x), zCenter, vfx);
        DrawPoint(oArea, (xCenter+x), (yCenter-y), zCenter, vfx);
        DrawPoint(oArea, (xCenter-x), (yCenter-y), zCenter, vfx);
        DrawPoint(oArea, (xCenter-y), (yCenter-x), zCenter, vfx);
        DrawPoint(oArea, (xCenter-y), (yCenter+x), zCenter, vfx);
        DrawPoint(oArea, (xCenter-x), (yCenter+y), zCenter, vfx);
    }
}

void DrawLineVert(location lStart, int nVfx, int nLength=10)
{
    object oArea = GetAreaFromLocation(lStart);
    vector vPos = GetPositionFromLocation(lStart);
    int i;
    for (i=1; i<=nLength; i++)
    {
        vector vPos2 = Vector(vPos.x, vPos.y, 1.0*i);
        location lLoc2 = Location(oArea, vPos2, 0.0);
        DelayCommand(0.1*i, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(nVfx), lLoc2));
    }
}

