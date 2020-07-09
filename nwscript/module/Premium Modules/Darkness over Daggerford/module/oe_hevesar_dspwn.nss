void main()
{
    object oEntering=GetEnteringObject();
    if(GetTag(oEntering)=="db_hevesar_met")
    {
        DestroyObject(oEntering);
    }
    else if(GetTag(oEntering)=="db_hevesar_new")
    {
        DestroyObject(oEntering);
    }
}
