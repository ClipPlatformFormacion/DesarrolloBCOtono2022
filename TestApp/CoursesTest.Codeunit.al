codeunit 50140 "CLIP Courses Test"
{
    Subtype = Test;

    [Test]
    procedure SelectCourseOnSalesLine()
    var
        Course: Record "CLIP Course";
    begin
        // [Scenario] Se puede seleccionar un curso en una línea de venta

        // [Given] Un curso configurado con: grupos contables
        //         Un documento de venta

        // [When] Seleccionamos el curso en una línea venta

        // [Then] La línea de venta tiene la Nombre del curso, el precio y los grupos contables
    end;
}