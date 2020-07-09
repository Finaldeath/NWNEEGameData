//Zhentil Keep slave is freed from captivity

void main()
{
    GiveXPToCreature(GetFirstPC(), 50);
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
