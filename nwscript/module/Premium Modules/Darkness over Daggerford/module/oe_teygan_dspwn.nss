void main()
{
    object oEntering=GetEnteringObject();
    if(GetTag(oEntering)=="db_teygan")
    {
        DestroyObject(oEntering);
    }
}
