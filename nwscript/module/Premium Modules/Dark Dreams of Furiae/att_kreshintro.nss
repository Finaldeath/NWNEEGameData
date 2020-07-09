void main()
{
    if (GetIsPC(GetEnteringObject()))
    {
        if (GetLocalInt(GetModule(), "ddf_guarded_warehouse_knowledge") && !GetLocalInt(GetModule(), "ddf_guarded_warehouse_secret_door"))
        {
            AssignCommand(GetObjectByTag("Kresh"), SpeakString("Pssst... hey, berk. C'mere."));
        }
    }
}
