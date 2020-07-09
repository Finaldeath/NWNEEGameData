void main()
{
    object oMaster = GetMaster(OBJECT_SELF);
    if (oMaster != OBJECT_INVALID)
    {
        RemoveHenchman(oMaster);
    }
    DestroyObject(OBJECT_SELF);
}
