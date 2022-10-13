permissionset 50100 "CLIP Courses"
{
    CaptionML = ENU = 'Courses', ESP = 'Cursos';
    Assignable = true;
    Permissions =
        tabledata "CLIP Course" = RIMD,
        tabledata "CLIP Course Edition" = RIMD,
        tabledata "CLIP Courses Setup" = RIMD,
        table "CLIP Course" = X,
        table "CLIP Course Edition" = X,
        table "CLIP Courses Setup" = X,
        page "CLIP Course" = X,
        page "CLIP Course Editions" = X,
        page "CLIP Courses" = X,
        page "CLIP Courses Setup" = X;
}