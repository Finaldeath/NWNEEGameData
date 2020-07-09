// store index,arg into a variable

void main()
{
    int nChoice = GetLocalInt(OBJECT_SELF, "HF_ARG");
    int nQuestion = GetLocalInt(OBJECT_SELF, "nBranch");
    string sVar = "nChoice_" + IntToString(nQuestion);
    SetLocalInt(OBJECT_SELF, sVar, nChoice);
}
