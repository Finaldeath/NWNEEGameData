#include "ddf_util"

void main()
{
    debug("-- Try To Kill Quillian over several days (4).");

    IncrementDay(); // 2
    IncrementDay(); // 3
    SetLocalInt(GetModule(), "ddf_quill_on_street", TRUE);
    IncrementDay(); // 4 - trying now
    IncrementDay(); // 5 - trying now
    IncrementDay(); // 6 - trying now
}
