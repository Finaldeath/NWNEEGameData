// oxpit tavern: random dialog before veris has gone hostile

int StartingConditional()
{
    object oVeris = GetNearestObjectByTag("Veris");
    if (!GetIsObjectValid(oVeris))
        return FALSE;
    return (d4() == 1);
}
