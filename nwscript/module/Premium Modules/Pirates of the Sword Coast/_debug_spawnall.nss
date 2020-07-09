void main()
{
    object oModule = GetModule();
    ExecuteScript("_debug_spawnpoly", oModule);
    DelayCommand(0.5, ExecuteScript("_debug_spawngarm", oModule));
    DelayCommand(1.0, ExecuteScript("_debug_spawnnis2", oModule));
}
