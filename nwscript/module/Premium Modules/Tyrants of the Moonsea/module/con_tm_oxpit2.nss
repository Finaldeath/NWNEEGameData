// oxpit tavern: returns true while veris is alive

int StartingConditional()
{
    object oVeris = GetNearestObjectByTag("Veris");
    return GetIsObjectValid(oVeris);
}
