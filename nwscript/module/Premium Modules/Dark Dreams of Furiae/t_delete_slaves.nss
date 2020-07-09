void main()
{
    object oTarget = GetEnteringObject();
    if(oTarget == OBJECT_INVALID) return;

    if(GetTag(oTarget) != "Slave_Undercity") return;

    DestroyObject(oTarget, 0.0);
}
