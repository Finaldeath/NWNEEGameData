// pump out mephits when one dies

void main()
{
    int nEvent = GetUserDefinedEventNumber();
    if (nEvent == 1)
    {
        ExecuteScript("pl_devgenerat_hb", OBJECT_SELF);
    }
}
