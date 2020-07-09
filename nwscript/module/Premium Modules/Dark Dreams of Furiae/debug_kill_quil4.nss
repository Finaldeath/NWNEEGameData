#include "ddf_util"

void main()
{
    debug("-- Try To Kill Quillian over several days (6).");

    IncrementDay(); // 2
    IncrementDay(); // 3
    IncrementDay(); // 4 - trying now
    IncrementDay(); // 5 - trying now
    SetLocalInt(GetModule(), "ddf_quill_on_street", TRUE);
    IncrementDay(); // 6 - trying now
}
