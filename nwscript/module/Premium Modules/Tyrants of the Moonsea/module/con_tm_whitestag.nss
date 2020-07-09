//Is the white stag's Gray Render guardian still alive

int StartingConditional()
{
    object oRender = GetNearestObjectByTag("NW_GRAYREND", OBJECT_SELF);

    if(GetIsObjectValid(oRender) && !GetIsDead(oRender))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
